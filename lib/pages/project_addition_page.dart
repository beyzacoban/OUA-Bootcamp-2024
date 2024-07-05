import 'package:flutter/material.dart';

class ProjectAdditionPage extends StatelessWidget {
  final Function(String, String) addProject;

  const ProjectAdditionPage({Key? key, required this.addProject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Project Idea"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Project Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Project Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addProject(titleController.text, descriptionController.text);
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectSelectionPage extends StatelessWidget {
  final List<String> projects;
  final Function(String) joinProject;

  const ProjectSelectionPage(
      {Key? key, required this.projects, required this.joinProject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a Project"),
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return ListTile(
            title: Text(project),
            onTap: () {
              joinProject(project);
              Navigator.pop(context);
            },
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}
