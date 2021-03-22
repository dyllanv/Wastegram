import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/list_posts.dart';
import '../models/total_items.dart';
import '../screens/display_post.dart';
import '../models/post.dart';
import './new_post.dart';

class HomePage extends StatefulWidget {
  static final routeName = "/";
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TotalItems count = TotalItems(totalItems: 0);
  bool firstBuild = false;
    
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
      builder: (content, snapshot) {
        if (!snapshot.hasData || snapshot.data.documents.length == 0) {
          return Scaffold(
            appBar: AppBar(title: Center(child: Text('${widget.title}: ${count.totalItems} items wasted'))),
            body: Center(child: CircularProgressIndicator()),
            floatingActionButton: Semantics(
              child: photoButton(),
              button: true,
              enabled: true,
              onTapHint: 'Select an image',
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
          );
        } else {
          // Build widget with most recent total item count
          Widget list = Scaffold(
            appBar: AppBar(title: Center(child: Text('${widget.title}: ${count.totalItems} items wasted'))),
            body: ListPosts(snapshot: snapshot, count: count),
            floatingActionButton: Semantics(
              child: photoButton(),
              button: true,
              enabled: true,
              onTapHint: 'Select an image',
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
          );
          // Zero out total item count for next build (to avoid re-adding items)
          count.totalItems = 0;
          return list;
        }
      }
    );
  } 

  Widget photoButton() {
    return FloatingActionButton(
      child: Icon(Icons.camera_alt),
      onPressed: () {
        displayNewPost(context);
      }
    );
  }

  

  void displayPost(BuildContext context, Post item) {
    Navigator.of(context).pushNamed(DisplayPost.routeName, arguments: item);
  }

  void displayNewPost(BuildContext context) {
    Navigator.of(context).pushNamed(NewPost.routeName).then((value) {
      // setState after initial build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    });
  }
}
