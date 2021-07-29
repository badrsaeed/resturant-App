import 'package:flutter/material.dart';
import 'package:mealapp/modules/category.dart';

import 'package:mealapp/modules/meal.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';

class MealProvider with ChangeNotifier {
  List<Meal> favoritMeals = [];
  List<String> prefsMealId = [];
  List<Meal> availableMeal = DUMMY_MEALS;
  List<Category> availableCategory = [];

  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  void setFilters() async {
    availableMeal = DUMMY_MEALS.where((meal) {
      if (filters['gluten'] && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose'] && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan'] && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian'] && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    List<Category> ac = [];
    availableMeal.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if(catId == cat.id){
            if(!ac.any((cat) => cat.id == catId)) {
              ac.add(cat);
            }
          }
        });
      });
    });
    availableCategory = ac;

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten', filters['gluten']);
    prefs.setBool('lactose', filters['lactose']);
    prefs.setBool('vegan', filters['vegan']);
    prefs.setBool('vegetarian', filters['vegetarian']);
  }

  void setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['lactose'] = prefs.getBool('lactose') ?? false;
    filters['vegan'] = prefs.getBool('vegan') ?? false;
    filters['vegetarian'] = prefs.getBool('vegetarian') ?? false;

    prefsMealId = prefs.getStringList('prefsMealId') ?? [];
    for (var mealId in prefsMealId) {
      final existingIndex = favoritMeals.indexWhere((meal) => meal.id == mealId);

      if (existingIndex < 0)
        favoritMeals.add(DUMMY_MEALS.firstWhere(((meal) => meal.id == mealId)));
    }
    setFilters();
    notifyListeners();
  }

  void toggleFavorite(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingIndex = favoritMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      favoritMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    } else {
      favoritMeals.add(DUMMY_MEALS.firstWhere(((meal) => meal.id == mealId)));
      prefsMealId.add(mealId);
    }
    notifyListeners();
    prefs.setStringList('prefsMealId', prefsMealId);
  }

  bool isMealFavorite(String id) {
    return favoritMeals.any((meal) => meal.id == id);
  }
}
