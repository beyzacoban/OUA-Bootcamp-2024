import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'reminder_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Map to hold reminders
  final Map<DateTime, String> _reminders = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF37474F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: TableCalendar(
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReminderPage(
                      selectedDay: selectedDay,
                      onReminderSaved: (DateTime date, String reminder) {
                        setState(() {
                          final normalizedDate =
                              DateTime(date.year, date.month, date.day);
                          _reminders[normalizedDate] = reminder;
                        });
                      },
                      existingReminder: _reminders[DateTime(selectedDay.year,
                              selectedDay.month, selectedDay.day)] ??
                          '',
                    ),
                  ),
                );
              },
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Color(0xFF37474F),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: false,
                markersAlignment: Alignment.bottomCenter,
                markerDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                weekendStyle:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  final normalizedDay = DateTime(day.year, day.month, day.day);
                  if (_reminders.keys.any((d) =>
                      isSameDay(d, normalizedDay) &&
                      d.month == _focusedDay.month &&
                      d.year == _focusedDay.year)) {
                    return Positioned(
                      right: 2,
                      bottom: 2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return null;
                },
                defaultBuilder: (context, day, focusedDay) {
                  final normalizedDay = DateTime(day.year, day.month, day.day);
                  if (_reminders.keys.any((d) =>
                      isSameDay(d, normalizedDay) &&
                      d.month == _focusedDay.month &&
                      d.year == _focusedDay.year)) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }
                  return null;
                },
              ),
              daysOfWeekVisible: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Reminders for ${DateFormat('MMMM yyyy').format(_focusedDay)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView(
              children: _reminders.entries
                  .where((entry) =>
                      entry.key.month == _focusedDay.month &&
                      entry.key.year == _focusedDay.year)
                  .map((entry) {
                return ListTile(
                  title: Text(
                    DateFormat('yyyy-MM-dd').format(entry.key),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(entry.value),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReminderPage(
                          selectedDay: entry.key,
                          onReminderSaved: (DateTime date, String reminder) {
                            setState(() {
                              final normalizedDate =
                                  DateTime(date.year, date.month, date.day);
                              _reminders[normalizedDate] = reminder;
                            });
                          },
                          existingReminder: entry.value,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
