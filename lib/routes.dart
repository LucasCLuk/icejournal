import 'package:flutter/material.dart';
import 'package:icejournal/blocs/journels_bloc.dart';
import 'package:icejournal/screens/journel_list_screen.dart';

MaterialPageRoute defaultRoute(RouteSettings settings, Widget builder) =>
    MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => builder);

Route generateRoutes(RouteSettings settings, JournalBloc bloc) {
  switch (settings.name) {
    case "/":
      return defaultRoute(
          settings,
          JournalListView(
            bloc: bloc,
          ));

    default:
      return defaultRoute(
          settings,
          JournalListView(
            bloc: bloc,
          ));
  }
}
