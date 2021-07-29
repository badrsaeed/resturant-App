import 'package:flutter/material.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/screens/themes_screen.dart';
import './screens/filters_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';

import 'package:provider/provider.dart';

import 'providers/meal_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MealProvider>(create: (ctx) => MealProvider()),
      ChangeNotifierProvider<ThemeProvider>(create: (ctx) => ThemeProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var primaryColor = Provider.of<ThemeProvider>(context).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;
    var tm = Provider.of<ThemeProvider>(context).tm;

    return MaterialApp(
      themeMode: tm,
      theme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: accentColor,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        cardColor: Colors.white,
        buttonColor: Colors.black87,
        shadowColor: Colors.white60,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              headline6: TextStyle(
                color: Colors.black87,
                fontSize: 23,
              ),
            ),
      ),
      darkTheme: ThemeData(
        unselectedWidgetColor: Colors.white70,
        primarySwatch: primaryColor,
        accentColor: accentColor,
        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        fontFamily: 'Raleway',
        cardColor: Color.fromRGBO(14, 22, 33, 1),
        buttonColor: Colors.white70,
        shadowColor: Colors.white60,
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(color: Colors.white60),
              headline6: TextStyle(
                color: Colors.white60,
                fontSize: 23,
              ),
            ),
      ),
      debugShowCheckedModeBanner: false,
      //home: MyHomePage(),
      routes: {
        '/': (context) => TabScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
        CategoryMeals.route: (context) => CategoryMeals(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        ThemesScreen.routeName: (context) => ThemesScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meal App",
        ),
      ),
      body: null,
    );
  }
}
