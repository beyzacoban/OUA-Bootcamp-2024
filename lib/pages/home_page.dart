import 'package:flutter/material.dart';
import 'notifications_page.dart';
import 'ai_assistant_page.dart';
import 'profile_page.dart';
import 'messages_page.dart';
import 'friends_page.dart';
import 'project_addition_page.dart';
import 'settings_page.dart';
import 'calendar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // List of friends
  final List<String> _friends = ["Alice", "Bob", "Charlie", "Eve"];
  // List of user's own projects
  final List<Map<String, String>> _myProjects = [
    {
      'title': 'Personal Blog',
      'description': 'A blog app to share my thoughts and experiences.',
      'language': 'Flutter',
      'duration': 'Ongoing',
      'teamSize': '2',
    },
  ];
  // List of friends' projects
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
    {
      'title': 'Task Manager',
      'description': 'A collaborative task management app for teams.',
      'language': 'Java',
      'duration': '6 months',
      'teamSize': '4',
      'friendName': 'Bob',
      'joined': false
    },
  ];
  // List of explore projects
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
    {
      'title': 'Language Learning',
      'description': 'A gamified language learning app.',
      'language': 'JavaScript',
      'duration': '8 months',
      'teamSize': '7',
      'joined': false
    },
  ];
  // List of joined projects
  final List<String> _joinedProjects = [];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  // Function to add a project
  void _addProject(String title, String description) {
    setState(() {
      _myProjects.add({
        'title': title,
        'description': description,
      });
    });
  }

  // Function to delete a project
  void _deleteProject(int index) {
    setState(() {
      _myProjects.removeAt(index);
    });
  }

  // Function to join or leave a project
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
    // This widget builds the main scaffold structure of the Projects screen.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects"),
        actions: [
          // Notification Icon Button
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Navigates to the Notifications page when the icon is pressed.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsPage(),
                ),
              );
            },
          ),
        ],
        // Tab Bar at the bottom of the AppBar
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
      // Navigation Drawer
      drawer: Drawer(
        child: Container(
          // Gradient background for the drawer
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF546E7A), Colors.black87],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // Drawer Header with Menu text
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // Drawer Items for navigation (profile, AI, friends, etc.)
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
                icon: Icons.calendar_today,
                text: 'Calendar',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalendarPage(),
                  ),
                ),
              ),
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
      // Main Content Area controlled by the Tab Bar
      body: TabBarView(
        controller: _tabController,
        children: [
          // My Projects Tab with Floating Add Button
          Stack(
            children: [
              _buildMyProjectsTab(), // Builds the list of user's projects.
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
                  backgroundColor: const Color(0xFF37474F),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
          _buildProjectList(_friendsProjects, true), // Friend's Projects tab
          _buildProjectList(_exploreProjects, false), // Explore Projects tab
        ],
      ),
    );
  }

  Widget _buildMyProjectsTab() {
    return _myProjects.isEmpty
        ? const Center(
            child: Text(
            "No projects added yet.",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ))
        : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: _myProjects.length,
            itemBuilder: (context, index) {
              return Card(
                color: const Color(0xFF455A64),
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(_myProjects[index]['title']!,
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text('Description: ${_myProjects[index]['description']!}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white70)),
                      if (_myProjects[index].containsKey('language'))
                        Text('Language: ${_myProjects[index]['language']!}',
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.white70)),
                      if (_myProjects[index].containsKey('duration'))
                        Text('Duration: ${_myProjects[index]['duration']!}',
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.white70)),
                      if (_myProjects[index].containsKey('teamSize'))
                        Text('Team Size: ${_myProjects[index]['teamSize']!}',
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.white70)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
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
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return Card(
            color: projects[index]['joined']
                ? const Color(0xFF263238)
                : const Color(0xFF78909C),
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(projects[index]['title'],
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text('Description: ${projects[index]['description']}',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.white70)),
                  Text('Language: ${projects[index]['language']}',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.white70)),
                  Text('Duration: ${projects[index]['duration']}',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.white70)),
                  Text('Team Size: ${projects[index]['teamSize']}',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.white70)),
                  if (isFriendsProjects)
                    Text('Friend: ${projects[index]['friendName']}',
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.white70)),
                ],
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: projects[index]['joined']
                      ? Colors.red
                      : const Color.fromARGB(255, 195, 234, 2),
                ),
                child: Text(
                  projects[index]['joined'] ? 'Leave' : 'Join',
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _joinProject(index, projects);
                  });
                },
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
      leading: Icon(icon, color: Colors.white),
      title: Text(text,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
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
        title: const Text("Joined Projects"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: joinedProjects.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF37474F),
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(joinedProjects[index],
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          );
        },
      ),
    );
  }
}
