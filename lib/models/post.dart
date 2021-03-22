import 'package:intl/intl.dart';

class Post {
  DateTime date;
  String imageUrl;
  double latitude;
  double longitude;
  int quantity;
  
  Post(
    {this.date, this.imageUrl, this.latitude, this.longitude, this.quantity}
  );

  formatDate() {
    return DateFormat('EEEE, MMMM d, yyy')
      .format(DateTime.parse(date.toString()));
  }
}
