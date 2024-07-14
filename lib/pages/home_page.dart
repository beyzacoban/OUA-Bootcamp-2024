import 'package:flutter/material.dart';
import 'ai_assistant_page.dart';
import 'profile_page.dart';
import 'messages_page.dart';
import 'friends_page.dart';
import 'project_addition_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<String> _friends = ["Alice", "Bob", "Charlie", "Eve"];
  final List<Map<String, String>> _myProjects = [];
  final List<Map<String, dynamic>> _friendsProjects = [
    {
      'title': 'Weather App',
      'description': 'A real-time weather forecasting app.',
      'language': 'Flutter',
      'duration': '2 months',
      'teamSize': '2',
      'friendName': 'Eve',
      'joined': false
    },
    {
      'title': 'Recipe Finder',
      'description': 'An app to find recipes based on ingredients.',
      'language': 'Swift',
      'duration': '4 months',
      'teamSize': '5',
      'friendName': 'Charlie',
      'joined': false
    },
  ];
  final List<Map<String, dynamic>> _exploreProjects = [
    {
      'title': 'Meditation Guide',
      'description': 'An app to guide users through meditation sessions.',
      'language': 'Flutter',
      'duration': '3 months',
      'teamSize': '3',
      'joined': false
    },
    {
      'title': 'Travel Planner',
      'description': 'A platform to plan and share travel itineraries.',
      'language': 'React Native',
      'duration': '5 months',
      'teamSize': '4',
      'joined': false
    },
    {
      'title': 'Online Learning',
      'description': 'An e-learning platform with various courses.',
      'language': 'Python',
      'duration': '6 months',
      'teamSize': '6',
      'joined': false
    },
  ];

  final List<String> _joinedProjects = [];

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
      });
    });
  }

  void _deleteProject(int index) {
    setState(() {
      _myProjects.removeAt(index);
    });
  }

  void _joinProject(int index, List<Map<String, dynamic>> projects) {
    setState(() {
      projects[index]['joined'] = !projects[index]['joined'];
      if (projects[index]['joined']) {
        _joinedProjects.add(projects[index]['title']);
      } else {
        _joinedProjects.remove(projects[index]['title']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects"),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelStyle:
              const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: "My Projects"),
            Tab(text: "Friend's Projects"),
            Tab(text: "Explore"),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFCE93D8), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              _buildDrawerItem(
                  icon: Icons.person,
                  text: 'Profile',
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      )),
              _buildDrawerItem(
                  icon: Icons.smart_toy,
                  text: 'AI Assistant',
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AiAssistantPage()),
                      )),
              _buildDrawerItem(
                  icon: Icons.group,
                  text: 'Friends',
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FriendsPage(friends: _friends)),
                      )),
              _buildDrawerItem(
                  icon: Icons.message,
                  text: 'Messages',
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MessagesPage()),
                      )),
              _buildDrawerItem(
                  icon: Icons.folder,
                  text: 'Joined Projects',
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinedProjectsPage(
                                joinedProjects: _joinedProjects)),
                      )),
              _buildDrawerItem(
                  icon: Icons.settings,
                  text: 'Settings',
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()),
                      )),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Stack(
            children: [
              _buildMyProjectsTab(),
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProjectAdditionPage(addProject: _addProject),
                      ),
                    );
                  },
                  backgroundColor: Color(0xFFFFCCBC),
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
          _buildProjectList(_friendsProjects, true),
          _buildProjectList(_exploreProjects, false),
        ],
      ),
    );
  }

  Widget _buildMyProjectsTab() {
    return _myProjects.isEmpty
        ? const Center(
            child: Text(
            "No projects added yet.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ))
        : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: _myProjects.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.orange[50],
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(_myProjects[index]['title']!,
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text('Description: ${_myProjects[index]['description']!}',
                          style: const TextStyle(fontSize: 16.0)),
                      if (_myProjects[index].containsKey('language'))
                        Text('Language: ${_myProjects[index]['language']!}',
                            style: const TextStyle(fontSize: 16.0)),
                      if (_myProjects[index].containsKey('duration'))
                        Text('Duration: ${_myProjects[index]['duration']!}',
                            style: const TextStyle(fontSize: 16.0)),
                      if (_myProjects[index].containsKey('teamSize'))
                        Text('Team Size: ${_myProjects[index]['teamSize']!}',
                            style: const TextStyle(fontSize: 16.0)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete,
                        color: Color.fromARGB(255, 111, 24, 18)),
                    onPressed: () {
                      setState(() {
                        _myProjects.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            },
          );
  }

  Widget _buildProjectList(
      List<Map<String, dynamic>> projects, bool isFriendsProjects) {
    if (projects.isEmpty) {
      return const Center(
          child: Text(
        "No projects added yet.",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return Card(
            color: isFriendsProjects ? Colors.lightBlue[50] : Colors.green[50],
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(projects[index]['title']!,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text('Description: ${projects[index]['description']!}',
                      style: const TextStyle(fontSize: 16.0)),
                  if (projects[index].containsKey('language'))
                    Text('Language: ${projects[index]['language']!}',
                        style: const TextStyle(fontSize: 16.0)),
                  if (projects[index].containsKey('duration'))
                    Text('Duration: ${projects[index]['duration']!}',
                        style: const TextStyle(fontSize: 16.0)),
                  if (projects[index].containsKey('teamSize'))
                    Text('Team Size: ${projects[index]['teamSize']!}',
                        style: const TextStyle(fontSize: 16.0)),
                  if (isFriendsProjects)
                    Text('Friend: ${projects[index]['friendName']!}',
                        style: const TextStyle(fontSize: 16.0)),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  _joinProject(index, projects);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: projects[index]['joined']
                      ? Color.fromARGB(255, 234, 177, 244)
                      : Colors.white,
                ),
                child: Text(projects[index]['joined'] ? 'Joined' : 'Join'),
              ),
            ),
          );
        },
      );
    }
  }

  ListTile _buildDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 0, 0, 0)),
      title: Text(
        text,
        style:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
      ),
      onTap: onTap,
    );
  }
}

class JoinedProjectsPage extends StatelessWidget {
  final List<String> joinedProjects;

  const JoinedProjectsPage({super.key, required this.joinedProjects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joined Projects'),
      ),
      body: joinedProjects.isEmpty
          ? const Center(child: Text('No joined projects yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: joinedProjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(joinedProjects[index]),
                );
              },
            ),
    );
  }
}
