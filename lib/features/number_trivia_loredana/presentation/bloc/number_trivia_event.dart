part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  NumberTriviaEvent([List props = const <dynamic>[]]) ;
}


class GetTriviaFromConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaFromConcreteNumber(this.numberString): super([numberString]);


  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetTriviaFromRandomNumber extends NumberTriviaEvent {
  GetTriviaFromRandomNumber(numberString) : super(numberString);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();



}
