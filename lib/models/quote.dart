import 'package:quiz_flutter/models/networking.dart';

class QuoteModel {
  String id = '';
  String content = '';
  String author = '';
  List<dynamic> tags = [];
  String authorSlug = '';
  int length = 0;
  String dateAdded = '';
  String dateModified = '';

  Future<void> getQuote() async {
    Map<String, dynamic> quote = await NetworkHelper(url: "https://api.quotable.io/random").getData();
    print(quote['content']);

    id = quote['_id'];
    content = quote['content'];
    author = quote['author'];
    tags = quote['tags'];
    authorSlug = quote['authorSlug'];
    length = quote['length'];
    dateAdded = quote['dateAdded'];
    dateModified = quote['dateModified'];
    print(content);

  }


}
