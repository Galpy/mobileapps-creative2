// import 'package:creativework2/model/route.dart';
// import 'package:flutter/material.dart';

// class GoogleSignInScreen extends StatefulWidget {
//   const GoogleSignInScreen(this.allRoutes, {Key? key}) : super(key: key);

//   final List<TravelRoute> allRoutes;
//   static const routeName = '/cardListScreen';
//   @override
//   State<StatefulWidget> createState() {
//     return _GoogleSignInState();
//   }
// }

// class _GoogleSignInState extends State<GoogleSignInScreen> {
//   late _Controller con;
//   @override
//   void initState() {
//     super.initState();
//     con = _Controller(this);
//   }

//   void render(fn) => setState(fn);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Card List'),
//       ),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               for (var route in widget.allRoutes) RouteView(route),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _Controller {
//   _GoogleSignInState state;
//   _Controller(this.state);
// }
