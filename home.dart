import 'package:flutter/material.dart';
import 'note.dart';
import 'note_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<Note> notes = [];
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          NotesList(
            notes: notes,
            editNote: _editNote,
            deleteNote: _deleteNote,
          ),
          GridView.builder(
  itemCount: notes.length,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 8.0,
    mainAxisSpacing: 8.0,
  ),
  itemBuilder: (context, index) {
    final note = notes[index];
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(note.title),
          Text(note.content),
          Text(
            'Date: ${note.dateTime.year}-${note.dateTime.month}-${note.dateTime.day}',
            style: TextStyle(fontSize: 12.0, color: const Color.fromARGB(255, 26, 25, 25)),
          ),
          Text(
            'Time: ${note.dateTime.hour}:${note.dateTime.minute}:${note.dateTime.second}',
            style: TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 20, 20, 20)),
          ),
        ],
      ),
    );
  },
),


        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
  items: <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.note),
      label: 'Total Notes (${notes.length})',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: 'Profile',
    ),
  ],
  currentIndex: _selectedIndex,
  selectedItemColor: Colors.blue,
  onTap: _onItemTapped,
),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNote(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onItemTapped(int index) {
  if (index == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  } else {
    setState(() {
      _selectedIndex = index;
    });
  }
}

 void _addNote(BuildContext context) async {
  final Note? newNote = await showDialog<Note>(
    context: context,
    builder: (BuildContext context) {
      String title = '';
      String content = '';

      return AlertDialog(
        title: const Text('Add Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                title = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Content'),
              onChanged: (value) {
                content = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (title.isNotEmpty && content.isNotEmpty) {
                // Get the current date and time
                DateTime now = DateTime.now();

                // Create a new note with title, content, and current date and time
                Note newNote = Note(
                  title: title,
                  content: content,
                  dateTime: DateTime.now(),
                );

                // Close the dialog and return the new note
                Navigator.of(context).pop(newNote);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please enter both title and content.'),
                ));
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );

  if (newNote != null) {
    setState(() {
      notes.add(newNote);
    });
    // TODO: Add newNote to the database
  }
}

  void _editNote(BuildContext context, Note note) async {
  final editedNote = await showDialog<Note>(
    context: context,
    builder: (BuildContext context) {
      String editedTitle = note.title;
      String editedContent = note.content;

      return AlertDialog(
        title: Text('Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: TextEditingController(text: note.title),
              onChanged: (value) {
                editedTitle = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Content'),
              controller: TextEditingController(text: note.content),
              onChanged: (value) {
                editedContent = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (editedTitle.isNotEmpty && editedContent.isNotEmpty) {
                // Get the current date and time
                DateTime now = DateTime.now();

                // Create the edited note with the updated fields and current date and time
                Note editedNote = Note(
                  title: editedTitle,
                  content: editedContent,
                  dateTime: DateTime.now(),
                );

                Navigator.of(context).pop(editedNote);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter both title and content.'),
                  ),
                );
              }
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );

  if (editedNote != null) {
    final index = notes.indexWhere((n) => n == note);
    if (index != -1) {
      setState(() {
        notes[index] = editedNote;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Note edited successfully!')),
      );
    }
  }
}


  void _deleteNote(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Note'),
        content: Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                notes.removeWhere((n) => n == note);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Note deleted successfully!')),
              );
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 171, 205, 233),
              ),
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Notes'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                _showSignOutConfirmation(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement saving profile logic
                  String name = _nameController.text;
                  String email = _emailController.text;

                  // Validate name and email
                  if (name.isNotEmpty && email.isNotEmpty) {
                    // Save profile details
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profile saved successfully!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter both name and email.')),
                    );
                  }
                },
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSignOutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sign Out'),
        content: Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement sign out logic
              Navigator.of(context).pop(); // Close the dialog
              Navigator.pushReplacement( // Navigate to a "Logged Out" screen
                context,
                MaterialPageRoute(builder: (context) => LoggedOutScreen()),
              );
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

class LoggedOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          automaticallyImplyLeading: false, // Remove back button
        ),
        body: Center(
          child: Text(
            'You are logged out.',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
