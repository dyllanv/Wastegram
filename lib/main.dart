import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/display_post.dart';
import './screens/home.dart';
import './screens/new_post.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(App(title: "Wastegram"));
}

class App extends StatelessWidget {
  App({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final routes = {
      HomePage.routeName: (context) =>
        HomePage(title: title),
      DisplayPost.routeName: (context) =>
        DisplayPost(title: title),
      NewPost.routeName: (context) =>
        NewPost(title: title)
    };
    return MaterialApp(
      title: title,
      theme: ThemeData.dark(),
      routes: routes
    );
  }
}
