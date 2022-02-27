import 'package:clean_pathern_flutter/core_cata/error/failures.dart';
import 'package:clean_pathern_flutter/features/number_trivia_cata/domain/entities/number_trivia.dart';
import 'package:clean_pathern_flutter/features/number_trivia_cata/domain/repositories/number-trivia_repository.dart';
import 'package:dartz/dartz.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> execute({
    required int number
  }) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}
