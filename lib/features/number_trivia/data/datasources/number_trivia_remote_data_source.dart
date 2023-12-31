// remember

import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:number_trivia_clean_architecture/core/error/exceptions.dart';

import '../models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

@LazySingleton(as: NumberTriviaRemoteDataSource)
class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) => _getTriviaFromUrl(number);

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() => _getTriviaFromUrl('random');

  Future<NumberTriviaModel> _getTriviaFromUrl(var endPoint) async {
    final response = await client.get(
      'http://numbersapi.com/$endPoint' as Uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } //
    else {
      throw ServerException();
    }
  }
}
