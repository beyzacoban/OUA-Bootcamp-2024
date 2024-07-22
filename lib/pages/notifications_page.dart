import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int _unreadNotificationsCount = 9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  setState(() {
                    _unreadNotificationsCount = 0;
                  });
                },
              ),
              if (_unreadNotificationsCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Center(
                      child: Text(
                        '$_unreadNotificationsCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          _buildNotificationCard(
              "New project added!", "You have a new project in your list."),
          _buildNotificationCard(
              "Message from Bob", "Bob sent you a new message."),
          _buildNotificationCard("Project deadline approaching",
              "The deadline for 'Weather App' is near."),
          _buildNotificationCard(
              "Friend Request", "Kevin has sent you a friend request."),
          _buildNotificationCard(
              "Project Update", "The 'Task Manager' project has a new update."),
          _buildNotificationCard(
              "New Comment", "Alice commented on your 'Personal Blog' post."),
          _buildNotificationCard("App Update",
              "A new version of the app is available. Update now."),
          _buildNotificationCard(
              "Meeting Reminder", "Reminder: Team meeting at 3 PM today."),
          _buildNotificationCard("System Maintenance",
              "Scheduled maintenance will occur at midnight."),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(String title, String message) {
    return Card(
      color: const Color(0xFF37474F),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(title,
            style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        subtitle: Text(message,
            style: const TextStyle(fontSize: 16.0, color: Colors.white70)),
      ),
    );
  }
}
