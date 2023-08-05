import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  // ignore: unused_local_variable
  late GetConcreteNumberTrivia usecase; //Also it is used in setUp method
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  setUp(
    () {
      mockNumberTriviaRepository = MockNumberTriviaRepository();
      usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
    },
  );

  const tNumber = 1;
  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test(
    'should get trivia for the number from the repository',
    ()async {
      // arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(10)).thenAnswer((_) async => Right(tNumberTrivia));
      // act
      final result = await usecase.execute(number: tNumber);
      // assert
      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia(tNumberTrivia));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    }
  );
}
