
import 'package:flutter/material.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/widgets/drawer_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ThemesScreen extends StatelessWidget {
  static const routeName = '/themesscreen';

  Widget buildRadioListTile(
      ThemeMode themeVal, String txt, IconData icon, BuildContext ctx) {
    return RadioListTile(
      secondary: Icon(
        icon,
        color: Theme.of(ctx).buttonColor,
      ),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(ctx, listen: true).tm,
      onChanged: (newThemeValue) => Provider.of<ThemeProvider>(ctx, listen: false)
          .themeModeChange(newThemeValue),
      title: Text(txt, style:Theme.of(ctx).textTheme.headline6, ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Themes"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Adjust your themes selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Choose your Theme Mode",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                buildRadioListTile(
                  ThemeMode.system,
                  "System Default Theme",
                  null,
                  context,
                ),
                buildRadioListTile(
                  ThemeMode.light,
                  "Light Theme",
                  Icons.wb_sunny_outlined,
                  context,
                ),
                buildRadioListTile(
                  ThemeMode.dark,
                  "Dark Theme",
                  Icons.nights_stay_outlined,
                  context,
                ),
                buildListTile(context, 'primary'),
                buildListTile(context, 'accent'),
              ],
            ),
          ),
        ],
      ),
      drawer: DrawerItem(),
    );
  }

  Widget buildListTile(BuildContext ctx, String txt) {
    var primaryColor = Provider.of<ThemeProvider>(ctx).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(ctx).accentColor;
    return ListTile(
      title: Text("Choose Your $txt color"),
      trailing: CircleAvatar(
        backgroundColor: txt == 'primary' ? primaryColor : accentColor,
      ),
      onTap: () => showDialog(
          context: ctx,
          builder: (innerCtx) => AlertDialog(
                elevation: 4,
                titlePadding: EdgeInsets.all(0.0),
                contentPadding: EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: txt == 'primary'
                        ? Provider.of<ThemeProvider>(innerCtx, listen: true)
                            .primaryColor
                        : Provider.of<ThemeProvider>(innerCtx, listen: true)
                            .accentColor,
                    onColorChanged: (newVal) =>
                        Provider.of<ThemeProvider>(innerCtx, listen: false)
                            .onChange(newVal, txt == 'primary' ? 1 : 2),
                    colorPickerWidth: 300.0,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: false,
                    showLabel: false,
                    displayThumbColor: true,
                  ),
                ),
              )),
    );
  }
}
