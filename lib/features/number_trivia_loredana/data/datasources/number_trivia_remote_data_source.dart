import 'dart:convert';

import 'package:clean_pathern_flutter/core_loredana/error/exception.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/data/models/number_trivia_model.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/entities/number_trivia.dart';
import 'package:http/http.dart' as http;


abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int? number);
  Future<NumberTriviaModel> getRandomNumberTrivia();

}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource{
  final http.Client client;
  NumberTriviaRemoteDataSourceImpl( {required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int? number) => _getTriviaFromUrl('http://numbersapi.com/$number');
  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() => _getTriviaFromUrl('http://numbersapi.com/random');

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async{
    final response = await client.get(url, headers: {'Content-Type': 'application/json'});
    if(response.statusCode == 200){
      return NumberTriviaModel.fromJson(json.decode(response.body));}
    else{
      throw ServerException();
    }
  }

}