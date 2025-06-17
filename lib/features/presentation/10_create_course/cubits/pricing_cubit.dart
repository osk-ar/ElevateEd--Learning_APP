import 'package:ElevatED/features/presentation/10_create_course/states/pricing_states.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PricingCubit extends Cubit<PricingState> {
  PricingCubit() : super(const PricingInitial());
  final double feesPercentage = 0.05;

  void updatePricing(
      TextEditingController totalPriceController,
      TextEditingController totalFeesController,
      TextEditingController totalRevenueController) {
    int totalPrice = int.parse(totalPriceController.text);
    double totalFees = totalPrice * feesPercentage;
    double totalRevenue = totalPrice - totalFees;

    totalFeesController.text = totalFees.toStringAsFixed(2);
    totalRevenueController.text = totalRevenue.toStringAsFixed(2);
  }
}
