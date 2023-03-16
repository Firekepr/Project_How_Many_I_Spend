import 'package:flutter/material.dart';
import 'package:how_many_i_spend/pages/home/components/drawer.dart';
import 'package:how_many_i_spend/services/calendar-service.dart';
import 'package:how_many_i_spend/provider/pages-service.dart';

import '../../global.dart';
import '../../services/global-context.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController = PageController(keepPage: false);
  List<int> _pageStack = [];
  List<Widget> _pageList = [];

  @override
  void initState() {
    _pageController = PageController(keepPage: false);
    _pageList = getPages(_pageController, _goBack);
    _initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageStack.length > 1) {
          _goBack();
        }
        return false;

      },
      child: Scaffold(
        key: GlobalContextKey.drawerKey,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => GlobalContextKey.drawerKey.currentState?.openDrawer(),
            child: const Icon(Icons.menu),
          ),
        ),
        drawer: AppDrawer(
          pageController: _pageController,
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (page) {
            if (_pageStack.isEmpty || _pageStack.last != page) {
              setState(() {
                if (_pageStack.isEmpty) {
                  _pageStack.add(_pageController.initialPage);
                }
                _pageStack.add(page);
              });
            }
          },
          children: _pageList,
        ),
      ),
    );
  }

  void _goBack() {
    setState(() {
      _pageStack.removeLast();
      _pageController.jumpToPage(_pageStack.last);
    });
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  Future<void> _initializeApp() async {
    final CalendarService _service = CalendarService();

    Global.selectedDay = DateTime.now();
    await _service.updateCalendarEventList();
    await _service.updateCalendarEventListDay();
  }
}
