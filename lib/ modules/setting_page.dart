import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        title: Text('setting'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme
                .of(context)
                .colorScheme
                .secondary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dark Mode"),
            CupertinoSwitch(value:
            Provider.of<ThemeProvider>(context, listen :false).isDarkMode,
                onChanged: (value) =>
            Provider
                .of<ThemeProvider>(context, listen: false)
                .toggleTheme())
          ],
        ),
      ),
    );
  }
}
