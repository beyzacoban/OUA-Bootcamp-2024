import 'package:flutter/material.dart';

class ReminderPage extends StatefulWidget {
  final DateTime selectedDay;
  final String existingReminder;
  final Function(DateTime, String) onReminderSaved;

  const ReminderPage({
    super.key,
    required this.selectedDay,
    required this.existingReminder,
    required this.onReminderSaved,
  });

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final TextEditingController _reminderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reminderController.text = widget.existingReminder;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reminder',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF37474F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _reminderController,
              decoration: const InputDecoration(
                labelText: 'Reminder',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_reminderController.text.isNotEmpty) {
                  widget.onReminderSaved(
                      widget.selectedDay, _reminderController.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF37474F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
