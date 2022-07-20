import 'package:ca_number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:ca_number_trivia/features/number_trivia/domain/usecases/number_trivia_usecase.dart';

import '../../../../core/data/model/api_response.dart';
import '../../data/models/NumberTrivia.dart';


class RandomNumberTriviaUseCase extends NumberTriviaUseCase {

  RandomNumberTriviaUseCase(NumberTriviaRepository numberTriviaRepository) : super(numberTriviaRepository);

  Future<NumberTrivia?> fetchRandomNumberTrivia() async {
    return await numberTriviaRepository.getRandomNumberTrivia();
  }
}