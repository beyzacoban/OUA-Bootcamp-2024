import 'package:flutter/material.dart';
import 'chat_page.dart';

class FriendsPage extends StatelessWidget {
  final List<String> friends;

  const FriendsPage({Key? key, required this.friends}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(friends[index]),
            leading: const Icon(Icons.message),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(friendName: friends[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
