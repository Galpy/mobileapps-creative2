import 'package:creativework2/model/route.dart';
import 'package:creativework2/model/user_record.dart';
import 'package:creativework2/viewscreen/listview_screen.dart';
import 'package:creativework2/viewscreen/profile_screen.dart';
import 'package:creativework2/viewscreen/view/support_view.dart';
import 'package:creativework2/viewscreen/view/view_util.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen(this.user, {Key? key}) : super(key: key);

  static const routeName = '/userHomeScreen';

  final UserRecord user;

  @override
  State<StatefulWidget> createState() {
    return _UserHomeState();
  }
}

class _UserHomeState extends State<UserHomeScreen> {
  late _Controller con;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  void _onItemTapped(int index) {
    render(() {
      _selectedIndex = index;
      UserRecord userInfo = super.widget.user;
      if (_selectedIndex == 0 && index == 0) {
      } else if (_selectedIndex == 0) {
        Navigator.pushNamed(
          context,
          UserHomeScreen.routeName,
          arguments: userInfo,
        );
      } else if (_selectedIndex == 1) {
        Navigator.pushNamed(
          context,
          ProfileScreen.routeName,
          arguments: userInfo,
        );
      } else if (_selectedIndex == 2) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bumpy Roads'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: con.support,
            icon: const Icon(Icons.support_agent),
          ),
          IconButton(
            onPressed: con.signOut,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.amberAccent,
              height: 300.0,
              child: Image.asset('images/GoogleMaps.jpg'),
            ),
            ElevatedButton(
              onPressed: con.createRoute,
              child: const Text(
                'Create a route',
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            label: 'Map',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}

class _Controller {
  final _UserHomeState state;
  _Controller(this.state);

  void signOut() {
    Navigator.of(state.context).pop();
  }

  void profile() async {
    await Navigator.pushNamed(
      state.context,
      ProfileScreen.routeName,
      arguments: state.widget.user,
    );
    state.render(() {});
  }

  void support() {
    showAlertDialog(
      context: state.context,
      title: 'Support',
      widget: const SupportView(),
    );
  }

  void createRoute() {
    Navigator.pushNamed(
      state.context,
      ListViewScreen.routeName,
      arguments: ListViewArguments(
        routeList,
        state.widget.user,
      ),
    );
  }
}
