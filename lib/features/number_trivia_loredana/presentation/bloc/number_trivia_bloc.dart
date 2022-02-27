import 'package:bloc/bloc.dart';
import 'package:clean_pathern_flutter/core_loredana/error/failures.dart';
import 'package:clean_pathern_flutter/core_loredana/util/input_convertor.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/entities/number_trivia.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage='Invalid Input - The number must be a positive integer ';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {

  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required  GetConcreteNumberTrivia concrete,
    required GetRandomNumberTrivia random,
    required this.inputConverter
  }) : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random ;

  @override
  Stream<NumberTriviaState> mapEventToState(
      NumberTriviaEvent event,
      ) async* {
    if(event is GetTriviaFromConcreteNumber)  {
      final inputEither = inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
        (failure) async*{
          yield Error(message: invalidInputFailureMessage);
        },
          (integer) async* {
          yield Loading();
          final failureOrTrivia=
            await getConcreteNumberTrivia(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
          },
      );
    } else if(event is GetTriviaFromRandomNumber){
      yield Loading();
      final failureOrTrivia=await getRandomNumberTrivia(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(Either<Failure, NumberTrivia> failureOrTrivia)async* {
    yield failureOrTrivia.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (trivia) => Loaded(trivia: trivia),
        );
  }
   String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
   }
  @override
  // TODO: implement initialState
  NumberTriviaState get initialState => throw UnimplementedError();
}
