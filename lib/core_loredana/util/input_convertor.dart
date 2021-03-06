import 'package:clean_pathern_flutter/core_loredana/error/failures.dart';
import 'package:dartz/dartz.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String? str) {
    try {
      final integer = int.parse(str!);
      if(integer < 0 ) throw FormatException();
      return Right(int.parse(str));
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
class InvalidInputFailure extends Failure{

}