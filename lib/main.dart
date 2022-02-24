import 'package:creativework2/model/user_record.dart';
import 'package:creativework2/viewscreen/addroute_screen.dart';
import 'package:creativework2/viewscreen/error_screen.dart';
import 'package:creativework2/viewscreen/listview_screen.dart';
import 'package:creativework2/viewscreen/profile_screen.dart';
import 'package:creativework2/viewscreen/start_screen.dart';
import 'package:creativework2/viewscreen/userhome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CreativeWork2App());
}

class CreativeWork2App extends StatelessWidget {
  const CreativeWork2App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: StartScreen.routeName,
      routes: {
        StartScreen.routeName: (context) => const StartScreen(),
        AddRouteScreen.routeName: (context) => const AddRouteScreen(),
        UserHomeScreen.routeName: (context) {
          Object? args = ModalRoute.of(context)?.settings.arguments;
          if (args != null) {
            return UserHomeScreen(args as UserRecord);
          } else {
            return const ErrorScreen('argument is null at UserScreen');
          }
        },
        // GoogleSignInScreen.routeName: (context) {
        //   Object? args = ModalRoute.of(context)?.settings.arguments;
        //   if (args != null) {
        //     return GoogleSignInScreen(args as List<Course>);
        //   } else {
        //     return const ErrorScreen('argument is null at CardList');
        //   }
        // },
        ListViewScreen.routeName: (context) => const ListViewScreen(),
        ProfileScreen.routeName: (context) {
          Object? args = ModalRoute.of(context)?.settings.arguments;
          if (args != null) {
            return ProfileScreen(args as UserRecord);
          } else {
            return const ErrorScreen('argument is null at ProfileScreen');
          }
        },
      },
    );
  }
}
