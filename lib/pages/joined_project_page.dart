import 'package:flutter/material.dart';

class JoinedProjectsPage extends StatelessWidget {
  final List<String> joinedProjects;

  const JoinedProjectsPage({Key? key, required this.joinedProjects})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joined Projects'),
        backgroundColor: const Color(0xFF37474F),
      ),
      body: joinedProjects.isEmpty
          ? const Center(
              child: Text(
              "You haven't joined any projects yet.",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ))
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: joinedProjects.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color(0xFF455A64),
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(joinedProjects[index],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: const Text("Project details go here",
                        style: TextStyle(fontSize: 14)),
                  ),
                );
              },
            ),
    );
  }
}
