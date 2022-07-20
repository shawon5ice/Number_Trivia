import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';

class NumberTriviaPage extends StatefulWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  State<NumberTriviaPage> createState() => _NumberTriviaPageState();
}

class _NumberTriviaPageState extends State<NumberTriviaPage> {
  late NumberTriviaBloc _numberTriviaBloc;

  @override
  void initState() {
    super.initState();
    _numberTriviaBloc = BlocProvider.of<NumberTriviaBloc>(context);
    _numberTriviaBloc.stream.listen((state) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Number Trivia'),),
      body: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                child: Text(
                 state is FetchTriviaSuccess? state.text : 'Loading...'
                ),
              ),
              ElevatedButton(onPressed: (){
                _numberTriviaBloc.add(FetchRandomTriviaEvent());
              },
                  child: state is OnLoading? CircularProgressIndicator():Text('Get Trivia'))
            ],
          );
        },
      ),
    );
  }
}
