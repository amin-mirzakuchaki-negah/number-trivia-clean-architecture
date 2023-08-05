//getConcreteNumberTrivia and the random one have Future return 
//type due to these methods get data from data sources and
//data sources have a future return type

import 'package:dartz/dartz.dart';
import 'package:number_trivia_clean_architecture/core/error/failure.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number); //NumberTrivia as successful object
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia(NumberTrivia tNumberTrivia);
}