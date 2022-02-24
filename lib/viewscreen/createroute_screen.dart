import 'package:flutter/material.dart';

class CreateRouteScreen extends StatefulWidget {
  const CreateRouteScreen({Key? key}) : super(key: key);

  static const routeName = '/createRouteScreen';

  @override
  State<StatefulWidget> createState() {
    return _CreateRouteState();
  }
}

class _CreateRouteState extends State<CreateRouteScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Route'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: con.createRoute1,
                child: Text(
                  'Pizza Hut',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Text(
                '123 N Test Ave, 73849, OKC, OK',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const Divider(
                height: 100.0,
                color: Colors.yellow,
              ),
              ElevatedButton(
                onPressed: con.createRoute2,
                child: Text(
                  'Papa Johns',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Text(
                '345 N Wester Ave, 73849, OKC, OK',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const Divider(
                height: 100.0,
                color: Colors.yellow,
              ),
              ElevatedButton(
                onPressed: con.createRoute3,
                child: Text(
                  'Little Caesars',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Text(
                '246 S 215th Street, 73849, OKC, OK',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _CreateRouteState state;
  _Controller(this.state) {}

  void createRoute1() {}
  void createRoute2() {}
  void createRoute3() {}
}
