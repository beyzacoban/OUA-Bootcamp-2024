import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final List<Map<String, dynamic>> _messages = [
    {
      'group': 'Travel Planner',
      'messages': [
        {'sender': 'Alice', 'message': 'Hello Team!'},
        {'sender': 'Me', 'message': 'Hi Alice! How are you?'},
        {'sender': 'Alice', 'message': 'I am good, thank you!'},
      ]
    },
    {
      'group': 'Online Learning',
      'messages': [
        {'sender': 'Bob', 'message': 'How is everyone?'},
        {'sender': 'Me', 'message': 'Doing well, thanks!'},
        {'sender': 'Bob', 'message': 'Great to hear!'},
      ]
    },
    {
      'group': 'Recipe Finder',
      'messages': [
        {'sender': 'Charlie', 'message': 'Are we meeting today?'},
        {'sender': 'Me', 'message': 'Yes, at 3 PM.'},
        {'sender': 'Charlie', 'message': 'Okay, see you then!'},
      ]
    },
    {
      'group': 'Meditation Guide',
      'messages': [
        {'sender': 'Diana', 'message': 'Any updates on the task?'},
        {'sender': 'Me', 'message': 'Working on it, will update soon.'},
        {'sender': 'Diana', 'message': 'Alright, thanks!'},
      ]
    },
    {
      'group': 'Weather App',
      'messages': [
        {'sender': 'Eve', 'message': 'Check the new designs.'},
        {'sender': 'Me', 'message': 'Looks good, Eve!'},
        {'sender': 'Eve', 'message': 'Thanks!'},
      ]
    },
  ];

  String? _selectedGroup;
  final _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty && _selectedGroup != null) {
      setState(() {
        final groupIndex =
            _messages.indexWhere((group) => group['group'] == _selectedGroup);
        _messages[groupIndex]['messages']
            .add({'sender': 'Me', 'message': _messageController.text});
        _messageController.clear();
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        backgroundColor: const Color(0xFF546E7A),
      ),
      body: Column(
        children: [
          // Group List (Scrollable)
          Container(
            height: 60,
            color: Colors.grey[300],
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGroup = _messages[index]['group'];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _selectedGroup == _messages[index]['group']
                              ? const Color(0xFF546E7A)
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      _messages[index]['group'],
                      style: TextStyle(
                        color: _selectedGroup == _messages[index]['group']
                            ? const Color(0xFF546E7A)
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _selectedGroup == null
                ? const Center(
                    child: Text('Please select a group to see messages.'))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: _messages
                              .firstWhere((group) =>
                                  group['group'] == _selectedGroup)['messages']
                              .length,
                          itemBuilder: (context, index) {
                            final groupMessages = _messages.firstWhere(
                                (group) =>
                                    group['group'] ==
                                    _selectedGroup)['messages'];
                            return Align(
                              alignment: groupMessages[index]['sender'] == 'Me'
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                decoration: BoxDecoration(
                                  color: groupMessages[index]['sender'] == 'Me'
                                      ? const Color(0xFF546E7A)
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      groupMessages[index]['sender']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: groupMessages[index]['sender'] ==
                                                'Me'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    Text(groupMessages[index]['message']!),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _messageController,
                                decoration: InputDecoration(
                                  labelText: 'Enter your message',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.send,
                                  color: Color(
                                      0xFF546E7A)), // Fixed dark gray color
                              onPressed: _sendMessage,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
