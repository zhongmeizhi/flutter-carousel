import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('flutter_carousel'),
        ),
        body: Stack(
          children: <Widget>[
            Carousel()
          ],
        )
    );
  }
}

class Carousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Carousel();
}

class _Carousel extends State<Carousel> with SingleTickerProviderStateMixin{

  // 需展现的轮播Widget列表
  List _carouselList = <Widget>[
    Container(
      width: 414,
      color: Colors.deepOrange,
      child: Center(
        child: Text('111'),
      ),
    ),
    Container(
      width: 414,
      color: Colors.amberAccent,
      child: Center(
        child: Text('222'),
      ),
    ),
    Container(
      width: 414,
      color: Colors.pink,
      child: Center(
        child: Text('333'),
      ),
    )
  ];

  // 实际轮播widget列表，因为要无线轮播
  List _wrapList = <Widget>[];

  // 页面控制器和下标控制器
  TabController  _tabController;
  PageController _pageController = PageController(initialPage: 1);

  @override
  void initState() {
    // 初始化时把最后一张轮播widget，复制一份放最前面
    _wrapList.insert(0, _carouselList[_carouselList.length - 1]);
    _wrapList.addAll(_carouselList);
    // 把第一张轮播widget，复制一份放最后面
    _wrapList.add(_carouselList[0]);
    // 实际下标 等于_carouselList的数量
    _tabController = TabController(vsync: this, length: _carouselList.length);
    super.initState();
  }

  @override
  void dispose() {
    // 离开需销毁
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged (idx) {
    // 轮播实现
    if (idx == 0) {
      _pageController.jumpToPage(_wrapList.length - 2);
      _pageController.animateToPage(
        _wrapList.length - 2,
        duration: Duration(microseconds: 666),
        curve: Curves.fastOutSlowIn
      );
    } else if (idx == (_wrapList.length - 1)) {
      _tabController.animateTo(0);
      _pageController.jumpToPage(1);
    } else {
      _tabController.animateTo(idx - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 150,
          child: PageView(
            onPageChanged: _onPageChanged,
            children: _wrapList,
            controller: _pageController
          ),
        ),
        Positioned(
          bottom:  20,
          child: Container(
            width: 414,
            child: Align(
              alignment: Alignment(0.0, 0.5),
              child: TabPageSelector(
                color: Colors.white,
                selectedColor: Colors.black,
                controller: _tabController,
              ),
            ),
          )
        )
      ],
    );
  }

}



