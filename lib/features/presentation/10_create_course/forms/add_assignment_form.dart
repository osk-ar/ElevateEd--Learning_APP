import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/core/managers/validation_manager.dart';
import 'package:ElevatED/features/data/models/assignment/answer.dart';
import 'package:ElevatED/features/data/models/view/normalized_course_content.dart';
import 'package:ElevatED/features/data/models/assignment/question.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubit/create_course_cubit.dart';
import 'package:ElevatED/features/presentation/10_create_course/widgets/course_building_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAssignmentForm extends StatefulWidget {
  const AddAssignmentForm({super.key});

  @override
  State<AddAssignmentForm> createState() => _AddAssignmentFormState();
}

class _AddAssignmentFormState extends State<AddAssignmentForm> {
  final _titleController = TextEditingController();

  late final GlobalKey<FormState> _formKey;
  late final CreateCourseCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<CreateCourseCubit>();
    _formKey = GlobalKey<FormState>();
  }

  void _addMultipleChoiceQuestion(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ThemeColors.backgroundColor,
        title: const Text('Add Multiple Choice Question'),
        content: MultipleChoiceQuestionDialog(
          index: index,
          onSave: (question) {
            cubit.saveQuestion(question);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _addEssayQuestion(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ThemeColors.backgroundColor,
        title: const Text('Add Essay Question'),
        content: EssayQuestionDialog(
          index: index,
          onSave: (question) {
            cubit.saveQuestion(question);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar("Add Assignment Form"),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16.h,
                  children: [
                    InputField(
                      controller: _titleController,
                      title: "Assignment Title",
                      validator: (value) =>
                          ValidationManager.validateAssignmentTitle(value),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _addMultipleChoiceQuestion(
                              cubit.lastAssignmentQuestions.length),
                          icon: const Icon(Icons.check_box),
                          label: const Text('Add MCQ'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ThemeColors.lightSurfaceToDarkSecondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                              side: BorderSide(
                                color: AppColors.primaryColor,
                                width: 1.r,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _addEssayQuestion(
                              cubit.lastAssignmentQuestions.length),
                          icon: const Icon(Icons.edit_note),
                          label: const Text('Add Essay'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ThemeColors.lightSurfaceToDarkSecondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                              side: BorderSide(
                                color: AppColors.primaryColor,
                                width: 1.r,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<CreateCourseCubit, CreateCourseState>(
            buildWhen: (previous, current) =>
                current is CreateCourseQuestionsUpdated,
            builder: (context, state) {
              return SliverReorderableList(
                itemCount: cubit.lastAssignmentQuestions.length,
                itemBuilder: (context, index) {
                  final question = cubit.lastAssignmentQuestions[index];
                  final String type =
                      question is MultipleChoiseQuestion ? "MCQ" : "Essay";
                  return ReorderableDragStartListener(
                    key: ValueKey(question),
                    index: index,
                    child: CourseBuildingBlock(
                      index: question.index + 1,
                      title: question.title,
                      type: type,
                      icon: Icons.close_rounded,
                      buttonCallBack: () {
                        cubit.removeQuestion(index);
                      },
                    ),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  cubit.reOrderQuestions(oldIndex, newIndex);
                },
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.h),
              child: CTAButton(
                text: AppStrings.submit,
                onPressed: () {
                  if (!_formKey.currentState!.validate() ||
                      cubit.lastAssignmentQuestions.isEmpty) {
                    context.message(
                        message: "Please add title and at least one question");
                    return;
                  }

                  final NormalizedCourseAssignment assignment =
                      NormalizedCourseAssignment(
                    index: cubit.courseContent.length,
                    title: _titleController.text,
                    questions: cubit.lastAssignmentQuestions,
                  );
                  cubit.resetQuestions();

                  cubit.saveItem(assignment);
                  context.pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MultipleChoiceQuestionDialog extends StatefulWidget {
  final Function(Question) onSave;
  final int index;

  const MultipleChoiceQuestionDialog(
      {super.key, required this.onSave, required this.index});

  @override
  State<MultipleChoiceQuestionDialog> createState() =>
      _MultipleChoiceQuestionDialogState();
}

class _MultipleChoiceQuestionDialogState
    extends State<MultipleChoiceQuestionDialog> {
  final titleController = TextEditingController();
  final List<TextEditingController> optionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  int selectedAnswerIndex = 0;

  void _addOption() {
    if (optionControllers.length < 4) {
      setState(() {
        optionControllers.add(TextEditingController());
      });
    }
  }

  void _removeOption(int index) {
    if (optionControllers.length > 2) {
      setState(() {
        optionControllers.removeAt(index);
      });
    }
  }

  void _saveQuestion() {
    if (titleController.text.isEmpty ||
        optionControllers.any((controller) => controller.text.isEmpty)) {
      context.message(message: "Please fill all fields");
      return;
    }

    final question = MultipleChoiseQuestion(
      index: widget.index,
      title: titleController.text,
      answers: optionControllers
          .map((controller) => Answer(
              text: controller.text,
              isTrue: selectedAnswerIndex == widget.index))
          .toList(),
    );
    widget.onSave(question);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8.h,
      children: [
        InputField(
          controller: titleController,
          title: "Question",
        ),
        ...List.generate(
          optionControllers.length,
          (index) => Row(
            children: [
              Radio(
                value: index,
                groupValue: selectedAnswerIndex,
                onChanged: (value) {
                  setState(() {
                    selectedAnswerIndex = value as int;
                  });
                },
              ),
              Expanded(
                child: InputField(
                  controller: optionControllers[index],
                  title: "Option ${index + 1}",
                ),
              ),
              if (optionControllers.length > 2)
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () => _removeOption(index),
                ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: _addOption,
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.lightSurfaceToDarkSecondary,
              ),
              child: const Text('Add Option'),
            ),
            ElevatedButton(
              onPressed: _saveQuestion,
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white),
              child: const Text('Save Question'),
            ),
          ],
        ),
      ],
    );
  }
}

class EssayQuestionDialog extends StatefulWidget {
  final Function(Question) onSave;
  final int index;

  const EssayQuestionDialog(
      {super.key, required this.onSave, required this.index});

  @override
  State<EssayQuestionDialog> createState() => _EssayQuestionDialogState();
}

class _EssayQuestionDialogState extends State<EssayQuestionDialog> {
  final titleController = TextEditingController();
  final answerController = TextEditingController();

  void _saveQuestion() {
    if (titleController.text.isEmpty || answerController.text.isEmpty) {
      context.message(message: "Please fill all fields");
      return;
    }

    final question = EssayQuestion(
      index: widget.index,
      title: titleController.text,
      answer: Answer(text: answerController.text, isTrue: true),
    );
    widget.onSave(question);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8.h,
      children: [
        InputField(
          controller: titleController,
          title: "Question",
        ),
        InputField(
          controller: answerController,
          title: "Model Answer",
          maxLines: 3,
        ),
        const SizedBox.shrink(),
        ElevatedButton(
          onPressed: _saveQuestion,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Save Question'),
        ),
      ],
    );
  }
}
