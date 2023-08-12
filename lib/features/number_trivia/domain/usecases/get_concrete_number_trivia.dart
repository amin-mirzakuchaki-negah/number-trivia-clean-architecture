import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:number_trivia_clean_architecture/core/usecases/usecases.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

import '../../../../core/error/failure.dart';

//According to abstract UseCase class, we have to define the type of our entity
//And secondly we have to define the type of parameter (Again due to UseCase)

@lazySingleton
class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);


  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable { //To being more clean and this class holds data for all usecase classes

  final int number;
  const Params({required this.number});

  @override
  List<Object?> get props => [number];

}
