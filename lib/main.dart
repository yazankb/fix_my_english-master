import 'package:flutter/material.dart';
import 'pages.dart';

void main() {
  runApp(const FixMyEnglishApp());
}

final themedata = ThemeData(
  primaryColor:  Color(0xFF864921),
  primaryColorDark:  Color(0xFF7A370B),
  primaryColorLight:  Color(0xFFF2EEE1),
  appBarTheme:  AppBarTheme(
    backgroundColor: Color(0xFFF2EEE1),
    titleTextStyle: TextStyle(
        color:  Color(0xFF864921), fontSize: 50, fontFamily: 'Eczar'),
  ),
  hintColor:  Color(0xFF7A370B),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        onPrimary: Color(0xFFE9F1E8),
        primary: Color(0xFF4D6658),
        textStyle: TextStyle(fontFamily: 'Eczar')),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor:  Color(0xFFF2EEE1),
    filled: true,
    floatingLabelStyle: TextStyle(color: const Color(0xFF864921)),
  ),
);

///Entry widget that builds all other widgets
class FixMyEnglishApp extends StatelessWidget {
  const FixMyEnglishApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fix my English',
      theme: themedata,
      home: const RootWidget(),
    );
  }
}

///The root widget to display appropriate page widget depending on current page.
class RootWidget extends StatefulWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  State<RootWidget> createState() => _RootWidget();
}

//Application pages
enum AppPages { startPage, mainPage }

///Class that represents state controll of root widget
class _RootWidget extends State<RootWidget> {
  //Current application page
  late AppPages appState;

  //Start page widget
  late StartPageWidget startPage;

  //Main page widget
  late MainPageWidget mainPage;

  @override
  void initState() {
    super.initState();

    //The inital page is start page
    appState = AppPages.startPage;

    //Create start page widget, and listen for uploading event
    startPage = StartPageWidget(onFileUploaded: (requests) {
      setState(() {
        //When user uploads files switch to main page
        appState = AppPages.mainPage;
        //Provide all requests made in start page to main page
        mainPage.addManyAnalyses(requests);
      });
    });

    //Create main page widget
    mainPage = MainPageWidget();
  }

  @override
  Widget build(BuildContext context) {
    //Depending on current application page load appropriate page widget
    switch (appState) {
      case AppPages.startPage:
        return startPage;
      case AppPages.mainPage:
        return mainPage;
    }
  }
}
