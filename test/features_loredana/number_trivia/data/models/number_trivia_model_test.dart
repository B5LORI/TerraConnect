import 'dart:convert';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/domain/entities/number_trivia.dart';
import 'package:clean_pathern_flutter/features/number_trivia_loredana/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures_loredana/fixed_reader.dart';

void main(){
   final tNumberTriviaModel =NumberTriviaModel(number: 1, text: 'Test Text');

   test(
     'should be a subclaass of NumberTrivia entity',
       () async {
       expect(tNumberTriviaModel, isA<NumberTrivia>());
       },
   );

   group('fromJson',(){
     test(
       'should return a valid model when JSON number is an integer',
         ()async {
         final Map<String, dynamic> jsonMap=
             json.decode(fixture('trivia.json'));
         final result = NumberTriviaModel.fromJson(jsonMap);

         expect(result,tNumberTriviaModel);
         },
     );

     test(
       'should return a valid model when JSON number is a double',
           ()async {
         final Map<String, dynamic> jsonMap=
         json.decode(fixture('trivia_double.json'));
         final result = NumberTriviaModel.fromJson(jsonMap);

         expect(result,tNumberTriviaModel);
       },
     );
   });


   group('toJson', (){
     test(
       'should return a JSON map containg the proper data ',
         () async{
         final result = tNumberTriviaModel.toJson();

         final expectedMap ={
           "text": "Test Text",
           "number": 1,
         };
         expect(result, expectedMap);
         },
     );
   });
}