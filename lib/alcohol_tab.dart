import 'package:flutter/material.dart';

// Legal purchasing age by jurisdiction
const Map<String, int> legalAges = {
  'United States': 21,
  'Canada (Ontario)': 19,
  'Canada (Quebec)': 18,
  'Mexico': 18,
  'Honduras': 18,
  'United Kingdom': 18,
  'Germany (beer/wine)': 16,
  'Japan': 20,
};

class AlcoholTab extends StatefulWidget {
  const AlcoholTab({super.key});

  @override
  State<AlcoholTab> createState() => _AlcoholTabState();
}

class _AlcoholTabState extends State<AlcoholTab> {
  DateTime? _birthDate;
  String _jurisdiction = 'United States';
  String _result = '';

  String _formatDate(DateTime d) => '${d.month}/${d.day}/${d.year}';

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 20),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _birthDate = picked);
      _calculate();
    }
  }

  void _calculate() {
    if (_birthDate == null) {
      setState(() => _result = 'Please pick your date of birth.');
      return;
    }

    final age = legalAges[_jurisdiction]!;
    final dob = _birthDate!;
    final now = DateTime.now();
    final legalDate = DateTime.utc(dob.year + age, dob.month, dob.day);
    final today = DateTime.utc(now.year, now.month, now.day);

    String text;
    if (!legalDate.isAfter(today)) {
      text = 'You can legally buy alcohol in $_jurisdiction (age $age).\n'
          'You have been able to since ${_formatDate(legalDate)}.';
    } else {
      final daysLeft = legalDate.difference(today).inDays;
      text = 'You can buy alcohol in $_jurisdiction on ${_formatDate(legalDate)}.\n'
          'That is $daysLeft days from now.';
    }

    setState(() => _result = text);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        DropdownButtonFormField<String>(
          initialValue: _jurisdiction,
          decoration: const InputDecoration(
            labelText: 'Jurisdiction',
            border: OutlineInputBorder(),
          ),
          items: legalAges.keys
              .map((place) => DropdownMenuItem(
                    value: place,
                    child: Text('$place (${legalAges[place]})'),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() => _jurisdiction = value!);
            if (_birthDate != null) _calculate();
          },
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: _pickDate,
          icon: const Icon(Icons.calendar_today),
          label: Text(_birthDate == null
              ? 'Pick date of birth'
              : 'Born: ${_formatDate(_birthDate!)}'),
        ),
        const SizedBox(height: 24),
        Text(
          _result,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}