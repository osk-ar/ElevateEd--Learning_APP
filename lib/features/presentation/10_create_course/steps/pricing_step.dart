import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/core/managers/validation_manager.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:ElevatED/features/presentation/0_common/hint_widget.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubits/pricing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PricingStep extends StatefulWidget {
  const PricingStep({
    super.key,
    required this.priceController,
  });

  final TextEditingController priceController;

  @override
  State<PricingStep> createState() => _PricingStepState();
}

class _PricingStepState extends State<PricingStep> {
  final formKey = GlobalKey<FormState>();
  final feesController = TextEditingController();
  final instructorRevenueController = TextEditingController();
  late final PricingCubit pricingCubit;

  @override
  void initState() {
    super.initState();
    pricingCubit = context.read<PricingCubit>();
  }

  @override
  void dispose() {
    feesController.dispose();
    instructorRevenueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 4.h,
          children: [
            SizedBox(height: 8.h),
            InputField(
              title: AppStrings.totalPriceLabel,
              controller: widget.priceController,
              keyboardType: TextInputType.number,
              suffixIcon: const CurrencyTag(),
              onChanged: (totalPriceString) {
                if (!formKey.currentState!.validate()) return;
                pricingCubit.updatePricing(
                  widget.priceController,
                  feesController,
                  instructorRevenueController,
                );
              },
              validator: ValidationManager.validateCoursePrice,
            ),
            HintWidget(AppStrings.totalPriceHint),
            SizedBox(height: 8.h),
            InputField(
              title: AppStrings.feesLabel,
              controller: feesController,
              isReadOnly: true,
              suffixIcon: const CurrencyTag(),
            ),
            HintWidget(AppStrings.feesHint),
            SizedBox(height: 8.h),
            InputField(
              title: AppStrings.revenueLabel,
              controller: instructorRevenueController,
              keyboardType: TextInputType.number,
              isReadOnly: true,
              suffixIcon: const CurrencyTag(),
            ),
            HintWidget(AppStrings.revenueHint),
          ],
        ),
      ),
    );
  }
}

/*
Total Price
our fees
Your Revenue Per Subscription
 */

class HintWidget extends StatelessWidget {
  const HintWidget(
    this.hint, {
    super.key,
  });
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Text(hint,
        textAlign: TextAlign.start,
        style: getRegularStyle(
          fontSize: 14.sp,
          color: ThemeColors.subTextColor,
        ));
  }
}

class CurrencyTag extends StatelessWidget {
  const CurrencyTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        "\$",
        style: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
