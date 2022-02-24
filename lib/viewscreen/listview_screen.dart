import 'package:creativework2/model/route.dart';
import 'package:creativework2/model/user_record.dart';
import 'package:creativework2/viewscreen/addroute_screen.dart';
import 'package:creativework2/viewscreen/userhome_screen.dart';
import 'package:flutter/material.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({Key? key}) : super(key: key);

  static const routeName = '/listViewScreen';
  @override
  State<StatefulWidget> createState() {
    return _ListViewState();
  }
}

class _ListViewState extends State<ListViewScreen> {
  late _Controller con;
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ListViewArguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => con.home(args.user),
        ),
        title: const Text('Current Saved Routes'),
        actions: con.selected.isEmpty
            ? null
            : [
                IconButton(
                  onPressed: () => con.delete(args.allRoutes),
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: con.cancel,
                  icon: const Icon(Icons.cancel),
                ),
              ],
      ),
      body: ListView.builder(
        itemCount: args.allRoutes.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: con.selected.contains(index)
                ? con.selectedColor
                : con.unselectedColor,
            margin: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(args.allRoutes[index].name!),
              subtitle: Text(args.allRoutes[index].address!),
              onTap: () => con.onTap(index, args.user),
              onLongPress: () => con.onLongPress(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => con.add(args.allRoutes, args.user),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListViewArguments {
  final List<TravelRoute> allRoutes;
  final UserRecord user;
  ListViewArguments(this.allRoutes, this.user);
}

class _Controller {
  _ListViewState state;
  _Controller(this.state);

  List<int> selected = [];
  final selectedColor = Colors.lime[800];
  final unselectedColor = Colors.lime[200];

  void onLongPress(int index) {
    state.render(() {
      if (selected.contains(index)) {
        selected.remove(index);
      } else {
        selected.add(index);
      }
    });
  }

  void onTap(int index, UserRecord user) {
    if (selected.isEmpty) {
      Navigator.pushNamed(
        state.context,
        UserHomeScreen.routeName,
        arguments: user,
      );
    } else {
      onLongPress(index);
    }
  }

  void home(UserRecord user) {
    Navigator.pushNamed(
      state.context,
      UserHomeScreen.routeName,
      arguments: user,
    );
  }

  void add(List<TravelRoute> allRoutes, UserRecord user) {
    Navigator.pushNamed(
      state.context,
      AddRouteScreen.routeName,
      arguments: AddRouteArguments(allRoutes, user),
    );
  }

  void delete(List<TravelRoute> allRoutes) {
    selected.sort();
    for (int i = selected.length - 1; i >= 0; i--) {
      allRoutes.removeAt(selected[i]);
    }
    state.render(() {
      selected.clear();
    });
  }

  void cancel() {
    state.render(() => selected.clear());
  }
}
