import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_clean_architecture/core/error/failure.dart';
import 'package:number_trivia_clean_architecture/core/usecases/usecases.dart';
import 'package:number_trivia_clean_architecture/core/util/input_convertor.dart';

import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String INVALID_INPUT_FAILURE_MESSAGE =
    "Invalid Input - The number must be positive integer or zero";

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia _getConcreteNumberTrivia;
  final GetRandomNumberTrivia _getRandomNumberTrivia;
  InputConvertor _inputConvertor;

  NumberTriviaBloc({
    required GetConcreteNumberTrivia getConcreteNumberTrivia,
    required GetRandomNumberTrivia getRandomNumberTrivia,
    required InputConvertor inputConvertor,
  })  : _getConcreteNumberTrivia = getConcreteNumberTrivia,
        _getRandomNumberTrivia = getRandomNumberTrivia,
        _inputConvertor = inputConvertor,
        super(NumberTriviaInitial()) {
    //Initializing our bloc
    on<GetConcreteNumberTriviaEvent>(_onGetConcreteNumberTriviaEvent);
    on<RandomGetNumberTriviaEvent>(_onGetRandomNumberTriviaEvent);
  }
  Future<void> _onGetConcreteNumberTriviaEvent(
    GetConcreteNumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    final inputEither = _inputConvertor.stringToUnsignedInt(event.numberString);
    inputEither.fold((failure) => failure.toState, (integer) async {
      emit(NumberTriviaLoadingState());
      final result = await _getConcreteNumberTrivia(
        Params(number: integer),
      );
      final newState = result.fold(
        (failure) => failure.toState,
        (trivia) => NumberTriviaSuccessState(response: trivia),
      );
      emit(newState);
    });
  }

  Future<void> _onGetRandomNumberTriviaEvent(
    RandomGetNumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(NumberTriviaLoadingState());
    final result =
        await _getRandomNumberTrivia(const NoParams()); //usecase call
    final newState = await result.fold(
      (failure) async => failure.toState,
      (trivia) async => NumberTriviaSuccessState(response: trivia),
    );
    emit(newState);
  }
}

extension FailureToState on Failure {
  NumberTriviaState get toState {
    switch (runtimeType) {
      case ServerFailure:
        return const NumberTriviaFailureState(SERVER_FAILURE_MESSAGE);
      case CacheFailure:
        return const NumberTriviaCacheFailureState(CACHE_FAILURE_MESSAGE);
      case InputFailure:
        return const InputFailureState(INVALID_INPUT_FAILURE_MESSAGE);
    }
    return const NumberTriviaFailureState('Something went wrong');
  }
}
