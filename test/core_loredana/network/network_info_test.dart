import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:clean_pathern_flutter/core_loredana/platform/network_info.dart';

class MockDataConectionCheker extends Mock implements DataConnectionChecker{}

void main(){
  late NetworkInfoImpl networkInfo;
  late MockDataConectionCheker mockDataConectionCheker;

  setUp((){
    mockDataConectionCheker =MockDataConectionCheker();
    networkInfo = NetworkInfoImpl(mockDataConectionCheker);
  });

  group('isConnected', (){
    test(
        'should forward the call to DataConectionCheker.hasConnection',
    () async {
          final tHasConnectionFuture =Future.value(true);
          when(mockDataConectionCheker.hasConnection).thenAnswer((_) => tHasConnectionFuture);
          final result= await networkInfo.isConnected;
          verify(mockDataConectionCheker.hasConnection);
          expect(result, tHasConnectionFuture);
    });
  });
}