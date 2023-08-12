import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_clean_architecture/core/error/failure.dart';
import 'package:number_trivia_clean_architecture/core/usecases/usecases.dart';

import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia _getConcreteNumberTrivia;
  final GetRandomNumberTrivia _getRandomNumberTrivia;

  NumberTriviaBloc({
    required GetConcreteNumberTrivia getConcreteNumberTrivia,
    required GetRandomNumberTrivia getRandomNumberTrivia,
  })  : _getConcreteNumberTrivia = getConcreteNumberTrivia,
        _getRandomNumberTrivia = getRandomNumberTrivia,
        super(NumberTriviaInitial()) { //Initializing our bloc
    on<GetConcreteNumberTriviaEvent>(_onGetNumberTriviaConcreteEvent);
    on<RandomGetNumberTriviaEvent>(_onGetNumberTriviaRandomEvent);
  }
  Future<void> _onGetNumberTriviaConcreteEvent(
    GetConcreteNumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {}

  Future<void> _onGetNumberTriviaRandomEvent(
    RandomGetNumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(NumberTriviaLoadingState());
    final result =
        await _getRandomNumberTrivia(const NoParams()); //usecase call
    final newState = await result.fold(
      (failure) async => failure.toState,
      (response) async => NumberTriviaSuccessState(response: response),
    );
    emit(newState);
  }
}

extension FailureToState on Failure {
  NumberTriviaState get toState {
    switch (runtimeType) {
      case ServerFailure:
        return const NumberTriviaFailureState();
      case CacheFailure :
        return const NumberTriviaCacheFailureState();
    }
    return const NumberTriviaFailureState();
  }
}
