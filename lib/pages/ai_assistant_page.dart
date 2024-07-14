import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AiAssistantPage extends StatefulWidget {
  const AiAssistantPage({Key? key}) : super(key: key);

  @override
  _AiAssistantPageState createState() => _AiAssistantPageState();
}

class _AiAssistantPageState extends State<AiAssistantPage> {
  final TextEditingController _questionController = TextEditingController();
  final List<Map<String, String>> _conversation = [];

  static const String dialogflowToken = 'YOUR_DIALOGFLOW_CLIENT_ACCESS_TOKEN';
  static const String dialogflowURL =
      'https://dialogflow.googleapis.com/v2/projects/YOUR_PROJECT_ID/agent/sessions/SESSION_ID:detectIntent';

  Future<String> getAIResponse(String question) async {
    final uri = Uri.parse(dialogflowURL);
    final response = await http.post(
      uri.replace(
        path: uri.path.replaceAll('YOUR_PROJECT_ID', 'YOUR_PROJECT_ID'),
        query: 'v=20150910',
      ),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $dialogflowToken',
      },
      body: jsonEncode({
        'queryInput': {
          'text': {
            'text': question,
            'languageCode': 'en',
          },
        },
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data['queryResult']['fulfillmentText'];
    } else {
      return 'Error communicating with AI service.';
    }
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
                      hintText: 'Ask me anything...',
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
