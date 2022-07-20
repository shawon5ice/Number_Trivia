import 'package:ca_number_trivia/features/number_trivia/data/repositories/number_trivia_repository_implementation.dart';
import 'package:ca_number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/sources/dio_client.dart';
import '../logger/logger.dart';
import '../utils/constant.dart';

final locator = GetIt.instance;



class AppComponent {
  Future<void> init() async {
    locator.registerFactory<Dio>(() => Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
    ))
      ..interceptors.add(Logging()));
    locator.registerFactory<DioClient>(() => DioClient(locator<Dio>()));
    locator.registerFactory<NumberTriviaRepositoryImplementation>(() => NumberTriviaRepositoryImplementation());
    locator.registerFactory<NumberTriviaRepository>(() => locator<NumberTriviaRepositoryImplementation>());
  }
}
