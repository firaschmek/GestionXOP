import 'package:appgestion/UI/pages/products_screen.dart';
import 'package:appgestion/UI/pages/sous_famille_screen.dart';
import 'package:appgestion/UI/widgets/nav_bar.dart';
import 'package:appgestion/UI/pages/famille_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final List _tabIcons = List.unmodifiable([
    {'icon': 'images/icons/shop.svg', 'title': 'Acceuil'},
    {'icon': 'images/icons/cart.svg', 'title': 'Panier'},
    {'icon': 'images/icons/account.svg', 'title': 'Compte'},
  ]);

  final List<Widget> _tabs = List.unmodifiable([
    //FamilleScreen(),
    ApplicationNavigator(),

    Container(),
    Container(),
  ]);

  void onTabChanged(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        body: _tabs[currentIndex],
        bottomNavigationBar: NavBar(
          tabIcons: _tabIcons,
          activeIndex: currentIndex,
          onTabChanged: onTabChanged,
        ),
      ),
    );
  }
}
GlobalKey<NavigatorState> _appNavigatorKey = GlobalKey<NavigatorState>();
Future<bool> _systemBackButtonPressed() {
  if (_appNavigatorKey.currentState.canPop()) {
    _appNavigatorKey
        .currentState
        .pop(_appNavigatorKey.currentContext);
  } else {
    SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  }
}
class ApplicationNavigator extends StatelessWidget {
  const ApplicationNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _appNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return FamilleScreen();
                  break;
                case '/sousFamille':
                  return SousFamilleScreen();
                  break;
                case '/articleList':
                  return ArticleScreen();
                  break;

              }
            });
      },
    );
  }
}
