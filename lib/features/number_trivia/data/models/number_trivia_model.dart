import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({required super.number, required super.text}); //ask

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) => NumberTriviaModel(text: json['text'], number: json['number']);

  Map<String, dynamic> toJson() => {'text': text, 'number': number};
}
