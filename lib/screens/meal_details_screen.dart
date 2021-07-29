import 'package:flutter/material.dart';
import '../dummy_data.dart';

import 'package:provider/provider.dart';
import 'package:mealapp/providers/meal_provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meal details';

  Widget buildtext(BuildContext context, title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      width: 300,
      height: 200,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mealID = ModalRoute.of(context).settings.arguments as String;
    final selectMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealID);

    Color accentColor = Theme.of(context).accentColor;

    var liSteps = ListView.builder(
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text("${index + 1}"),
            ),
            title: Text(
              selectMeal.steps[index],
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(
            color: Colors.black45,
          ),
        ],
      ),
      itemCount: selectMeal.steps.length,
    );

    var liIngradiant = ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            color: accentColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: Text(
                selectMeal.ingredients[index],
              ),
            ),
          );
        },
        itemCount: selectMeal.ingredients.length);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Hero(
                tag: mealID,
                child: Image.network(
                  selectMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      buildtext(context, "Ingrediants"),
                      buildContainer(liIngradiant),
                    ],
                  ),

                  Column(
                    children: [
                      buildtext(context, "Steps"),
                      buildContainer(liSteps),
                    ],
                  ),

                ],
              ),
            if (!isLandScape) buildtext(context, "Ingrediants"),
            if (!isLandScape) buildContainer(liIngradiant),
            if (!isLandScape) buildtext(context, "Steps"),
            if (!isLandScape) buildContainer(liSteps),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toggleFavorite(mealID),
        child: Icon(
          Provider.of<MealProvider>(context, listen: true)
                  .isMealFavorite(mealID)
              ? Icons.star
              : Icons.star_border,
        ),
      ),
    );
  }
}
