import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AiAssistantPage extends StatefulWidget {
  const AiAssistantPage({Key? key}) : super(key: key);

  @override
  _AiAssistantPageState createState() => _AiAssistantPageState();
}

class _AiAssistantPageState extends State<AiAssistantPage> {
  final TextEditingController _questionController = TextEditingController();
  final List<Map<String, String>> _conversation = [];
  late final GenerativeModel _model;
  ChatSession? _chat;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _textFieldFocus = FocusNode();
  bool _loading = false;
  static const apiKey = 'AIzaSyDbY7efQQEyPCwdLQCe6cixmoPsN1SellA';

  Map<String, String> _teamHubInfo = {};

  @override
  void initState() {
    super.initState();
    _loadTeamHubInfo();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );
    _initializeChatSession();
  }

  Future<void> _initializeChatSession() async {
    try {
      _chat = _model.startChat();
      setState(() {}); // Update UI after initializing _chat
    } catch (e) {
      _showError('Chat session initialization failed: $e');
    }
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
      print('Error loading teamHubInfo: $e');
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(
            milliseconds: 750,
          ),
          curve: Curves.easeOutCirc,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var textFieldDecoration = InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      hintText: 'Ask me anything...',
      hintStyle: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );

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
            child: apiKey.isNotEmpty
                ? _chat != null
                    ? ListView.builder(
                        controller: _scrollController,
                        itemBuilder: (context, idx) {
                          var content = _chat!.history.toList()[idx];
                          var text = content.parts
                              .whereType<TextPart>()
                              .map<String>((e) => e.text)
                              .join('');
                          return MessageWidget(
                            text: text,
                            isFromUser: content.role == 'user',
                          );
                        },
                        itemCount: _chat!.history.length,
                      )
                    : const Center(child: CircularProgressIndicator())
                : ListView(
                    children: const [
                      Text('Api key bulunamadi'),
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _questionController,
                    focusNode: _textFieldFocus,
                    decoration: textFieldDecoration,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onSubmitted: (String value) {
                      _sendChatMessage(value);
                      _textFieldFocus.unfocus();
                    },
                  ),
                ),
                if (!_loading)
                  IconButton(
                    onPressed: () async {
                      _sendChatMessage(_questionController.text);
                      _textFieldFocus.unfocus();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                else
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    if (_chat == null) {
      _showError('Chat session is not initialized.');
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      final lowerQuestion = message.toLowerCase();
      print('User question: $message');

      if (_teamHubInfo.containsKey(lowerQuestion)) {
        final response = _teamHubInfo[lowerQuestion]!;
        print('Response from local info: $response');
        setState(() {
          _conversation.add({'user': message, 'ai': response});
          _loading = false;
        });
      } else {
        var response = await _chat!.sendMessage(
          Content.text(message),
        );
        var text = response.text ?? 'Yanıt alınamadı.';

        setState(() {
          _conversation.add({'user': message, 'ai': text});
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _questionController.clear();
      _textFieldFocus.requestFocus();
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Bir şeyler ters gitti'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String text;
  final bool isFromUser;

  const MessageWidget({
    super.key,
    required this.text,
    required this.isFromUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
              color: isFromUser
                  ? Colors.green[200] // User message color
                  : Colors.grey.withOpacity(0.2), // AI message color
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: MarkdownBody(
              selectable: true,
              data: text,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                  fontSize: 16.0, // Increase the text size
                  color: isFromUser
                      ? Colors.black // User message text color
                      : Colors.black87, // AI message text color
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
