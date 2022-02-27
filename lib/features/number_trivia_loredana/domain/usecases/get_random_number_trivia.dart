import 'package:clean_pathern_flutter/core_loredana/error/failures.dart';
import 'package:clean_pathern_flutter/core_loredana/usecases/usecase.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/repositories/number_trivia_repository.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams>{
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }

}

class NoParams extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}