import 'dart:convert';

import 'package:clean_pathern_flutter/core_loredana/error/exception.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures_loredana/fixed_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl (sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia',() {
    final  tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test(
      'should return NumberTriviaModel from SharedPreferences when there is one in the cache',
        ()async {
        //arrange
          when(mockSharedPreferences.getString(any)).thenReturn(fixture('trivia_cached.json'));
          //act
          final result= await dataSource.getLastNumberTrivia();
          //assert
          verify(mockSharedPreferences.getString(cachedNumberTrivia));
          expect(result, equals(tNumberTriviaModel));
        }
    );

    test(
        'should throw a CacheException when there is not a cached value ',
            ()async {
          //arrange
          when(mockSharedPreferences.getString(any)).thenReturn('null');
          //act
          final call= await dataSource.getLastNumberTrivia;
          //assert
          expect(() => call(), throwsA(TypeMatcher<CacheException>()));
        }
    );
  });

  group('cacheNumberTrivia',(){
    final tNumberTriviaModel = NumberTriviaModel(text: 'test trivia', number: 1);

    test(
      'shold call SharePreferences to cache the data',
        () async {
        // act
          dataSource.cacheNumberTrivia(tNumberTriviaModel);
          //assert
          final expectedJsonSrtring= json.encode(tNumberTriviaModel.toJson());
          verify(mockSharedPreferences.setString(cachedNumberTrivia, expectedJsonSrtring));
        }
    );
  });
}