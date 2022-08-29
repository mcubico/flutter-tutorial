import 'package:flutter/material.dart' show IconData, Widget;

class MenuOptionModel {
  final IconData icon;
  final String name;
  final String route;
  final Widget view;

  MenuOptionModel(
      {required this.icon,
      required this.name,
      required this.route,
      required this.view});
}
