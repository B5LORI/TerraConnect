import 'package:clean_pathern_flutter/features/number_trivia_el/domain/entities/number_trivia.dart';
import 'package:clean_pathern_flutter/features/number_trivia_el/domain/repositories/number_trivia_repository.dart';
import 'package:clean_pathern_flutter/features/number_trivia_el/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp((){
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });


  final testNumber = 1;
  final testNumberTrivia = NumberTrivia(number: 1, text: 'test');
  test(
      'should get trivia from the number from the repository',
          () async {
          // arrange
          when(mockNumberTriviaRepository.getConcreteNumberTrivia(1))
              .thenAnswer((_) async => Right(testNumberTrivia));
          // act
          //final result = await usecase.execute(number: testNumber);
          // assert
         //  expect(result, Right(testNumberTrivia));
           verify(mockNumberTriviaRepository.getConcreteNumberTrivia(testNumber));
           verifyNoMoreInteractions(mockNumberTriviaRepository);
          });
}