import 'package:flutter/material.dart';
import 'chat_page.dart';

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
    friendsList = widget.friends;
  }

  void _showOptionsDialog(BuildContext context, String friend) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Options'),
          content: Text('Select an action'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showConfirmationDialog(context, friend);
              },
              child: Text('Remove Friend'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(friendName: friend),
                  ),
                );
              },
              child: Text('Send Message'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, String friend) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you really want to remove this friend?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  friendsList.remove(friend);
                });
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
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
        title: const Text('Friends'),
      ),
      body: ListView.builder(
        itemCount: friendsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(friendsList[index]),
            leading: const Icon(Icons.message),
            onTap: () {
              _showOptionsDialog(context, friendsList[index]);
            },
          );
        },
      ),
    );
  }
}
