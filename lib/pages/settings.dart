import 'package:book/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

bool isDark = false;

class _SettingsState extends State<Settings> {
  FloatingActionButtonLocation fLoc = FloatingActionButtonLocation.miniCenterDocked;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(children: [
        Consumer<ThemeProvider>(builder: ((context, value, child) {
          return SwitchListTile(
              title: context.watch<ThemeProvider>().isDark ? const Text('Dark mode',style: TextStyle(fontSize: 20),) : const Text('Light mode',style: TextStyle(fontSize: 20),),
              value: context.watch<ThemeProvider>().isDark,
              onChanged: (value) {
                context.read<ThemeProvider>().changeTheme();
              });
        }))
      ]),
    );
  }
}
