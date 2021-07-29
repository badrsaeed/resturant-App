
import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItems extends StatelessWidget {

  final String id;
  final String title;
  final Color color;

  void selectCategory(BuildContext ctx){
    Navigator.of(ctx).pushNamed(
      CategoryMeals.route,
      arguments: {
        'id' : id,
        "title" : title,
      }
    );
  }

  const CategoryItems(this.id, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).primaryColor,
      onTap: () => selectCategory(context),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(title, style: Theme.of(context).textTheme.headline6,),
        decoration: BoxDecoration(
          gradient: LinearGradient(

                colors:[
                  color.withOpacity(.5),
                  color,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadiusDirectional.circular(15),

        ),
      ),
    );
  }
}
