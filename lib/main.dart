import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nswipe/homepage.dart';
import 'package:nswipe/swipecard.dart';
import 'package:provider/provider.dart';

import 'cardprovider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Root
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CardProvider(),
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'nSwipe',
        theme: ThemeData(
          primarySwatch: Colors.brown,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage()
    )
    );
  }
}

//Add Item
class AddItemWidget extends StatefulWidget {
  const AddItemWidget({Key? key}) : super(key: key);

  @override
  State<AddItemWidget> createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: style,
            onPressed: () {
              log('Add Item Button pressed, open Form');
            },
            child: const Text('Add Item'),
          ),
        ],
      ),
    );
  }
}
