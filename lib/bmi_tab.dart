import 'package:flutter/material.dart';

class BmiTab extends StatefulWidget {
  const BmiTab({super.key});

  @override
  State<BmiTab> createState() => _BmiTabState();
}

class _BmiTabState extends State<BmiTab> {
  final _feetController = TextEditingController();
  final _inchesController = TextEditingController();
  final _weightController = TextEditingController();

  String _result = '';

  void _calculateBmi() {
    final feet = double.tryParse(_feetController.text) ?? 0;
    final inches = double.tryParse(_inchesController.text) ?? 0;
    final weight = double.tryParse(_weightController.text);
    final totalInches = feet * 12 + inches;

    if (weight == null || weight <= 0 || totalInches <= 0) {
      setState(() => _result = 'Please enter a valid height and weight.');
      return;
    }

    final bmi = 703 * weight / (totalInches * totalInches);

    String category;
    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi < 25) {
      category = 'Normal weight';
    } else if (bmi < 30) {
      category = 'Overweight';
    } else {
      category = 'Obese';
    }

    setState(() {
      _result = 'BMI: ${bmi.toStringAsFixed(1)}\nCategory: $category';
    });
  }

  @override
  void dispose() {
    _feetController.dispose();
    _inchesController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _feetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height (ft)',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _inchesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height (in)',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _weightController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Weight (lbs)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _calculateBmi,
          child: const Text('Calculate BMI'),
        ),
        const SizedBox(height: 24),
        Text(
          _result,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22),
        ),
      ],
    );
  }
}