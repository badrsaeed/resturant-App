
import 'package:flutter/material.dart';
import 'package:mealapp/modules/meal.dart';
import '../widgets/meal_item.dart';

import 'package:provider/provider.dart';
import 'package:mealapp/providers/meal_provider.dart';


class CategoryMeals extends StatefulWidget {

  static const route = 'categories meal';




  @override
  _CategoryMealsState createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {

  String catTitle;
  List<Meal> catMaeals;

  void _removemeal(String mealId){
    setState(() {
      catMaeals.removeWhere((meal) => meal.id == mealId);
    });

  }
  @override
  void didChangeDependencies() {
    final List<Meal> _availableMeal = Provider.of<MealProvider>(context).availableMeal;
    final arg = ModalRoute.of(context).settings.arguments as Map<String,Object>;
    final catID = arg['id'];
    catTitle = arg['title'];
    catMaeals = _availableMeal.where((meal) {
      return meal.categories.contains(catID);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(catTitle),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw > 400? 500 : 400,
          childAspectRatio: isLandScape ? dw/(dw * 0.78) : dw/(dw * 0.73),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (ctx , index){
          return MealItem(
            id: catMaeals[index].id,
            imageUrl: catMaeals[index].imageUrl,
            title: catMaeals[index].title,
            duration: catMaeals[index].duration,
            complexity: catMaeals[index].complexity,
            affordability: catMaeals[index].affordability,
          );
        },
        itemCount: catMaeals.length,
      )
    );
  }
}
