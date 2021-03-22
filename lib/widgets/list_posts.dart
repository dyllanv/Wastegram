import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/total_items.dart';
import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/screens/display_post.dart';


class ListPosts extends StatefulWidget {
  ListPosts({Key key, this.snapshot, this.count}) : super(key: key);
  final AsyncSnapshot snapshot;
  final TotalItems count;

  @override
  ListPostsState createState() => ListPostsState();
}

class ListPostsState extends State<ListPosts> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.snapshot.data.documents.length,
      itemBuilder: (context, index) {
        Post post = Post(
          date: widget.snapshot.data.documents[index]["date"].toDate(),
          imageUrl: widget.snapshot.data.documents[index]["imageURL"],
          latitude: widget.snapshot.data.documents[index]["latitude"],
          longitude: widget.snapshot.data.documents[index]["longitude"],
          quantity: widget.snapshot.data.documents[index]["quantity"]
        );
        widget.count.totalItems += post.quantity;
        return Semantics(
          child: ListTile(
            title: Text(
              '${DateFormat('EEEE, MMMM d, yyy').format(DateTime.parse(post.date.toString()))}',
              style: TextStyle(fontSize: 18)
            ),
            trailing: Text('${post.quantity}',
              style: TextStyle(fontSize: 18)),
            onTap: () {
              displayPost(context, post);
            },
          ),
          namesRoute: true,
          enabled: true,
          onTapHint: 'Display post'
        );
      }
    );
  }

  void displayPost(BuildContext context, Post item) {
    Navigator.of(context).pushNamed(DisplayPost.routeName, arguments: item);
  }
}



