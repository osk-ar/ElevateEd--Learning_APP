// ignore_for_file: dead_code

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';

part 'package:ElevatED/features/presentation/forget_password/state/verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());
  String validOTP = "zeiad";
  int remainingTryCount = 3;

  String? verifyOTP(String otp) {
    if (remainingTryCount <= 0) {
      return "Max attempts reached, Resend a new otp";
    }

    print("validating otp in cubit");
    bool isvalid = otp == validOTP;
    if (!isvalid) {
      decrimentRemainingTryCount();
      return "Invalid Otp, Remaining Attempts: $remainingTryCount";
    } else {
      return null;
    }
  }

  void decrimentRemainingTryCount() {
    remainingTryCount = remainingTryCount - 1;
  }

  void getOTP() {
    //todo call api to get otp
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

String getTimerText(int time) {
  int mins = time ~/ 60;
  int secs = time % 60;

  String minText = mins > 9 ? mins.toString() : "0$mins";
  String secText = secs > 9 ? secs.toString() : "0$secs";

  return "$minText:$secText";
}
