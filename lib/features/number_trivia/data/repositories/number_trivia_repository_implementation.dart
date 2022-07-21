
import 'dart:convert';

import 'package:ca_number_trivia/core/utils/constant.dart';
import 'package:ca_number_trivia/core/utils/end_points.dart';
import 'package:ca_number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:http/http.dart' as http;
import '../../../../core/logger/logger.dart';
import '../models/NumberTrivia.dart';

class NumberTriviaRepositoryImplementation implements NumberTriviaRepository {


  @override
  Future<NumberTrivia?> getRandomNumberTrivia() async{
    NumberTrivia? _apiResponse;

    try {
      var response = await http.get(Uri.parse(baseUrl+randomNumberEndPoint));
      if(response.statusCode==200){
        logger.printDebugLog(response);
        _apiResponse = NumberTrivia.fromJson(jsonDecode(response.body));
      }
    } on Exception catch (e) {
      logger.printErrorLog(e);
    }
    return _apiResponse;
  }



  @override
  Future<NumberTrivia?> getCustomNumberTrivia(int number) async {
    NumberTrivia? _apiResponse;

    try {
      var response = await http.get(Uri.parse(baseUrl+number.toString()+customNumberEndPoint));

      if(response.statusCode==200){
        logger.printDebugLog(response);
        _apiResponse = NumberTrivia.fromJson(jsonDecode(response.body));
      }
    } on Exception catch (e) {
      logger.printErrorLog(e);
    }
    return _apiResponse;
  }
}