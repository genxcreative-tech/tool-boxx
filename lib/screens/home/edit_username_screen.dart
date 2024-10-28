import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class EditUsernameScreen extends StatelessWidget {
  final TextEditingController usernameController;

  EditUsernameScreen({Key? key, required this.usernameController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Edit Username"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              maxLength: 8,
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter your username",
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String newUsername = usernameController.text;
                if (newUsername.isNotEmpty) {
                  var box = Hive.box('main');
                  box.put('username', newUsername); // Save to Hive
                  Navigator.pop(context, newUsername); // Navigate back with the new username
                } else {
                  // Show a message if the username is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Username cannot be empty")),
                  );
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
