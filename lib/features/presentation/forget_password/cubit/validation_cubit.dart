import 'package:ElevatED/features/presentation/forget_password/state/validation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidationCubit extends Cubit<ValidationState> {
  ValidationCubit() : super(ValidationInitial());
}
