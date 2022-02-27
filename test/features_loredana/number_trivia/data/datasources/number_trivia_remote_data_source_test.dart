import 'dart:convert';

import 'package:clean_pathern_flutter/core_loredana/error/exception.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../fixtures_loredana/fixed_reader.dart';

class MockHttpClient extends Mock implements http.Client{}

void main(){
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp((){
    mockHttpClient = MockHttpClient();
    dataSource =NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });


void setUpMockHttpClientSuccesss200(){
  when(mockHttpClient.get(any, headers: anyNamed('heardes'))).thenAnswer(
          (_) async => http.Response(fixture('trivia.json'), 200));
}

void setUpMockHttpClientFailure404(){
  when(mockHttpClient.get(any, headers: anyNamed('heardes'))).thenAnswer(
          (_) async => http.Response('Someting went wrong', 404));
}

  group('getConcreteNumberTrivi',(){
    final tNumber =1;
    final tNumberTriviaModel =NumberTriviaModel.fromJson(json.decode(fixture('trivia.Json')));

    test('''should perform a GET request an a URL with number 
    begin the endpoint and with aplication /json hearder''',
        ()async {
       setUpMockHttpClientSuccesss200();
       //act
       dataSource.getConcreteNumberTrivia(tNumber);
       //assert
          verify(mockHttpClient.get('http://numbersapi.com/$tNumber', headers: {'Content-Type': 'application/json'}));
    });

    test(
      'should return NumberTrivia when the response code is 200(success)',
        ()async {
        //arrange
        setUpMockHttpClientSuccesss200();
        // act
        final result = await dataSource.getConcreteNumberTrivia(tNumber);
        //assert
        expect(result,equals(tNumberTriviaModel));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            ()async {
          //arrange
          setUpMockHttpClientFailure404();
          // act
          final call = await dataSource.getConcreteNumberTrivia;
          //assert
          expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
        });

  });


  group('getRandomNumberTrivi',(){
    final tNumber =1;
    final tNumberTriviaModel =NumberTriviaModel.fromJson(json.decode(fixture('trivia.Json')));

    test('''should perform a GET request an a URL with number 
    begin the endpoint and with aplication /json hearder''',
            ()async {
          setUpMockHttpClientSuccesss200();
          //act
          dataSource.getRandomNumberTrivia();
          //assert
          verify(mockHttpClient.get('http://numbersapi.com/random', headers: {'Content-Type': 'application/json'}));
        });

    test(
        'should return NumberTrivia when the response code is 200(success)',
            ()async {
          //arrange
          setUpMockHttpClientSuccesss200();
          // act
          final result = await dataSource.getRandomNumberTrivia();
          //assert
          expect(result,equals(tNumberTriviaModel));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            ()async {
          //arrange
          setUpMockHttpClientFailure404();
          // act
          final call = dataSource.getRandomNumberTrivia();
          //assert
          expect(() => call, throwsA(TypeMatcher<ServerException>()));
        });

  });

}