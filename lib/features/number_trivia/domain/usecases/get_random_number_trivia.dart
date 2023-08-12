import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:number_trivia_clean_architecture/core/error/failure.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

import '../../../../core/usecases/usecases.dart';
import '../entities/number_trivia.dart';

@lazySingleton
class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;
  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}