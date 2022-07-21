import 'package:bloc/bloc.dart';
import 'package:ca_number_trivia/core/di/app_component.dart';
import 'package:ca_number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:ca_number_trivia/features/number_trivia/domain/usecases/custom_number_trivia_usecase.dart';
import 'package:ca_number_trivia/features/number_trivia/domain/usecases/random_number_trivia_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../core/logger/logger.dart';
import '../../../../core/utils/message.dart';
part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc() : super(NumberTriviaInitial()) {
    on<FetchRandomTriviaEvent>(_fetchRandomNumber);
    on<FetchCustomTriviaEvent>(_fetchCustomNumber);
    // on<InputFormValidation>(_inputValidation);
  }


  _fetchRandomNumber(NumberTriviaEvent event, Emitter<NumberTriviaState> emit) async {
    var useCase = RandomNumberTriviaUseCase(locator<NumberTriviaRepository>());
    emit(OnLoading());
    var response = await useCase.fetchRandomNumberTrivia();

    if(response!=null){

      emit(FetchTriviaSuccess(
          text: response.text.toString(),
          type: response.type.toString()));
    } else {
      logger.printDebugLog('I am here');
      emit(OnFailure(tryAgainErrorMessage));
    }
  }

  _inputValidation(InputFormValidation event, Emitter<NumberTriviaState> emit) async {
    logger.printDebugLog('Input Validation: ${event.number}');
    if (event.number!.isEmpty) {
      emit(InputFormValidationState("Please enter a number"));
    }
  }

  _fetchCustomNumber(FetchCustomTriviaEvent event, Emitter<NumberTriviaState> emit) async {
    var useCase = CustomNumberTriviaUseCase(locator<NumberTriviaRepository>());
    // emit(InputFormValidationState("Please enter a number"));
    emit(OnLoading());
    var response = await useCase.fetchCustomNumberTrivia(number: event.number);

    if(response!=null){

      emit(FetchTriviaSuccess(
          text: response.text.toString(),
          type: response.type.toString()));
    } else {
      logger.printDebugLog('I am here');
      emit(OnFailure(tryAgainErrorMessage));
    }
  }
}
