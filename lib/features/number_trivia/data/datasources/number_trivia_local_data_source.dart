import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheLastNumberTrivia(NumberTriviaModel numberTriviaToCache);
}