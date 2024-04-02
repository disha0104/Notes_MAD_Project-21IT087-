import 'package:flutter/material.dart';
import 'note.dart';

class NotesList extends StatelessWidget {
  final List<Note> notes;
  final void Function(BuildContext, Note) editNote;
  final void Function(BuildContext, Note) deleteNote; // Define the deleteNote parameter

  const NotesList({
    required this.notes,
    required this.editNote,
    required this.deleteNote, // Add deleteNote to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(note.title),
                subtitle: Text(note.content),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      editNote(context, note);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteNote(context, note); // Call the deleteNote function with the selected note
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

