// ignore_for_file: dead_code

import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/features/domain/usecases/send_otp_usecase.dart';
import 'package:ElevatED/features/domain/usecases/verify_otp_usecase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';

part 'package:ElevatED/features/presentation/5_forget_password/state/verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final VerifyOtpUsecase _verifyOtpUsecase;
  final SendOtpUsecase _sendOtpUsecase;
  VerificationCubit(this._verifyOtpUsecase, this._sendOtpUsecase)
      : super(VerificationInitial());
  int remainingTryCount = 3;
  final String email = MemoryCache.getEmail() ?? "example@gmail.com";

  void otpValidator(BuildContext context, String otp) async {
    if (remainingTryCount <= 0) {
      if (context.mounted) {
        context.message(
          message: "max_attempts_reached_resend_a_new_otp".tr(),
          textColor: AppColors.lightErrorColor,
        );
      }
      return;
    }
    bool isVerified = false;
    try {
      isVerified = await _verifyOtpUsecase.call(email, otp);
      emit(VerificationLoading());
    } catch (e) {
      emit(VerificationError(error: e.toString()));
    }

    if (!isVerified) {
      decrimentRemainingTryCount();
      if (context.mounted) {
        context.message(
          message: "incorrect_remaining_attempts_remainingcount"
              .tr(args: [remainingTryCount.toString()]),
          textColor: AppColors.lightErrorColor,
        );
      }
      emit(VerificationInitial());
      return;
    }
    if (context.mounted) {
      context.message(
        message: "verification_success_".tr(),
        textColor: AppColors.inversePrimaryColor,
      );
    }
    emit(VerificationVerified(didVerify: isVerified));
  }

  void decrimentRemainingTryCount() {
    remainingTryCount = remainingTryCount - 1;
  }

  void getOTP() async {
    try {
      await _sendOtpUsecase.call(email);
    } catch (e) {
      emit(VerificationError(error: e.toString()));
    }
    remainingTryCount = 3;
    emit(
      VerificationResentOTP(timer: "03:00"),
    );
    startOTPTimerWithTick(
      onTick: (remainingInSeconds) {
        emit(
          VerificationResentOTP(
            timer: getTimerText(remainingInSeconds),
          ),
        );
      },
      onFinished: () {
        emit(
          VerificationInitial(),
        );
      },
    );
  }

  void startOTPTimerWithTick({
    required void Function() onFinished,
    required void Function(int) onTick,
  }) {
    const totalDuration = Duration(minutes: 3);
    const tickDuration = Duration(seconds: 1);
    int remainingSeconds = totalDuration.inSeconds;

    Timer.periodic(tickDuration, (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        onTick(remainingSeconds);
      } else {
        timer.cancel();
        onFinished();
      }
    });
  }

  String getTimerText(int timeInSecs) {
    int mins = timeInSecs ~/ 60;
    int secs = timeInSecs % 60;

    String minText = mins > 9 ? mins.toString() : "0$mins";
    String secText = secs > 9 ? secs.toString() : "0$secs";

    return "$minText:$secText";
  }
}
