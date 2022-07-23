import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import 'theme_manager.dart';

class ThemeSettintg extends StatelessWidget {
  const ThemeSettintg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change theme'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: AppTheme.values.length,
        itemBuilder: (context, index) {
          // Enums expose their values as a list - perfect for ListView
          // Store the theme for the current ListView item
          final itemAppTheme = AppTheme.values[index];
          return Consumer<ThemeNotifier>(
            builder: (context, theme, _) => Card(
              // Style the cards with the to-be-selected theme colors
              color: appThemeData[itemAppTheme]!.primaryColor,
              child: ListTile(
                title: Text(
                  itemAppTheme.toString(),
                  // To show light text with the dark variants...
                  style: appThemeData[itemAppTheme]!.textTheme.bodyText1,
                ),
                onTap: () {
                  switch(index){
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
            ),
          );
        },
      ),
    );
  }
}
