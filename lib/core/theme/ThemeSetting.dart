import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import 'theme_manager.dart';

class ThemeSettintg extends StatefulWidget {
  const ThemeSettintg({Key? key}) : super(key: key);

  @override
  State<ThemeSettintg> createState() => _ThemeSettintgState();
}

class _ThemeSettintgState extends State<ThemeSettintg> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configure'),
      ),
      body: Consumer<ThemeNotifier>(
        builder: (context, theme, _) => Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              itemCount: AppTheme.values.length,
              itemBuilder: (context, index) {
                // Enums expose their values as a list - perfect for ListView
                // Store the theme for the current ListView item
                final itemAppTheme = AppTheme.values[index];
                return Card(
                  // Style the cards with the to-be-selected theme colors
                  color: appThemeData[itemAppTheme]!.primaryColor,
                  child: ListTile(
                    title: Text(
                      itemAppTheme.toString().split('.')[1],
                      // To show light text with the dark variants...
                      style: appThemeData[itemAppTheme]!.textTheme.bodyText1,
                    ),
                    onTap: () {
                      switch (index) {
                        case 0:
                          theme.setLightGreen();
                          break;
                        case 1:
                          theme.setDarkGreen();
                          break;
                        case 2:
                          theme.setLightBlue();
                          break;
                        case 3:
                          theme.setDarkBlue();
                          break;
                        default:
                          theme.setLightMode();
                          break;
                      }
                    },
                  ),
                );
              },
            ),
            Divider(
              height: 50,
              color: theme.getTheme().primaryColorDark,
            ),
            const Text(
              'Font Size:',
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
            ),
            Slider(
              value: theme.getFontSize(),
              max: 100,
              min: 10,
              divisions: 45,
              label: theme.getFontSize().toString(),
              onChanged: (double value) {
                setState(() {
                  theme.setFontSize(value);
                });
              },
              onChangeEnd: (value) {
                if (value > 45) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "You may need to scroll in the card to view full content"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
