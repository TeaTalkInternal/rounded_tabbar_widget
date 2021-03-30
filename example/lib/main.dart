import 'package:example/pages/favorite_page_widget.dart';
import 'package:example/pages/home_page_widget.dart';
import 'package:example/pages/messages_page_widget.dart';
import 'package:example/pages/profile_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:rounded_tabbar_widget/rounded_tabbar_widget.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RoundedTabbarWidget(
      itemNormalColor: Colors.lightBlue[300],
      itemSelectedColor: Colors.lightBlue[900],
      tabBarBackgroundColor: Colors.lightBlue[100],
      tabIcons: [
        Icons.home,
        Icons.favorite,
        Icons.chat,
        Icons.person,
      ],
      pages: [
        HomePageWidget(),
        FavoritePageWidget(),
        MessagesPageWidget(),
        ProfilePageWidget(),
      ],
      selectedIndex: 0,
      onTabItemIndexChanged: (int index) {
        print('Index: $index');
      },
    ),
  ));
}
