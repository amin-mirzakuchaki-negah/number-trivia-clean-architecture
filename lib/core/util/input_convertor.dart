import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../error/failure.dart';

@lazySingleton
class InputConvertor {
  Either<Failure, int> stringToUnsignedInt(String str) {
    try {
      final integer =int.parse(str);
      if(integer < 0) throw const FormatException();
      return Right(integer);
    } //
    on FormatException {
      return Left(InvalidInputFailure());
    }
  } 
}

class InvalidInputFailure extends Failure {}