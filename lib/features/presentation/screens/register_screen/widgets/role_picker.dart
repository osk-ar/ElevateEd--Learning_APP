import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/features/presentation/cubits/register_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/states/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RolePicker extends StatelessWidget {
  const RolePicker({
    super.key,
    this.width = 200,
    this.height = 50,
    this.animationDuration = 300,
  });

  final double? width;
  final double? height;
  final int? animationDuration;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
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
                left: context.read<RegisterCubit>().isStudent ? 0 : width! / 2,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: animationDuration!),
                  curve: Curves.easeInOut,
                  width: context.read<RegisterCubit>().isStudent
                      ? width! / 2
                      : width! / 2,
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
                            color: context.read<RegisterCubit>().isStudent
                                ? Colors.white
                                : MyTheme.primaryColor,
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
                            color: context.read<RegisterCubit>().isStudent
                                ? MyTheme.primaryColor
                                : Colors.white,
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
      },
    );
  }
}
