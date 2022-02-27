import 'package:clean_pathern_flutter/core_el/error/failure.dart';
import 'package:clean_pathern_flutter/features/number_trivia_el/domain/entities/number_trivia.dart';
import 'package:clean_pathern_flutter/features/number_trivia_el/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetConcreteNumberTrivia{
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> execute ({required int number}) async {
    return await repository.getConcreteNumberTrivia(number);

  }

}