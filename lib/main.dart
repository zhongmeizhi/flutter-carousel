import 'package:flutter/material.dart';
// 导入widget
import 'carousel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_carousel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  // mock 屏幕宽度
  final double _screenWidth = 414.0;

  // mock数据
  // 需展现的轮播Widget列表
  final List carouselList = <Widget>[
    Container(
      color: Colors.deepOrange,
      child: Center(
        child: Text('111'),
      ),
    ),
    Container(
      color: Colors.amberAccent,
      child: Center(
        child: Text('222'),
      ),
    ),
    Container(
      color: Colors.pink,
      child: Center(
        child: Text('333'),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('flutter_carousel'),
        ),
        body: Stack(
          children: <Widget>[
            // 使用widget
            new Carousel(carouselList: carouselList, tagWidth: _screenWidth)
          ],
        )
    );
  }
}




