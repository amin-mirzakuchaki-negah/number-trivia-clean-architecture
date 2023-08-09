import 'dart:convert';

import 'package:number_trivia_clean_architecture/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheLastNumberTrivia(NumberTriviaModel numberTriviaToCache);
}

String CACHED_NUMBER_TRIVIA = "CACHED_NUMBER_TRIVIA";

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if(jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString!)));
    }//
    else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheLastNumberTrivia(NumberTriviaModel numberTriviaToCache) {
    // TODO: implement cacheLastNumberTrivia
    throw UnimplementedError();
  }
}
