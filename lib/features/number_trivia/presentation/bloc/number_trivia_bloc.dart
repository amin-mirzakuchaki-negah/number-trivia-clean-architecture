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
        super(NumberTriviaInitial()) {
    on<GetNumberTriviaConcreteEvent>(_onGetNumberTriviaConcreteEvent);
    on<GetNumberTriviaRandomEvent>(_onGetNumberTriviaRandomEvent);
  }
  Future<void> _onGetNumberTriviaConcreteEvent(
    GetNumberTriviaConcreteEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {}

  Future<void> _onGetNumberTriviaRandomEvent(
    GetNumberTriviaRandomEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(NumberTriviaLoadingState());
    final result =
        await _getRandomNumberTrivia(const NoParams()); //usecase call
    final newState = await result.fold(
      (failure) async => failure.toState,
      (response) async => NumberTriviaSuccessState(response),
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
