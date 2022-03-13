import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nswipe/swipecard.dart';
import 'package:provider/provider.dart';

import 'cardprovider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final images = provider.images;

    return images.isEmpty
        ? Center(
            child: ElevatedButton(
              child: Text('Restart'),
              onPressed: () {
                final provider =
                    Provider.of<CardProvider>(context, listen: false);

                provider.resetUsers();
              },
            ),
          )
        : Stack(
            children: images
                .map((image) =>
                    SwipeCard(urlImage: image, isFront: images.last == image))
                .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome to nSwipe"),
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: buildCards(),
          ),
        ));
  }
}
