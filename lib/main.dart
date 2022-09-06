import 'package:book/pages/splash_screen_page.dart';
import 'package:book/provider/notification_provider.dart';
import 'package:book/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyCustomApp());
}

class MyCustomApp extends StatefulWidget {
  const MyCustomApp({Key? key}) : super(key: key);

  @override
  State<MyCustomApp> createState() => _MyCustomAppState();
}

class _MyCustomAppState extends State<MyCustomApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ((context) => ThemeProvider())),
          ChangeNotifierProvider(create: (context) => NotificationProvider())
        ],
        child: Consumer(
          builder: (context, value, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SecondPage(),
              theme: context.watch<ThemeProvider>().isDark ? ThemeData.dark() : ThemeData.light(),
            );
          },
        ));
  }
}
