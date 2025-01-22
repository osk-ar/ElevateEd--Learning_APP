import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/features/presentation/register/cubits/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RolePicker extends StatelessWidget {
  const RolePicker({
    super.key,
    this.width = 200,
    this.height = 50,
    this.animationDuration = 300,
    required this.isStudent,
  });

  final double? width;
  final double? height;
  final int? animationDuration;
  final bool isStudent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: MyTheme.secondaryColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: animationDuration!),
            curve: Curves.easeInOut,
            left: isStudent ? 0 : width! / 2,
            child: AnimatedContainer(
              duration: Duration(milliseconds: animationDuration!),
              curve: Curves.easeInOut,
              width: isStudent ? width! / 2 : width! / 2,
              height: height,
              decoration: BoxDecoration(
                color: MyTheme.primaryColor,
                borderRadius: BorderRadius.circular(height! / 2),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      context
                          .read<RegisterCubit>()
                          .toggleRole(UserRole.STUDENT);
                    },
                    child: Text(
                      'Student',
                      style: TextStyle(
                        color: isStudent ? Colors.white : MyTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      context
                          .read<RegisterCubit>()
                          .toggleRole(UserRole.TEACHER);
                    },
                    child: Text(
                      'Instructor',
                      style: TextStyle(
                        color: isStudent ? MyTheme.primaryColor : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
