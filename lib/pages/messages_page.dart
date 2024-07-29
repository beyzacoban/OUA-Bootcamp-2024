import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final List<Map<String, dynamic>> _messages = [
    {
      'group': 'Project Alpha',
      'messages': [
        {'sender': 'Alice', 'message': 'Hello Team!'},
        {'sender': 'Me', 'message': 'Hi Alice!'},
      ]
    },
    {
      'group': 'Project Beta',
      'messages': [
        {'sender': 'Bob', 'message': 'How is everyone?'},
        {'sender': 'Me', 'message': 'Doing well, thanks!'},
      ]
    }
  ];

  String _selectedGroup = 'Project Alpha';
  final _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
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
    final groupMessages = _messages
        .firstWhere((group) => group['group'] == _selectedGroup)['messages'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String group) {
              setState(() {
                _selectedGroup = group;
              });
            },
            itemBuilder: (BuildContext context) {
              return _messages.map<PopupMenuItem<String>>((group) {
                return PopupMenuItem<String>(
                  value: group['group'],
                  child: Text(group['group']),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: groupMessages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: groupMessages[index]['sender'] == 'Me'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(vertical: 2.0),
                    decoration: BoxDecoration(
                      color: groupMessages[index]['sender'] == 'Me'
                          ? Color(0xFF546E7A)
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
                            color: groupMessages[index]['sender'] == 'Me'
                                ? Color(0xFF546E7A)
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
                    decoration: const InputDecoration(
                      labelText: 'Enter your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
