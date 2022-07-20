import '../../../../core/data/model/api_response.dart';
import '../../data/models/NumberTrivia.dart';
import '../repositories/number_trivia_repository.dart';
import 'number_trivia_usecase.dart';

class CustomNumberTriviaUseCase extends NumberTriviaUseCase {

  CustomNumberTriviaUseCase(NumberTriviaRepository numberTriviaRepository) : super(numberTriviaRepository);

  Future<Response<NumberTrivia>?> fetchCustomNumberTrivia({required int number}) async {
    return await numberTriviaRepository.getCustomNumberTrivia(number);
  }
}