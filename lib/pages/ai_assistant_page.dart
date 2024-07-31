import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = '';

class AiAssistantPage extends StatefulWidget {
  const AiAssistantPage({Key? key}) : super(key: key);

  @override
  _AiAssistantPageState createState() => _AiAssistantPageState();
}

class _AiAssistantPageState extends State<AiAssistantPage> {
  final TextEditingController _questionController = TextEditingController();
  final List<Map<String, String>> _conversation = [];
  final GenerativeModel _model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );

  Map<String, String> _teamHubInfo = {};

  @override
  void initState() {
    super.initState();
    _loadTeamHubInfo();
  }

  Future<void> _loadTeamHubInfo() async {
    try {
      final String response = await rootBundle
          .loadString('lib/assets/images/data/teamhub_info.json');
      final data = json.decode(response);
      final List questions = data['sorular'];
      final Map<String, String> loadedInfo = {};
      for (var item in questions) {
        loadedInfo[item['soru'].toLowerCase()] = item['cevap'];
      }
      setState(() {
        _teamHubInfo = loadedInfo;
      });
      print('TeamHub info loaded successfully.');
    } catch (e) {
      print('Error loading teamHubInfo: $e'); // Debug
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Assistant',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF37474F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _conversation.length,
              itemBuilder: (context, index) {
                final isUser =
                    index % 2 == 0; // Alternation between user and AI messages
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(12.0),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Color.fromARGB(255, 139, 165, 178)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      isUser
                          ? _conversation[index]['user']!
                          : _conversation[index]['ai']!,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16.0),
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
                    controller: _questionController,
                    decoration: InputDecoration(
                      hintText: 'Ask me anything...',
                      hintStyle: const TextStyle(color: Colors.black),
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final userQuestion = _questionController.text.trim();
                    if (userQuestion.isNotEmpty) {
                      final aiResponse = await _getAIResponse(userQuestion);
                      setState(() {
                        _conversation
                            .add({'user': userQuestion, 'ai': aiResponse});
                        _questionController.clear();
                      });
                    } else {
                      print('User question is empty.');
                    }
                  },
                  icon: const Icon(Icons.send, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _getAIResponse(String question) async {
    final lowerQuestion = question.toLowerCase();
    print('User question: $question'); // Debug

    if (_teamHubInfo.containsKey(lowerQuestion)) {
      final response = _teamHubInfo[lowerQuestion]!;
      print('Response from local info: $response'); // Debug
      return response;
    } else {
      try {
        final response = await _model.generateContent([Content.text(question)]);
        print('AI response: ${response.text}'); // Debug
        return response.text ?? 'Yanıt alınamadı.';
      } catch (e) {
        print('AI response error: ${e.toString()}'); // Debug
        return 'Hata: ${e.toString()}';
      }
    }
  }
}
