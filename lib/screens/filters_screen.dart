import 'package:flutter/material.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/widgets/drawer_item.dart';

import 'package:provider/provider.dart';
import 'package:mealapp/providers/meal_provider.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filtersscreen';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget buildSwitchListTitle(String title, String description,
      bool currentValue, Function changeState) {
    return SwitchListTile(
      inactiveTrackColor:
          Provider.of<ThemeProvider>(context).tm == ThemeMode.light
              ? null
              : Colors.black,
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: changeState,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;

    return Scaffold(
      appBar: AppBar(
        title: Text("Filter your results"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjest your meal selections",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTitle(
                  "Gluten-free",
                  "food without gluten",
                  currentFilters['gluten'],
                  (newValue) {
                    setState(
                      () {
                        currentFilters['gluten'] = newValue;
                      },
                    );
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                buildSwitchListTitle(
                  "Lactose-Free",
                  "food without Lactose",
                  currentFilters['lactose'],
                  (newValue) {
                    setState(
                      () {
                        currentFilters['lactose'] = newValue;
                      },
                    );
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                buildSwitchListTitle(
                  "Vegan",
                  "food with Vegan",
                  currentFilters['vegan'],
                  (newValue) {
                    setState(
                      () {
                        currentFilters['vegan'] = newValue;
                      },
                    );
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                buildSwitchListTitle(
                  "Vegitarian",
                  "Vegitarian Food",
                  currentFilters['vegetarian'],
                  (newValue) {
                    setState(
                      () {
                        currentFilters['vegetarian'] = newValue;
                      },
                    );
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
              ],
            ),
          )
        ],
      ),
      drawer: DrawerItem(),
    );
  }
}
