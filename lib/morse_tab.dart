import 'package:flutter/material.dart';

const Map<String, String> morseMap = {
  'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.',
  'F': '..-.', 'G': '--.', 'H': '....', 'I': '..', 'J': '.---',
  'K': '-.-', 'L': '.-..', 'M': '--', 'N': '-.', 'O': '---',
  'P': '.--.', 'Q': '--.-', 'R': '.-.', 'S': '...', 'T': '-',
  'U': '..-', 'V': '...-', 'W': '.--', 'X': '-..-', 'Y': '-.--',
  'Z': '--..',
  '0': '-----', '1': '.----', '2': '..---', '3': '...--', '4': '....-',
  '5': '.....', '6': '-....', '7': '--...', '8': '---..', '9': '----.',
  '.': '.-.-.-', ',': '--..--', '?': '..--..', '!': '-.-.--',
};

class MorseTab extends StatefulWidget {
  const MorseTab({super.key});

  @override
  State<MorseTab> createState() => _MorseTabState();
}

class _MorseTabState extends State<MorseTab> {
  String _morse = '';

  void _translate(String text) {

    final words = text.toUpperCase().trim().split(RegExp(r'\s+'));
    final morseWords = words.map(
      (word) => word.split('').map((char) => morseMap[char] ?? '?').join(' '),
    );
    setState(() => _morse = morseWords.join(' / '));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          onChanged: _translate,
          decoration: const InputDecoration(
            labelText: 'Enter text',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        const Text('Morse code:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SelectableText(
          _morse,
          style: const TextStyle(fontSize: 22, fontFamily: 'monospace'),
        ),
      ],
    );
  }
}