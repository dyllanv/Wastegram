import 'package:flutter/material.dart';
import '../models/post.dart';
import '../styles.dart';

class DisplayPost extends StatelessWidget {
  static final routeName = "displayPost";
  DisplayPost({Key key, this.title}) : super(key: key);
  final String title;

  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(title))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(Styles.padding(context, 0, 0.02))),
          Text(post.formatDate(), style: TextStyle(fontSize: 24)),
          Padding(padding: EdgeInsets.all(Styles.padding(context, 0, 0.02))),
          Center(
            child: Container(
              height: Styles.adjustHeight(context, 0.5),
              child: Image.network(post.imageUrl),
            )
          ), 
          Padding(padding: EdgeInsets.all(Styles.padding(context, 0, 0.02))),
          Text('Items: ${post.quantity}', style: TextStyle(fontSize: 24)),
          Padding(padding: EdgeInsets.all(Styles.padding(context, 0, 0.02))),
          Text('Location: (${post.latitude}, ${post.longitude})', 
            style: TextStyle(fontSize: 14)
          )
        ],
      )
      
    );
  }
}
