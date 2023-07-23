
import 'package:quiz_flutter/models/networking.dart';

class RandomImageModel {
  late String url = '';

  Future<void> getRandomImage(String category) async {
    Map<String, dynamic> image = await NetworkHelper(
            url:
                "https://random.imagecdn.app/v1/image?category=$category&format=json")
        .getData();
    url = image['url'];
  }
}
