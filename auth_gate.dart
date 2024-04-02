import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart'; // new
import 'package:flutter/material.dart';

import 'home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image showing the logo
        Container(
          width: MediaQuery.of(context).size.width, // Set container width to screen width
          child: Builder(
            builder: (BuildContext context) {
              return Image.asset(
                './images/logo.jpeg',
                height: 150, // Maintain aspect ratio
                fit: BoxFit.cover, // Cover the entire container
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  return Text('Error loading image');
                },
              );
            },
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.blueGrey, // Background color of the sign-in container
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0), // Add padding for spacing
                child: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SignInScreen(
                        providers: [
                          EmailAuthProvider(),
                          GoogleProvider(
                            clientId: "1077323013776-ttln6jhn77i8dfn2mnbbqgd1nf9a5e7g.apps.googleusercontent.com",
                          ), // new
                        ],
                        footerBuilder: (context, action) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text(
                              'By signing in, you agree to our terms and conditions.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        },
                      );
                    }
                    return const HomeScreen();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
