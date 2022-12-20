import 'package:flutter/material.dart';
import 'package:how_many_i_spend/services/calendar-service.dart';
import 'package:how_many_i_spend/services/pages-service.dart';

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
    _initializeScale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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

  Future<void> _initializeScale() async {
    final CalendarService _service = CalendarService();

    await _service.updateCalendarEventList();
  }
}
