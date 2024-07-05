import 'package:flutter/material.dart';
import 'project_addition_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> _myProjects = [];
  final List<Map<String, String>> _friendsProjects = [];
  final List<Map<String, String>> _exploreProjects = [
    {
      'title': 'Fitness Tracker',
      'description': 'An app to track fitness activities and progress.',
      'language': 'Kotlin',
      'duration': '3 months',
      'teamSize': '3'
    },
    {
      'title': 'Project Management App',
      'description':
          'A project management application to manage tasks and teams.',
      'language': 'Dart',
      'duration': '6 months',
      'teamSize': '4'
    },
    {
      'title': 'E-commerce Website',
      'description': 'An online platform to buy and sell products.',
      'language': 'JavaScript',
      'duration': '4 months',
      'teamSize': '5'
    },
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _addProject(String title, String description) {
    setState(() {
      _myProjects.add({
        'title': title,
        'description': description,
        'language': 'Unknown', // Default value
        'duration': 'Unknown', // Default value
        'teamSize': 'Unknown' // Default value
      });
    });
  }

  void _deleteProject(int index) {
    setState(() {
      _myProjects.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "My Projects"),
            Tab(text: "Friends' Projects"),
            Tab(text: "Explore"),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                // Profile sayfasına yönlendir
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Friends'),
              onTap: () {
                // Friends sayfasına yönlendir
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Settings sayfasına yönlendir
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyProjectsTab(),
          _buildProjectList(_friendsProjects),
          _buildProjectList(_exploreProjects),
        ],
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

  Widget _buildMyProjectsTab() {
    return _myProjects.isEmpty
        ? const Center(child: Text("No projects added yet."))
        : ListView.builder(
            itemCount: _myProjects.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_myProjects[index]['title']!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description: ${_myProjects[index]['description']!}'),
                    Text('Language: ${_myProjects[index]['language']!}'),
                    Text('Duration: ${_myProjects[index]['duration']!}'),
                    Text('Team Size: ${_myProjects[index]['teamSize']!}'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _myProjects.removeAt(index);
                    });
                  },
                ),
              );
            },
          );
  }

  Widget _buildProjectList(List<Map<String, String>> projects) {
    if (projects.isEmpty) {
      return const Center(child: Text("No projects added yet."));
    } else {
      return ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(projects[index]['title']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description: ${projects[index]['description']!}'),
                Text('Language: ${projects[index]['language']!}'),
                Text('Duration: ${projects[index]['duration']!}'),
                Text('Team Size: ${projects[index]['teamSize']!}'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  projects.removeAt(index);
                });
              },
            ),
          );
        },
      );
    }
  }
}
