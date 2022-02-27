import 'package:get_it/get_it.dart';

import 'features/number_trivia_loredana/presentation/bloc/number_trivia_bloc.dart';

final serverLocater= GetIt.instance;

void init(){
  //! Features - NumberTrivia
  // Bloc
  serverLocater.registerFactory(
          () => NumberTriviaBloc(
              concrete: serverLocater(),
              inputConverter: serverLocater(),
              random: serverLocater()
          ),
  );

  serverLocater.registerLazySingleton(() => null);
  //! Core

  //! External
}