import 'package:equatable/equatable.dart';

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
