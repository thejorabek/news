import 'package:book/pages/splash_screen_page.dart';
import 'package:book/provider/bookmark_provider.dart';
import 'package:book/provider/notification_provider.dart';
import 'package:book/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyCustomApp());
}

final box = GetStorage();

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
          ChangeNotifierProvider(create: (context) => NotificationProvider()),
          ChangeNotifierProvider(create: (context)=>BookmarkProvider())
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
