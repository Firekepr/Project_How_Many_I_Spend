import 'package:flutter/material.dart';
import 'package:how_many_i_spend/provider/pages-service.dart';
import 'package:how_many_i_spend/services/system-service.dart';

class Initialize extends StatefulWidget {
  const Initialize({Key? key}) : super(key: key);

  @override
  State<Initialize> createState() => _InitializeState();
}

class _InitializeState extends State<Initialize> {
  PageController _pageController = PageController(keepPage: false);
  List<int> pageStack = [];
  List<Widget> _pageList = [];

  @override
  void initState() {
    _pageController = PageController(keepPage: false);
    _pageList = getInitialPages(_pageController, _goBack);
    _initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: pageStack.length > 1,
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (page) {
            if (pageStack.isEmpty || pageStack.last != page) {
              setState(() {
                if (pageStack.isEmpty) {
                  pageStack.add(_pageController.initialPage);
                }
                pageStack.add(page);
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
      pageStack.removeLast();
      _pageController.jumpToPage(pageStack.last);
    });
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  Future<void> _initializeApp() async {
    await SystemService().loadSystem(context, _pageController);
  }
}
