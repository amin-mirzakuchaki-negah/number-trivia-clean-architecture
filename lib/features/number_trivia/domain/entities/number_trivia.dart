import 'package:equatable/equatable.dart';

class NumberTrivia extends Equatable {
  final String text;
  final int number;

  const NumberTrivia({required this.text, required this.number}) : super(); //should we write this super constructor?
  
  @override
  // TODO: implement props
  List<Object?> get props => [text, number]; //Is this replacement of : super([text, number])?


}