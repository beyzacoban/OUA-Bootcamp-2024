import 'package:flutter/material.dart';
import 'chat_page.dart';

// StatefulWidget for displaying a list of friends and allowing interactions
class FriendsPage extends StatefulWidget {
  final List<String> friends;

  const FriendsPage({Key? key, required this.friends}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  List<String> friendsList = [];

  @override
  void initState() {
    super.initState();
    friendsList =
        widget.friends; // Initialize with friends passed from the parent widget
  }

  // Function to show a dialog with options for a friend
  void _showOptionsDialog(BuildContext context, String friend) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Options', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF263238),
          content: const Text('Select an action',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showConfirmationDialog(context, friend);
              },
              child: const Text('Remove Friend',
                  style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      friendName: friend,
                    ),
                  ),
                );
              },
              child: const Text('Send Message',
                  style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
          ],
        );
      },
    );
  }

  // Function to show a confirmation dialog before removing a friend
  void _showConfirmationDialog(BuildContext context, String friend) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?',
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF263238),
          content: const Text('Do you really want to remove this friend?',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  friendsList.remove(friend);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Yes', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Friends',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF37474F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: friendsList.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF37474F),
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                friendsList[index],
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              leading: const Icon(Icons.message, color: Colors.white),
              onTap: () {
                _showOptionsDialog(context, friendsList[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
