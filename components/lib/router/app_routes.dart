import 'package:components/models/models.dart';
import 'package:flutter/material.dart';

import '../views/views.dart';

class AppRoutes {
  static const initialRoute = 'homeView';

  static final menuOptions = <MenuOptionModel>[
    MenuOptionModel(
      route: 'homeView',
      name: 'Home',
      view: const HomeView(),
      icon: Icons.home,
    ),
    MenuOptionModel(
      route: 'alertView',
      name: 'Alerts',
      view: const AlertView(),
      icon: Icons.notifications,
    ),
    MenuOptionModel(
      route: 'cardView',
      name: 'Cards',
      view: const CardView(),
      icon: Icons.credit_card,
    ),
    MenuOptionModel(
      route: 'listViewFirstView',
      name: 'First List View',
      view: const ListViewFirstView(),
      icon: Icons.list,
    ),
    MenuOptionModel(
      route: 'listViewSecondView',
      name: 'Second List View',
      view: const ListViewSecondView(),
      icon: Icons.list_alt,
    ),
    MenuOptionModel(
      route: 'avatarView',
      name: 'Avatar',
      view: const AvatarView(),
      icon: Icons.supervised_user_circle_outlined,
    ),
    MenuOptionModel(
      route: 'inputsView',
      name: 'Inputs',
      view: const InputsView(),
      icon: Icons.input_rounded,
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> response = {};
    for (var option in menuOptions) {
      response.addAll({option.route: (BuildContext context) => option.view});
    }

    return response;
  }

  static Route<dynamic> onGeneralRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertView(),
    );
  }
}
