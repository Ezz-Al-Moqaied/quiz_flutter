import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:quiz_flutter/models/quote.dart';
import 'package:quiz_flutter/models/random_image_model.dart';
import 'package:quiz_flutter/screens/home_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:async';
import 'dart:ui' as ui;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  GlobalKey globalKey = GlobalKey();
  Uint8List? pngBytes;
  QuoteModel quoteModel = QuoteModel() ;
  RandomImageModel randomImageModel = RandomImageModel();

  void getQuoteModel() async {
    await quoteModel.getQuote();
    getRandomImageModel(quoteModel.tags[0]);
  }

  void getRandomImageModel(String category) async {
    await randomImageModel.getRandomImage(category);
    setState(() {});
  }

  @override
  void initState() {
    getQuoteModel();
    super.initState();
  }

  Future<void> _capturePng() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    //if (boundary.debugNeedsPaint) {
      if (kDebugMode) {
        print("Waiting for boundary to be painted.");
      }
      await Future.delayed(const Duration(milliseconds: 20));
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      pngBytes = byteData!.buffer.asUint8List();
      if (kDebugMode) {
        print(pngBytes);
      }
      if (mounted) {
        _onShareXFileFromAssets(context, byteData);
      }
   // }
  }

  void _onShareXFileFromAssets(BuildContext context, ByteData? data) async {
    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
   // final data = await rootBundle.load('assets/flutter_logo.png');
    final buffer = data!.buffer;
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: 'screen_shot.png',
          mimeType: 'image/png',
        ),
      ],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Share result: ${result.status}"),
          if (result.status == ShareResultStatus.success)
            Text("Shared to: ${result.raw}")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _capturePng,
        label: const Text('Take screenshot'),
        icon: const Icon(Icons.share_rounded),
      ),
      body: RepaintBoundary(
        key: globalKey,
        child: HomeScreen(
            quoteModel: quoteModel, randomImageModel: randomImageModel),
      ),
    );
  }
}
