part of '../cubits/categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesError extends CategoriesState {
  final String message;
  const CategoriesError(this.message);
  @override
  List<Object?> get props => [message];
}

class CategoriesLoaded extends CategoriesState {
  final List<CourseCategory> categories;
  final List<CourseCategory> selectedCategories;
  const CategoriesLoaded(this.categories, {this.selectedCategories = const []});
  @override
  List<Object?> get props => [categories, selectedCategories];
}
