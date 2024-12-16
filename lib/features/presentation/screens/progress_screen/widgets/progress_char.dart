import 'package:e_learning_app_gp/features/presentation/screens/progress_screen/widgets/custom_overlay_button.dart';
import 'package:flutter/material.dart';

class ProgressChar extends StatelessWidget {
  const ProgressChar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButtonWithOverlay(
          buttonText: "Select Option",
          buttonIcon: Icons.arrow_drop_down,
          options: const ["Day", "Week", "Month"],
          onOptionSelected: (value) {
            print("Selected: $value");
          },
          backgroundColor: Colors.blueAccent.withOpacity(0.9),
          borderRadius: 12.0,
        ),
        // Weekly Progress Section
        const Text(
          'This Week',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Center(
          child: Column(
            children: [
              const Text(
                '52h 24m',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (index) {
                  return Column(
                    children: [
                      Text(
                        '+${[10, 9, 6, 5, 6, 4, 8][index]}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Container(
                        width: 20,
                        height: [60, 55, 30, 25, 35, 20, 45][index].toDouble(),
                        decoration: BoxDecoration(
                          color: index == 1
                              ? Colors.blue
                              : Colors.blue.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun'
                        ][index],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
