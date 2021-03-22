import 'package:intl/intl.dart';
import 'package:test/test.dart';
import 'package:wasteagram/models/post.dart';

void main() {
  test('Post created should have appropriate init property values', () {
    final date = DateTime.parse('2020-01-01');
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;
    final post = Post(
      date: date, 
      imageUrl: url, 
      latitude: latitude, 
      longitude: longitude, 
      quantity: quantity
    );
    expect(post.date, date);
    expect(post.imageUrl, url);
    expect(post.latitude, latitude);
    expect(post.longitude, longitude);
    expect(post.quantity, quantity);
  });

  test('Post formatDate() function should return appropriate value', () {
    final date = DateTime.now();
    String dateString = DateFormat('EEEE, MMMM d, yyy')
      .format(DateTime.parse(date.toString()));
    const url = 'FAKE';
    const quantity = 0;
    const latitude = 1.0;
    const longitude = 2.0;
    final post = Post(
      date:  date,
      imageUrl: url, 
      latitude: latitude, 
      longitude: longitude, 
      quantity: quantity
    );
    expect(post.formatDate(), dateString);
    expect(post.imageUrl, url);
    expect(post.latitude, latitude);
    expect(post.longitude, longitude);
    expect(post.quantity, quantity);
  });

  test('Post variables are mutable and can be assigned after initialization', () {
    final date = DateTime.parse('2020-01-01');
    const url = 'FAKE';
    const quantity = 0;
    const latitude = 1.0;
    const longitude = 2.0;
    final post = Post(
      date:  date,
      imageUrl: url,
      quantity: quantity
    );
    post.imageUrl = url;
    post.latitude = latitude;
    post.longitude = longitude;
    post.quantity += 5;
    expect(post.date, date);
    expect(post.imageUrl, url);
    expect(post.latitude, latitude);
    expect(post.longitude, longitude);
    expect(post.quantity, quantity + 5);
  });
}