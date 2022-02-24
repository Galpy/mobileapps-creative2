import 'package:creativework2/model/route.dart';
import 'package:creativework2/model/user_record.dart';
import 'package:creativework2/viewscreen/listview_screen.dart';
import 'package:flutter/material.dart';

class AddRouteScreen extends StatefulWidget {
  const AddRouteScreen({Key? key}) : super(key: key);

  static const routeName = '/addRouteScreen';

  @override
  State<StatefulWidget> createState() {
    return _AddRouteScreen();
  }
}

class _AddRouteScreen extends State<AddRouteScreen> {
  late _Controller con;
  bool editMode = false;
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as AddRouteArguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Route'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Name',
                      ),
                      validator: con.validateName,
                      onSaved: con.saveName,
                      autocorrect: false,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Address',
                      ),
                      validator: con.validateAddress,
                      onSaved: con.saveAddress,
                      autocorrect: false,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => con.addRoute(
                args.allRoutes,
                args.user,
              ),
              child: Text(
                'Confirm Route',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddRouteArguments {
  final List<TravelRoute> allRoutes;
  final UserRecord user;
  AddRouteArguments(this.allRoutes, this.user);
}

class _Controller {
  _AddRouteScreen state;
  _Controller(this.state);
  String? curraddress;
  String? currname;

  void saveAddress(String? value) {
    curraddress = value;
    print(curraddress);
  }

  void saveName(String? value) {
    currname = value;
    print(currname);
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'No name provided';
    } else {
      return null;
    }
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'No address provided';
    } else {
      return null;
    }
  }

  void addRoute(List<TravelRoute> allRoutes, UserRecord user) {
    FormState? currentState = state.formKey.currentState;
    currentState?.save();
    allRoutes.add(TravelRoute(name: currname, address: curraddress));
    Navigator.pushNamed(
      state.context,
      ListViewScreen.routeName,
      arguments: ListViewArguments(allRoutes, user),
    );
  }
}
