import 'package:equatable/equatable.dart';
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

class PricingState extends Equatable {
  final int totalPrice;

  const PricingState(this.totalPrice);

  @override
  List<Object?> get props => [];
}

class PricingInitial extends PricingState {
  const PricingInitial() : super(0);

  @override
  List<Object?> get props => [totalPrice];
}

class PricingUpdated extends PricingState {
  const PricingUpdated(super.totalPrice);

  @override
  List<Object?> get props => [totalPrice];
}
