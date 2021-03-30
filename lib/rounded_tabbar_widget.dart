library rounded_tabbar_widget;

import 'package:flutter/material.dart';
import 'package:rounded_tabbar_widget/common_widgets/tabbar_widget.dart';

class RoundedTabbarWidget extends StatefulWidget {
  final List<Widget> pages;
  final List<IconData> tabIcons;
  final Color itemNormalColor;
  final Color itemSelectedColor;
  final Color tabBarBackgroundColor;
  final int selectedIndex;
  final Function onTabItemIndexChanged;

  RoundedTabbarWidget({
    @required this.pages,
    @required this.tabIcons,
    this.onTabItemIndexChanged,
    this.tabBarBackgroundColor = Colors.black87,
    this.itemSelectedColor = Colors.yellow,
    this.itemNormalColor = Colors.yellow,
    this.selectedIndex = 0,
  });

  @override
  _RoundedTabbarWidgetState createState() => _RoundedTabbarWidgetState();
}

class _RoundedTabbarWidgetState extends State<RoundedTabbarWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Widget> _pages;
  List<IconData> _tabIcons;

  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    //Check for pages length.
    _pages = widget.pages;
    _tabIcons = widget.tabIcons;
    _selectedIndex = widget.selectedIndex;
    assert(
        _pages.length > 0 &&
            _pages.length < 6 &&
            _tabIcons.length == _pages.length,
        'Please set valid number of pages for tabs. You assign maximum. of 5 pages and minimum of 1 page to Rounded Tabbar.');
    _setupTabbarController();
  }

  void _setupTabbarController() {
    _tabController = new TabController(length: _pages.length, vsync: this);
    _tabController.index = _selectedIndex;
    _tabController.animation.addListener(() => _animateTabbarOnScroll());
  }

  void _animateTabbarOnScroll() {
    //Since Animation Value switches between 0 and 1, We extract the mid value, where we can begin animation.
    final double _animationValue =
        (_tabController.animation.value * 10.0) - 10.0;
    final _modValue = ((_tabController.animation.value / 10) * 10).toInt();
    int _value = (_animationValue % 10).toInt().abs();

    if (_value == 5) {
      if (_modValue >= _tabController.index) {
        setState(() {
          _selectedIndex = _modValue + 1;
        });
      } else {
        setState(() {
          _selectedIndex = _modValue;
        });
      }
    }
    if (_tabController.indexIsChanging &&
        _tabController.previousIndex != _tabController.index) {
      widget.onTabItemIndexChanged(_tabController.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            TabBarView(
              controller: _tabController,
              children: _pages,
            ),
            Positioned(
              child: TabbarWidget(
                tabIcons: _tabIcons,
                selectedIndex: _selectedIndex,
                itemNormalColor: widget.itemNormalColor,
                itemSelectedColor: widget.itemSelectedColor,
                tabBarBackgroundColor: widget.tabBarBackgroundColor,
                tabBarSelected: (int index) {
                  setState(() {
                    _tabController.index = index;
                    _selectedIndex = index;
                  });
                },
              ),
              bottom: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
