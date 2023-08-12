part of 'number_trivia_bloc.dart';

sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetConcreteNumberTriviaEvent extends NumberTriviaEvent {
  final String numberString;

  const GetConcreteNumberTriviaEvent(this.numberString);
  
  @override
  List<Object> get props => [numberString];
}

class RandomGetNumberTriviaEvent extends NumberTriviaEvent {}
