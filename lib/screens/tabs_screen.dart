import 'package:flutter/material.dart';
import 'package:mealapp/providers/theme_provider.dart';

import '../screens/categories_screen.dart';
import 'package:mealapp/screens/favorite_screen.dart';
import '../widgets/drawer_item.dart';
import 'package:mealapp/providers/meal_provider.dart';

import 'package:provider/provider.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  List <Map<String, Object>> _pages ;

  @override
  initState(){
    Provider.of<MealProvider>(context, listen: false).setData();
    Provider.of<ThemeProvider>(context, listen: false).getThemeData();
    Provider.of<ThemeProvider>(context, listen: false).getThemeColors();

    super.initState();
    _pages = [
      {
        'page' : CategoriesScreen(),
        'title' : "Categories",
      },
      {
        'page' : FavoriteScreen(),
        'title' : "Your Favorite",
      },
    ];
  }

  int selector = 0;

  void _selectPage(int value) {
    setState(() {
      selector = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[selector]['title']),
      ),
      body: _pages[selector]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: selector,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorites"
          )
        ],

      ),
      drawer: DrawerItem(),
    );
  }


}
