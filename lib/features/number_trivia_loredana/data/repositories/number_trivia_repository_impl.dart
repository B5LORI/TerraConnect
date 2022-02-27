import 'package:clean_pathern_flutter/core_loredana/error/exception.dart';
import 'package:clean_pathern_flutter/core_loredana/error/failures.dart';
import 'package:clean_pathern_flutter/core_loredana/platform/network_info.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/data/models/number_trivia_model.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/repositories/number_trivia_repository.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int? number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }


  Future<Either<Failure, NumberTrivia>> _getTrivia(
   _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}