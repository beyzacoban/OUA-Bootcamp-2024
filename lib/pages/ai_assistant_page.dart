// File: ai_assistant_page.dart
import 'package:flutter/material.dart';

class AiAssistantPage extends StatefulWidget {
  const AiAssistantPage({super.key});

  @override
  _AiAssistantPageState createState() => _AiAssistantPageState();
}

class _AiAssistantPageState extends State<AiAssistantPage> {
  final TextEditingController _questionController = TextEditingController();
  final List<Map<String, String>> _conversation = [];

  // Placeholder for your AI response logic
  Future<String> getAIResponse(String question) async {
    // TODO: Replace with your actual AI API call
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call
    return "This is a placeholder AI response to: '$question'";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _conversation.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_conversation[index]['user']!),
                  subtitle: Text(_conversation[index]['ai']!),
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
                    controller: _questionController,
                    decoration: const InputDecoration(
                      hintText: 'Ask me anything about your projects...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final userQuestion = _questionController.text;
                    final aiResponse = await getAIResponse(userQuestion);
                    setState(() {
                      _conversation
                          .add({'user': userQuestion, 'ai': aiResponse});
                      _questionController.clear();
                    });
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
