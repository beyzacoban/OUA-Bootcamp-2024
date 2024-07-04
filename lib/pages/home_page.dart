import 'package:flutter/material.dart';
import 'project_addition_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> _projects = [];

  void _addProject(String title, String description) {
    setState(() {
      _projects.add({'title': title, 'description': description});
    });
  }

  void _deleteProject(int index) {
    setState(() {
      _projects.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project"),
      ),
      body: _projects.isEmpty
          ? const Center(child: Text("No projects added yet."))
          : ListView.builder(
              itemCount: _projects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_projects[index]['title']!),
                  subtitle: Text(_projects[index]['description']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteProject(index);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProjectAdditionPage(addProject: _addProject),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
