import 'package:equatable/equatable.dart';

abstract class Orderable extends Equatable {
  final int id;
  final int index;
  final String title;

  const Orderable({
    required this.id,
    required this.index,
    required this.title,
  });

  @override
  List<Object> get props => [id, index, title];
}
