import 'dart:developer';

import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/assignment/assignment_solver_cubit.dart';
import 'package:ElevatED/features/data/models/assignment/assignment.dart';
import 'package:ElevatED/features/data/models/assignment/question.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/presentation/course_content_play/screens/widgets/mcq_question_widget.dart';
import 'package:ElevatED/features/presentation/course_content_play/screens/widgets/essay_question_widget.dart';

class AssignmentSolverScreen extends StatefulWidget {
  final Assignment assignment;
  const AssignmentSolverScreen({super.key, required this.assignment});

  @override
  State<AssignmentSolverScreen> createState() => _AssignmentSolverScreenState();
}

class _AssignmentSolverScreenState extends State<AssignmentSolverScreen> {
  final List<EssayController> _controllers = [];
  @override
  void initState() {
    super.initState();
    log("assignment screen init: ${widget.assignment.title}");
    context.read<AssignmentSolverCubit>().setAssignment(widget.assignment);

    for (EssayQuestion q
        in widget.assignment.questions.whereType<EssayQuestion>()) {
      _controllers.add(EssayController(
        controller: TextEditingController(),
        index: q.index,
      ));
    }
  }

  @override
  void dispose() {
    for (var ec in _controllers) {
      ec.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AssignmentSolverCubit>();
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar(widget.assignment.title),
      body: BlocBuilder<AssignmentSolverCubit, AssignmentSolverState>(
        builder: (context, state) {
          final answers = cubit.answers;

          if (state is AssignmentSubmissionInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AssignmentSubmissionSuccess) {
            return Center(
              child: Text(
                AppStrings.assignmentSolverSuccess,
                style: getBoldStyle(
                    fontSize: 20.sp, color: AppColors.successColor),
              ),
            );
          } else if (state is AssignmentSubmissionFailure) {
            return Center(
              child: Text(
                '${AppStrings.assignmentSolverError}: ${state.error}',
                style:
                    getBoldStyle(fontSize: 16.sp, color: AppColors.errorColor),
              ),
            );
          }

          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              ...widget.assignment.questions.map((q) {
                if (q is MultipleChoiseQuestion) {
                  return McqQuestionWidget(
                    question: q,
                    selected: cubit.getAnswerIndex(q.index),
                    onChanged: (val) =>
                        cubit.updateAnswer(q.index, q.answers[val].text),
                  );
                } else if (q is EssayQuestion) {
                  return EssayQuestionWidget(
                    question: q,
                    answer: answers[q.index] ?? '',
                    controller: _controllers
                        .firstWhere((ec) => ec.index == q.index)
                        .controller,
                    onChanged: (val) => cubit.updateAnswer(q.index, val),
                  );
                }
                return const SizedBox.shrink();
              }),
              SizedBox(height: 24.h),
              CTAButton(
                onPressed: () => cubit.submitAnswers(context),
                text: AppStrings.assignmentSolverSubmit,
              ),
            ],
          );
        },
      ),
    );
  }
}
