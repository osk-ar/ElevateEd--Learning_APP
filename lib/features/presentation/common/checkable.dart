import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_fonts.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:e_learning_app_gp/features/presentation/login/cubits/login_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/login/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Checkable extends StatefulWidget {
  const Checkable({super.key});

  @override
  State<Checkable> createState() => _CheckableState();
}

class _CheckableState extends State<Checkable> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              activeColor: MyTheme.primaryColor,
              value: context.read<LoginCubit>().isRememberMeChecked,
              onChanged: (val) =>
                  context.read<LoginCubit>().toggleRememberMe(val!),
            ),
            Text(
              "Remember me",
              style:
                  AppTextStyles.lightTextStyle(context, fontSize: FontSize.f14),
            ),
          ],
        );
      },
    );
  }
}
