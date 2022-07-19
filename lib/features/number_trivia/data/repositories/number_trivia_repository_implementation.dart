import 'package:ca_number_trivia/core/data/model/api_response.dart';
import 'package:ca_number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/NumberTrivia.dart';

class NumberTriviaRepositoryImplementation implements NumberTriviaRepository {

  // final DioClient _dioClient = locator<DioClient>();


  @override
  Future<Response<JobApplicantsResponse>?> fetchApplicants({Map<dynamic, dynamic>? params}) async{

    Response<JobApplicantsResponse>? _apiResponse =  Response.error(tryAgainErrorMessage, 400);
    await _dioClient.post(
      path: applicantListEndpoint,
      header: _dioClient.getHeader(locator<SessionManager>()),
      request: params,
      responseCallback: (response, message){
        logger.printDebugLog(response);
        _apiResponse = Response.success(JobApplicantsResponse.fromJson(response));
      },
      failureCallback: (message, statusCode){
        logger.printErrorLog(message);
        _apiResponse = Response.error(message, statusCode);
      },
    );
    return _apiResponse;
  }

  final String BASE_URL= "http://numbersapi.com/random/";
  @override
  Future<Response<NumberTrivia>?> getCustomNumberTrivia(int number) async {
    Response<NumberTrivia>? _apiResponse =  Response.error("Please try again...", 400);
    var url = Uri.parse(BASE_URL+"?json");

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _apiResponse;
  }

  @override
  Future<Response<NumberTrivia>?> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}