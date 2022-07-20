import 'package:bloc/bloc.dart';
import 'package:ca_number_trivia/core/di/app_component.dart';
import 'package:ca_number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:ca_number_trivia/features/number_trivia/domain/usecases/random_number_trivia_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/data/model/api_response.dart';
import '../../../../core/logger/logger.dart';
import '../../../../core/utils/message.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc() : super(NumberTriviaInitial()) {
    on<FetchRandomTriviaEvent>(_fetchRandomNumber);
  }


  _fetchRandomNumber(NumberTriviaEvent event, Emitter<NumberTriviaState> emit) async {
    var useCase = RandomNumberTriviaUseCase(locator<NumberTriviaRepository>());
    emit(OnLoading());
    var response = await useCase.fetchRandomNumberTrivia();

    if(response!=null){

      emit(FetchTriviaSuccess(
          text: response.text.toString(),
          number: response.number.toString(),
          type: response.type.toString()));
    } else {
      logger.printDebugLog('I am here');
      emit(OnFailure(tryAgainErrorMessage));
    }
  }
}
