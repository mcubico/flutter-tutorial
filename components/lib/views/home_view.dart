import 'package:flutter/material.dart';

import 'package:components/themes/app_theme.dart';
import 'package:components/router/app_routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuOptions = AppRoutes.menuOptions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: menuOptions.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(menuOptions[index].name),
          leading: Icon(menuOptions[index].icon, color: AppTheme.primary),
          onTap: () {
            Navigator.pushNamed(context, menuOptions[index].route);
          },
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
