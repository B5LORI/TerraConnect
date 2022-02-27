import 'package:clean_pathern_flutter/core_loredana/error/failures.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}