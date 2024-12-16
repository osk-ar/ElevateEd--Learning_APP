import 'package:e_learning_app_gp/features/presentation/screens/common/default_layout.dart';
import 'package:flutter/material.dart';

class RegisterAsStudent extends StatelessWidget {
  const RegisterAsStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Column(
        children: [
          const CircleAvatar(
            minRadius: 100,
          ),
          Container(),
        ],
      ),
    );
  }
}
