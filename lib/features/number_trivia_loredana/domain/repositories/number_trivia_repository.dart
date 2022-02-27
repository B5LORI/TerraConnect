
import 'package:clean_pathern_flutter/core_loredana/error/failures.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int? number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();

}