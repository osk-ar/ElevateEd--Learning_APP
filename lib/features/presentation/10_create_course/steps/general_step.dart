import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/core/managers/validation_manager.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubits/general_cubit.dart';
import 'package:ElevatED/features/presentation/10_create_course/states/general_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralStep extends StatefulWidget {
  const GeneralStep({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  State<GeneralStep> createState() => _GeneralStepState();
}

class _GeneralStepState extends State<GeneralStep> {
  late final GeneralCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<GeneralCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Column(
        spacing: 16.h,
        children: [
          InputField(
            controller: widget.titleController,
            title: AppStrings.courseTitle,
            validator: (value) => ValidationManager.validateCourseTitle(value),
            onChanged: (value) {
              cubit.updateCourseDetails(
                title: value,
                description: widget.descriptionController.text,
              );
            },
          ),
          InputField(
            controller: widget.descriptionController,
            title: AppStrings.courseDescription,
            maxLines: 6,
            validator: (value) =>
                ValidationManager.validateCourseDescription(value),
            onChanged: (value) {
              cubit.updateCourseDetails(
                title: widget.titleController.text,
                description: value,
              );
            },
          ),
          const Text("Select Category:"),
          BlocBuilder<GeneralCubit, GeneralState>(
            buildWhen: (previous, current) =>
                current is GeneralCategoriesLoading ||
                current is GeneralCategoriesLoaded ||
                current is GeneralCategoriesError ||
                current is GeneralCategoryChanged,
            builder: (context, state) {
              if (state is GeneralCategoriesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GeneralCategoriesError) {
                return Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                );
              } else if (state is GeneralCategoriesLoaded ||
                  cubit.categories.isNotEmpty) {
                final categories = cubit.categories;
                return DropdownButtonFormField<int>(
                  value: cubit.selectedCategoryId == 0
                      ? null
                      : cubit.selectedCategoryId,
                  items: categories
                      .map((cat) => DropdownMenuItem<int>(
                            value: cat.id,
                            child: Text(cat.name),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      cubit.updateCategory(val);
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(),
                    fillColor: ThemeColors.lightSurfaceToDarkSecondary,
                    filled: true,
                  ),
                  validator: (val) => val == null || val == 0
                      ? "Please select a category"
                      : null,
                );
              } else {
                return const Text("No categories available");
              }
            },
          ),
        ],
      ),
    );
  }
}
