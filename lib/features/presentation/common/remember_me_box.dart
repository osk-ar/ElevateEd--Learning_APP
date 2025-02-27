import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/features/presentation/login/cubits/login_cubit.dart';
import 'package:ElevatED/features/presentation/login/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RememberMeBox extends StatefulWidget {
  const RememberMeBox({super.key});

  @override
  State<RememberMeBox> createState() => _RememberMeBoxState();
}

class _RememberMeBoxState extends State<RememberMeBox> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              activeColor: AppColors.primaryColor,
              value: context.read<LoginCubit>().isRememberMeChecked,
              onChanged: (val) =>
                  context.read<LoginCubit>().toggleRememberMe(val!),
            ),
            Text(
              "Remember me",
              style:
                  getLightStyle(fontSize: 12.sp, color: ThemeColors.textColor),
            ),
          ],
        );
      },
    );
  }
}
