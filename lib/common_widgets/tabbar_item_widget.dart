import 'package:flutter/material.dart';

class TabbarItemWidget extends StatefulWidget {
  late final bool isSelected;
  late final IconData icon;
  final Function? onItemPressed;
  late final Color itemNormalColor;
  late final Color itemSelectedColor;
  late final Color itemBackgroundColor;
  TabbarItemWidget({
    required this.isSelected,
    required this.icon,
    this.onItemPressed,
    required this.itemBackgroundColor,
    required this.itemSelectedColor,
    required this.itemNormalColor,
  });
  @override
  _TabbarItemWidgetState createState() => _TabbarItemWidgetState();
}

class _TabbarItemWidgetState extends State<TabbarItemWidget> {
  @override
  Widget build(BuildContext context) {
    final _backgroundColor = widget.itemSelectedColor;
    final _iconColor = (widget.isSelected == false)
        ? widget.itemNormalColor
        : widget.itemBackgroundColor;
    final _backgroundSize = (widget.isSelected == false) ? 0.0 : 50.0;
    return Container(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(
              milliseconds: 200,
            ),
            width: _backgroundSize,
            height: 50.0,
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Container(
            child: IconButton(
                icon: Icon(
                  widget.icon,
                  color: _iconColor,
                ),
                onPressed: () {
                  if (widget.onItemPressed != null) {
                    widget.onItemPressed!();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
