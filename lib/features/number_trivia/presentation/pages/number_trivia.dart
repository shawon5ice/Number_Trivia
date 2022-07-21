import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/theme_manager.dart';
import '../bloc/number_trivia_bloc.dart';

class NumberTriviaPage extends StatefulWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  State<NumberTriviaPage> createState() => _NumberTriviaPageState();
}

ThemeManager _themeManager = ThemeManager();

class _NumberTriviaPageState extends State<NumberTriviaPage>
    with SingleTickerProviderStateMixin {
  late NumberTriviaBloc _numberTriviaBloc;
  late TextEditingController _customTextEditorController;
  TabController? _tabController;
  int? selectedTabIndex = 0;
  bool status = false;

  @override
  void dispose() {
    _themeManager.removeListener(themeListner);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _numberTriviaBloc = BlocProvider.of<NumberTriviaBloc>(context);
    _numberTriviaBloc.stream.listen((state) {});
    _tabController = TabController(length: 2, vsync: this);
    _tabController?.addListener(_setActiveTabIndex);
    _customTextEditorController = TextEditingController();
    _themeManager.addListener(themeListner);
  }


  themeListner(){
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 100.0,
                      height: 55.0,
                      toggleSize: 45.0,
                      value: status,
                      borderRadius: 30.0,
                      padding: 2.0,
                      activeToggleColor: Color(0xFF6E40C9),
                      inactiveToggleColor: Color(0xFF2F363D),
                      activeSwitchBorder: Border.all(
                        color: Color(0xFF3C1E70),
                        width: 6.0,
                      ),
                      inactiveSwitchBorder: Border.all(
                        color: Color(0xFFD1D5DA),
                        width: 6.0,
                      ),
                      activeColor: Color(0xFF271052),
                      inactiveColor: Colors.white,
                      activeIcon: Icon(
                        Icons.nightlight_round,
                        color: Color(0xFFF8E3A1),
                      ),
                      inactiveIcon: Icon(
                        Icons.wb_sunny,
                        color: Color(0xFFFFDF5D),
                      ),
                      onToggle: (val) {
                        setState(() {
                          status = val;
                          _themeManager.toggleTheme(status);
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text("Value: $status"),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
          return SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Container(
                  width: double.infinity,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.white,
                    tabs: const [
                      Text(
                        'Random',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Text(
                        'Custom',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: TabBarView(
                    children: [
                      _getRandomTrivia(state),
                      _getCustomTrivia(state),
                    ],
                    controller: _tabController,
                  ),
                ),
                selectedTabIndex == 0
                    ? ElevatedButton(
                        onPressed: state is OnLoading
                            ? null
                            : () {
                                _numberTriviaBloc.add(FetchRandomTriviaEvent());
                              },
                        child: const Text('Get a random Trivia'),
                      )
                    : ElevatedButton(
                        style: const ButtonStyle(),
                        onPressed: state is OnLoading
                            ? null
                            : () {
                                _numberTriviaBloc.add(FetchCustomTriviaEvent(
                                    int.parse(
                                        (_customTextEditorController.text))));
                              },
                        child: const Text('Get a your Trivia'),
                      ),
              ],
            ),
          ));
        },
      ),
    );
  }

  void _setActiveTabIndex() {
    setState(() {
      selectedTabIndex = _tabController?.index;
      if (selectedTabIndex == 0) {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }
    });
  }

  _getRandomTrivia(NumberTriviaState state) {
    return Column(
      children: [
        Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 5,
          color: state is OnLoading
              ? Colors.yellow
              : state is OnFailure
                  ? Colors.red
                  : state is FetchTriviaSuccess
                      ? Colors.green
                      : Colors.white,
          child: Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            child: Center(
              child: state is OnLoading
                  ? const SpinKitSquareCircle(
                      color: Colors.black,
                    )
                  : Text(
                      state is OnFailure
                          ? 'Failed...'
                          : state is FetchTriviaSuccess
                              ? state.text
                              : 'You not clicked for trivia',
                      style: const TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }

  _getCustomTrivia(NumberTriviaState state) {
    return Column(
      children: [
        Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 5,
          color: state is OnLoading
              ? Colors.yellow
              : state is OnFailure
                  ? Colors.red
                  : state is FetchTriviaSuccess
                      ? Colors.green
                      : Colors.white,
          child: Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            child: Center(
              child: state is OnLoading
                  ? const SpinKitSquareCircle(
                      color: Colors.black,
                    )
                  : Text(
                      state is OnFailure
                          ? 'Failed...'
                          : state is FetchTriviaSuccess
                              ? state.text
                              : 'You not clicked for trivia',
                      style: const TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: _customTextEditorController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: 'Enter a number',
              errorText: _customTextEditorController.text.isEmpty
                  ? "Please enter a number"
                  : '',
              errorBorder: null),
        ),
      ],
    );
  }
}
