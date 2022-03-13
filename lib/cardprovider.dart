import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum CardStatus { CART, DISLIKE }

class CardProvider extends ChangeNotifier {
  List<String> _images = [];
  Offset _position = Offset.zero;
  bool _isDragging = false;
  double _angle = 0;
  Size _screenSize = Size.zero;

  List<String> get images => _images;

  Offset get position => _position;

  bool get isDragging => _isDragging;

  double get angle => _angle;

  void setScreenSize(Size screenSize) {
    _screenSize = screenSize;
  }

  CardProvider() {
    resetUsers();
  }

  void resetUsers() {
    _images = <String>[
      'https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2F21%2F1a%2F211a857044072e049b3a45c5a68611e2b3014f70.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5Bmen_tshirtstanks_shortsleeve%5D%2Ctype%5BDESCRIPTIVESTILLLIFE%5D%2Cres%5Bm%5D%2Chmver%5B2%5D&call=url[file:/product/main]',
      'https://www.tezenis.com/dw/image/v2/BCXQ_PRD/on/demandware.static/-/Sites-TEZ_EC_COM/default/dw52cd15a2/images/2MM15C9120-F.jpg?sw=600&sfrm=jpeg',
      'https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2F49%2F56%2F49560dfa45732ed844e8e4742afdca248ee60f9f.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5Bmen_tshirtstanks_shortsleeve%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url[file:/product/main]',
      'https://img01.ztat.net/article/spp-media-p1/b1e4d95cd1494cdab1a97335c7f0040b/a8868f3af7eb44329a689c5cde5f988d.jpg?imwidth=762',
    ].reversed.toList();

    notifyListeners();
  }

  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();

    final status = getStatus();

    if (status != null) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg: status.toString().split('.').last, fontSize: 28);
    }

    switch (status) {
      case CardStatus.CART:
        addToCart();
        break;
      case CardStatus.DISLIKE:
        dislike();
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;

    notifyListeners();
  }

  CardStatus? getStatus() {
    final x = _position.dx;

    final delta = 100;

    if (x >= delta) {
      return CardStatus.CART;
    } else if (x <= -delta) {
      return CardStatus.DISLIKE;
    }
  }

  void addToCart() {
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);
    nextItem();

    notifyListeners();
  }

  void dislike() {
    _angle = -20;
    _position += Offset(2 * _screenSize.width, 0);
    nextItem();

    notifyListeners();
  }

  Future nextItem() async {
    if (images.isEmpty) return;

    await Future.delayed(const Duration(milliseconds: 200));
    _images.removeLast();
    resetPosition();
  }
}
