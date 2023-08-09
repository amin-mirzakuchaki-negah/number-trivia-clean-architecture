part of 'number_trivia_bloc.dart';

sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetNumberTriviaConcreteEvent extends NumberTriviaEvent {
  final String numberString;

  const GetNumberTriviaConcreteEvent(this.numberString);
  
  @override
  List<Object> get props => [numberString];
}

class GetNumberTriviaRandomEvent extends NumberTriviaEvent {}
