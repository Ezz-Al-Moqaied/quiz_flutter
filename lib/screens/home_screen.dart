import 'package:flutter/material.dart';
import 'package:quiz_flutter/main.dart';
import 'package:quiz_flutter/models/quote.dart';
import 'package:quiz_flutter/models/random_image_model.dart';

import 'package:quiz_flutter/widget/navigate_widget.dart';

class HomeScreen extends StatefulWidget {
  QuoteModel quoteModel;
  RandomImageModel randomImageModel;

  HomeScreen(
      {Key? key, required this.quoteModel, required this.randomImageModel})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String image =
        "https://png.pngtree.com/background/20210715/original/pngtree-simple-gradient-background-white-picture-image_1323750.jpg";

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        image: DecorationImage(
          image: widget.randomImageModel.url != ''
              ? NetworkImage(widget.randomImageModel.url)
              : NetworkImage(image),
          fit: BoxFit.fill,
        ),
      ),
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    navigatePushReplacement(
                        context: context, nextScreen: const MyHomePage());
                  },
                  icon: const Icon(
                    Icons.update,
                    size: 40,
                    color: Colors.tealAccent,
                  )),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black.withOpacity(0.3),
              child: Text(
                widget.quoteModel.content.toString(),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.lightGreen,
              child: Text(
                widget.quoteModel.author.toString(),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
