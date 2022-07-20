
import 'package:ca_number_trivia/core/data/model/api_response.dart';
import 'package:ca_number_trivia/core/di/app_component.dart';
import 'package:ca_number_trivia/core/utils/constant.dart';
import 'package:ca_number_trivia/core/utils/end_points.dart';
import 'package:ca_number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:http/http.dart' as http;
import '../../../../core/data/sources/dio_client.dart';
import '../../../../core/logger/logger.dart';
import '../../../../core/utils/message.dart';
import '../models/NumberTrivia.dart';

class NumberTriviaRepositoryImplementation implements NumberTriviaRepository {

  // final DioClient _dioClient = locator<DioClient>();


  // @override
  // Future<Response<JobApplicantsResponse>?> fetchApplicants({Map<dynamic, dynamic>? params}) async{
  //
  //   Response<JobApplicantsResponse>? _apiResponse =  Response.error(tryAgainErrorMessage, 400);
  //   await _dioClient.post(
  //     path: applicantListEndpoint,
  //     header: _dioClient.getHeader(locator<SessionManager>()),
  //     request: params,
  //     responseCallback: (response, message){
  //       logger.printDebugLog(response);
  //       _apiResponse = Response.success(JobApplicantsResponse.fromJson(response));
  //     },
  //     failureCallback: (message, statusCode){
  //       logger.printErrorLog(message);
  //       _apiResponse = Response.error(message, statusCode);
  //     },
  //   );
  //   return _apiResponse;
  // }

  final DioClient _dioClient = locator<DioClient>();

  @override
  Future<NumberTrivia?> getRandomNumberTrivia() async{
    NumberTrivia? _apiResponse;

    try {
      var response = await http.get(Uri.parse(baseUrl+randomNumberEndPoint));
      print(baseUrl+randomNumberEndPoint);

      if(response.statusCode==200){
        logger.printDebugLog(response);
        _apiResponse = NumberTrivia.fromJson(response.body);
      }
    } on Exception catch (e) {
      logger.printErrorLog(e);
    }
    // await _dioClient.post(
    //   path: randomNumberEndPoint,
    //   responseCallback: (response, message){
    //     logger.printDebugLog(response);
    //     _apiResponse = Response.success(NumberTrivia.fromJson(response));
    //   },
    //   failureCallback: (message, statusCode){
    //     logger.printErrorLog(message);
    //     _apiResponse = Response.error(message, statusCode);
    //   },
    // );
    return _apiResponse;
  }



  @override
  Future<NumberTrivia?> getCustomNumberTrivia(int number) async {
    NumberTrivia? _apiResponse;
    await _dioClient.post(
      path: randomNumberEndPoint,
      request: number,
      responseCallback: (response, message){
        logger.printDebugLog(response);
        _apiResponse =NumberTrivia.fromJson(response);
      },
      failureCallback: (message, statusCode){
        logger.printErrorLog(message);
        // _apiResponse = Response.error(message, statusCode);
      },
    );
    return _apiResponse;
  }
}