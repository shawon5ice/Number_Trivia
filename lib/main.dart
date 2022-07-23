import 'package:ca_number_trivia/core/theme/theme_manager.dart';
import 'package:ca_number_trivia/core/theme/themes.dart';
import 'package:ca_number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:ca_number_trivia/features/number_trivia/presentation/pages/number_trivia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/di/app_component.dart';
import 'core/session/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppComponent().init();

  locator.isReady<SessionManager>().then((value){
    runApp(ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ));
  });

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        theme: theme.getTheme(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: BlocProvider(
          create: (context) => NumberTriviaBloc(),
          child: const NumberTriviaPage(),
        ),
      ),
    );
  }
}
