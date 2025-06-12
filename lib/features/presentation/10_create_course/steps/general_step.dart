import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/core/managers/validation_manager.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubit/create_course_cubit.dart';
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
  late final CreateCourseCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<CreateCourseCubit>();
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
          ),
          InputField(
            controller: widget.descriptionController,
            title: AppStrings.courseDescription,
            maxLines: 6,
            validator: (value) =>
                ValidationManager.validateCourseDescription(value),
          ),
          const Text("Select Category:"),
          BlocBuilder<CreateCourseCubit, CreateCourseState>(
            buildWhen: (previous, current) =>
                current is CreateCourseCategoriesLoading ||
                current is CreateCourseCategoriesLoaded ||
                current is CreateCourseCategoriesError ||
                current is CreateCourseCategoryChanged,
            builder: (context, state) {
              if (cubit.isCategoriesLoading ||
                  state is CreateCourseCategoriesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (cubit.categoriesError != null ||
                  state is CreateCourseCategoriesError) {
                final errorMsg = cubit.categoriesError ??
                    (state is CreateCourseCategoriesError
                        ? state.error
                        : "Error loading categories");
                return Text(errorMsg,
                    style: const TextStyle(color: Colors.red));
              } else if (cubit.categories.isNotEmpty ||
                  state is CreateCourseCategoriesLoaded) {
                final categories = cubit.categories.isNotEmpty
                    ? cubit.categories
                    : (state is CreateCourseCategoriesLoaded
                        ? state.categories
                        : []);
                return DropdownButtonFormField<int>(
                  value: cubit.categoryID == 0 ? null : cubit.categoryID,
                  items: categories
                      .map((cat) => DropdownMenuItem<int>(
                            value: cat.id,
                            child: Text(cat.name),
                          ))
                      .toList(),
                  onChanged: (val) => cubit.changeCategory(val),
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
