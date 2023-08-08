import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {

  // const NumberTriviaModel({required String text, required int number})
  //     : super(text: text, number: number);
  const NumberTriviaModel({required super.number, required super.text}); //ask

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(text: json['text'], number: json['number']);
  }
}