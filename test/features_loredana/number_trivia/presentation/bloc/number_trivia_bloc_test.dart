import 'package:clean_pathern_flutter/core_loredana/error/failures.dart';
import 'package:clean_pathern_flutter/core_loredana/util/input_convertor.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/entities/number_trivia.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';


class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock
    implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock
    implements InputConverter {}

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;


  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia, inputConverter: mockInputConverter,
    );
  });

  test('initialState should be Empty',
          () {
        //assert
        expect(bloc.initialState, equals(Empty()));
      });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    const tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    test(
        'should call the InputConverter to validate and convert the string to an unsigned integer', () async {
      // arrange
      setUpMockInputConverterSuccess();
      //act
      bloc.dispatch(GetTriviaFromConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      //assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test(
      'should emit [Error] when the input is invalid',
          () async {
        //arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
        //assert later
        final expected = [
          Empty(),
          Error(message: invalidInputFailureMessage)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        //act
        bloc.dispatch(GetTriviaFromConcreteNumber(tNumberString));
      },
    );

    test(
      'should get data from the concrete use case',
          () async {
        //arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        //act
        bloc.dispatch(GetTriviaFromConcreteNumber(tNumberString));
        await untilCalled(mockGetConcreteNumberTrivia(any));
        //assert
        verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));

      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
          () async {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        //assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(trivia: tNumberTrivia),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        //act
        bloc.dispatch(GetTriviaFromConcreteNumber(tNumberString));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
          () async {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        //assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: serverFailureMessage),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        //act
        bloc.dispatch(GetTriviaFromConcreteNumber(tNumberString));
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
          () async {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        //assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: cacheFailureMessage),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        //act
        bloc.dispatch(GetTriviaFromConcreteNumber(tNumberString));
      },
    );


  });

  group('GetTriviaForRandomNumber', () {

    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');


    test(
      'should get data from the concrete use case',
          () async {
        //arrange
        when(mockGetRandomNumberTrivia(NoParams()))
            .thenAnswer((_) async => Right(tNumberTrivia));
        //act
        bloc.dispatch(GetTriviaFromRandomNumber(NoParams()));
        await untilCalled(mockGetRandomNumberTrivia(NoParams()));
        //assert
        verify(mockGetRandomNumberTrivia(NoParams()));

      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
          () async {

        when(mockGetRandomNumberTrivia(NoParams()))
            .thenAnswer((_) async => Right(tNumberTrivia));
        //assert later
        final expected = [
          Empty(),
          Loading(),
          Loaded(trivia: tNumberTrivia),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        //act
        bloc.dispatch(GetTriviaFromRandomNumber(NoParams()));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
          () async {

        when(mockGetRandomNumberTrivia(NoParams()))
            .thenAnswer((_) async => Left(ServerFailure()));
        //assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: serverFailureMessage),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        //act
        bloc.dispatch(GetTriviaFromRandomNumber(NoParams()));
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
          () async {

        when(mockGetRandomNumberTrivia(NoParams()))
            .thenAnswer((_) async => Left(CacheFailure()));
        //assert later
        final expected = [
          Empty(),
          Loading(),
          Error(message: cacheFailureMessage),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        //act
        bloc.dispatch(GetTriviaFromRandomNumber(NoParams()));
      },
    );


  });
}