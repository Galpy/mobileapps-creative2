import 'package:creativework2/model/user_record.dart';
import 'package:creativework2/viewscreen/userhome_screen.dart';
import 'package:creativework2/viewscreen/view/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  static const routeName = '/startScreen';

  @override
  State<StatefulWidget> createState() {
    return _StartState();
  }
}

class _StartState extends State<StartScreen> {
  late _Controller con;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
    print('************* StartScreen: initState() ');
  }

  @override
  Widget build(BuildContext context) {
    print('************* StartScreen: build() ');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Start Screen'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Sign In, Please!',
                style: Theme.of(context).textTheme.headline4,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Enter email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: con.validateEmail,
                      onSaved: con.saveEmail,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'Enter password',
                      ),
                      obscureText: true,
                      autocorrect: false,
                      validator: con.validatePassword,
                      onSaved: con.savePassword,
                    ),
                    ElevatedButton(
                      onPressed: con.signin,
                      child: Text(
                        'Sign In',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              // ElevatedButton(
              //   onPressed: con.facebookDemo,
              //   child: const Icon(Icons.facebook),
              // ),
              // ElevatedButton(
              //   onPressed: con.googleSignInDemo,
              //   child: const Icon(Icons.email),
              // ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    print('************* StartScreen: dispose() ');
    super.dispose();
  }
}

class _Controller {
  late _StartState state;
  _Controller(this.state);
  String? email;
  String? password;

  void signin() {
    FormState? currentState = state.formKey.currentState;
    if (currentState == null) return;
    if (!(currentState.validate())) return;
    currentState.save();

    UserRecord userInfo = fakeDB.firstWhere(
      (e) => e.email == email && e.password == password,
      orElse: () => UserRecord(),
    );

    if (userInfo.email == '') {
      showSnackBar(
        context: state.context,
        message: 'Authentication failed. Incorrect email/password',
        seconds: 20,
      );
    } else {
      Navigator.pushNamed(
        state.context,
        UserHomeScreen.routeName,
        arguments: userInfo,
      );
    }
  }

  void saveEmail(String? value) {
    email = value;
  }

  void savePassword(String? value) {
    password = value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'No email provided';
    } else if (!(value.contains('@') && value.contains('.'))) {
      return 'Not valid email address';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'No password provided';
    } else if (value.length < 6) {
      return 'Password too short';
    } else {
      return null;
    }
  }

  // void facebookDemo() {
  //   Navigator.pushNamed(
  //     state.context,
  //     FacebookDemoScreen.routeName,
  //   );
  // }

  // void googleSignInDemo() {
  //   Navigator.pushNamed(
  //     state.context,
  //     GoogleSignInScreen.routeName,
  //     arguments: courseList,
  //   );
  // }
}
