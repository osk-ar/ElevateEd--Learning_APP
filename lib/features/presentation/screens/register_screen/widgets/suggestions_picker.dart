import 'dart:math';
import 'package:flutter/material.dart';

class SuggestionsWidget extends StatelessWidget {
  final List<String> topics = [
    "Photography",
    "Cooking",
    "Travel",
    "Gaming",
    "Fitness",
    "Music",
    "Art",
    "Coding",
    "Books",
    "Movies"
  ];

  SuggestionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8, // Horizontal spacing between containers
        runSpacing: 8, // Vertical spacing between rows
        children: topics.map((topic) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors
                  .primaries[random.nextInt(Colors.primaries.length)].shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.topic,
                  color: Colors.grey[700],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  topic,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
