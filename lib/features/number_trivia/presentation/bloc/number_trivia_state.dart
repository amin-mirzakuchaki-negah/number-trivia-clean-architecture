part of 'number_trivia_bloc.dart';

sealed class NumberTriviaState extends Equatable {
  const NumberTriviaState();
  
  @override
  List<Object?> get props => [];
}

final class NumberTriviaInitial extends NumberTriviaState {}

class NumberTriviaLoadingState extends NumberTriviaState {}

class NumberTriviaSuccessState extends NumberTriviaState {
  final NumberTrivia response;

  const NumberTriviaSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class NumberTriviaFailureState extends NumberTriviaState {
  final String? message;

  const NumberTriviaFailureState([this.message]);
  @override
  List<Object?> get props => [message];
}
class NumberTriviaCacheFailureState extends NumberTriviaState {
  final String? message;

  const NumberTriviaCacheFailureState([this.message]);
  @override
  List<Object?> get props => [message];
}

class InputFailureState extends NumberTriviaState {
  final String? message;

  const InputFailureState([this.message]);
  @override
  List<Object?> get props => [message];
}