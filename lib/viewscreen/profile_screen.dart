import 'package:creativework2/model/user_record.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen(this.user, {Key? key}) : super(key: key);

  final UserRecord user;

  static const routeName = '/profileScreen';
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<ProfileScreen> {
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
        title: const Text('Profile'),
        actions: [
          editMode
              ? IconButton(onPressed: con.save, icon: const Icon(Icons.check))
              : IconButton(onPressed: con.edit, icon: const Icon(Icons.edit)),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Name',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        enabled: editMode,
                        initialValue: con.tempUser.name,
                        validator: con.validateName,
                        onSaved: con.saveName,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Phone',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        enabled: editMode,
                        initialValue: con.tempUser.phone,
                        validator: con.validatePhone,
                        onSaved: con.savePhone,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Age',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        enabled: editMode,
                        initialValue: '${con.tempUser.age}',
                        validator: con.validateAge,
                        onSaved: con.saveAge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _ProfileState state;
  late UserRecord tempUser;
  _Controller(this.state) {
    tempUser = state.widget.user.clone();
  }

  void save() {
    FormState? currentState = state.formKey.currentState;
    if (currentState == null) return;
    if (!currentState.validate()) return;
    currentState.save();

    state.widget.user.copyFrom(tempUser);

    state.render(() => state.editMode = false);
  }

  void edit() {
    state.render(() => state.editMode = true);
  }

  String? validateName(String? value) {
    if (value == null || value.length < 2) {
      return 'Invalid name';
    } else {
      return null;
    }
  }

  void saveName(String? value) {
    if (value != null) tempUser.name = value;
  }

  String? validatePhone(String? value) {
    if (value == null || value.length < 10) {
      return 'Invalid phone, 10 digits';
    } else {
      return null;
    }
  }

  void savePhone(String? value) {
    if (value != null) tempUser.phone = value;
  }

  String? validateAge(String? value) {
    if (value == null) {
      return 'Invalid age';
    }
    try {
      int age = int.parse(value);
      if (age >= 12) {
        return null;
      } else {
        return 'Min age is 12';
      }
    } catch (e) {
      return 'Age must be an integer';
    }
  }

  void saveAge(String? value) {
    if (value != null) tempUser.age = int.parse(value);
  }
}
