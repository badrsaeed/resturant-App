import 'package:flutter/material.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/meal_item.dart';
import '../modules/meal.dart';

class FavoriteScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    var isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    final List<Meal> favoritMeals = Provider.of<MealProvider>(context).favoritMeals;

    if(favoritMeals.isEmpty){
      return Center(
        child: Text("You have not any favorite meals yet!, you can add"),
      );
    }
    else{
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw > 400? 500 : 400,
          childAspectRatio: isLandScape ? dw/(dw * 0.78) : dw/(dw * 0.73),
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (ctx , index){
          return MealItem(
            id: favoritMeals[index].id,
            imageUrl: favoritMeals[index].imageUrl,
            title: favoritMeals[index].title,
            duration: favoritMeals[index].duration,
            complexity: favoritMeals[index].complexity,
            affordability: favoritMeals[index].affordability,
          );
        },
        itemCount: favoritMeals.length,
      );
    }

  }
}
