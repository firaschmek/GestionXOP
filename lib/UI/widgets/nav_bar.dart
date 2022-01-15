import 'package:appgestion/constant/constants.dart';
import 'package:appgestion/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';

import 'nav_bar_item.dart';

class NavBar extends StatelessWidget {
  final List _tabIcons;
  final int activeIndex;
  final ValueChanged<int> onTabChanged;

  const NavBar({
    Key key,
    @required List tabIcons,
    this.activeIndex,
    this.onTabChanged,
  })  : _tabIcons = tabIcons,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: kShadowColor.withOpacity(0.14),
            blurRadius: 25,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_tabIcons.length, (index) {
          switch (index) {
            case 1:
              return Stack(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 30, ),
                    width: 20,
                    height: 20,
                    decoration:
                    BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(cart.item_count.toString()),
                      ],
                    )),
                NavBarItem(
                  icon: _tabIcons[index],
                  index: index,
                  activeIndex: activeIndex,
                  onTabChanged: onTabChanged,
                ),
              ]);
              break;
            default: {
              return NavBarItem(
                icon: _tabIcons[index],
                index: index,
                activeIndex: activeIndex,
                onTabChanged: onTabChanged,
              );
            }
          }
        }),
      ),
    );
  }
}
