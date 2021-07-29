import 'package:flutter/material.dart';
import 'package:mealapp/screens/themes_screen.dart';
import '../screens/filters_screen.dart';

class DrawerItem extends StatelessWidget {
  Widget buildListTitle(String Value, IconData icon, Function fun,
      BuildContext ctx) {
    return ListTile(
      onTap: fun,
      leading: Icon(icon, size: 30, color: Theme
          .of(ctx)
          .buttonColor,),
      title: Text(
        Value,
        style: TextStyle(
          color: Theme
              .of(ctx)
              .textTheme
              .bodyText1
              .color,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          Container(
            color: Theme
                .of(context)
                .accentColor,
            height: 150,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(25),
            child: Text(
              "Cooking Up!",
              style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTitle("Meal", Icons.restaurant,
                  () => Navigator.of(context).pushReplacementNamed('/'),
              context),
          buildListTitle(
              "Filter",
              Icons.color_lens,
                  () =>
                  Navigator.of(context)
                      .pushReplacementNamed(FiltersScreen.routeName), context),
          buildListTitle("Themes", Icons.format_paint, () =>
              Navigator.of(context).pushReplacementNamed(ThemesScreen.routeName), context)
        ],
      ),
    );
  }
}
