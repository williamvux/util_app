import 'package:flutter/material.dart';

class DropdownTypeWord extends StatefulWidget {
  final TextEditingController typeCtrl;

  const DropdownTypeWord({super.key, required this.typeCtrl});

  final types = const <String, String>{
    'noun': 'Noun',
    'verb': 'Verb',
    'adjective': 'Adjective',
    'adverb': 'Adverb',
    'preposition': 'Preposition',
    'conjunction': 'Conjunction',
    'interjection': 'Interjection',
    'pronoun': 'Pronoun',
    'determiner': 'Determiner',
    'phrase': 'Phrase',
    'phrasal_verb': 'Phrasal Verb',
  };

  @override
  State<DropdownTypeWord> createState() => _DropdownTypeWordState();
}

class _DropdownTypeWordState extends State<DropdownTypeWord> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.typeCtrl.text,
      items: widget.types.entries.map((MapEntry<String, String> map) {
        return DropdownMenuItem<String>(
          key: Key(map.key),
          value: widget.types[map.key],
          child: Center(
            child: Text(widget.types[map.key] ?? ''),
          ),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          widget.typeCtrl.text = value ?? '';
        });
      },
    );
  }
}
