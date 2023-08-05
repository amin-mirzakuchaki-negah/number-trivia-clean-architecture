import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => []; //why here we have to pass empty list but in number_trivia file we pass text and number
}
