import 'dart:convert';

import 'package:clean_pathern_flutter/core_loredana/error/exception.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/data/models/number_trivia_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const cachedNumberTrivia = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource{
  final SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl({ required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(cachedNumberTrivia, json.encode(triviaToCache.toJson()));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(cachedNumberTrivia);
    if(jsonString != 'null'){
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    }else{
      throw CacheException();
    }
  }


}