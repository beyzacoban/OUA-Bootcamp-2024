import 'package:flutter/material.dart';
import 'chat_page.dart';

// StatefulWidget for displaying a list of friends with avatars
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
          title: const Text('Options',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF546E7A), // Dark gray background
          content: const Text('Select an action',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
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
                  style: TextStyle(color: Colors.white)),
            ),
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
              },
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.white)),
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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF546E7A),
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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF546E7A), // Dark gray background
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0, // Remove shadow for a cleaner look
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        itemCount: friendsList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF546E7A), // Dark gray background
              borderRadius: BorderRadius.circular(12.0), // Rounded corners
              boxShadow: [
                // Shadow for depth
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: CircleAvatar(
                backgroundColor: Colors.orange[300],
                child: Text(
                  friendsList[index]
                      [0], // Display the first letter of the friend's name
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                friendsList[index],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              trailing: Icon(Icons.chevron_right,
                  color: Colors.white.withOpacity(0.6)),
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
