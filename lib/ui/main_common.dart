import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdd/ui/chat/chat_page.dart';
import 'package:pdd/ui/rules/rules_page.dart';
import 'package:pdd/ui/schools/schools_page.dart';
import 'package:pdd/ui/training/training_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController();
  final streamController = StreamController<int>();

  @override
  void dispose() {
    pageController.dispose();
    streamController.close();
    super.dispose();
  }

  List<Widget> pages = [
    const TrainingPage(),
    SchoolsPage(),
    ChatPage(),
    RulesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 100.h),
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: pages,
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNavigator()),
        ],
      ),
    );
  }

  Widget bottomNavigator() {
    TextStyle styleSelect = const TextStyle(
        fontWeight: FontWeight.w700, fontSize: 12, color: Colors.red);
    TextStyle styleUnSelect = const TextStyle(
        fontWeight: FontWeight.w700, fontSize: 12, color: Colors.grey);

    return StreamBuilder<int>(
      stream: streamController.stream,
      initialData: 0,
      builder: (context, snapshot) {
        return Container(
          height: 100.h,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(bottom: 26.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    pageController.jumpToPage(0);
                    streamController.add(0);
                  },
                  child: Container(
                    width: 93.w,
                    height: 74.h,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 11.h),
                        SvgPicture.asset(
                          'assets/icons/training.svg',
                          height: 32.h,
                          width: 37.w,
                          color: snapshot.data == 0 ? Colors.red : Colors.grey,
                        ),
                        SizedBox(height: 12.h),
                        Text('Билеты',
                            style: snapshot.data == 0
                                ? styleSelect
                                : styleUnSelect),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pageController.jumpToPage(1);
                    streamController.add(1);
                  },
                  child: Container(
                    width: 93.w,
                    height: 74.h,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 11.h),
                        SvgPicture.asset(
                          'assets/icons/schools.svg',
                          height: 32.h,
                          width: 28.24.w,
                          color: snapshot.data == 1 ? Colors.red : Colors.grey,
                        ),
                        SizedBox(height: 12.h),
                        Text('Автошколы',
                            style: snapshot.data == 1
                                ? styleSelect
                                : styleUnSelect),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pageController.jumpToPage(2);
                    streamController.add(2);
                  },
                  child: Container(
                    width: 93.w,
                    height: 74.h,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 11.h),
                        SvgPicture.asset(
                          'assets/icons/chat.svg',
                          height: 32.h,
                          width: 32.w,
                          color: snapshot.data == 2 ? Colors.red : Colors.grey,
                        ),
                        SizedBox(height: 12.h),
                        Text('Сообщения',
                            style: snapshot.data == 2
                                ? styleSelect
                                : styleUnSelect),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pageController.jumpToPage(3);
                    streamController.add(3);
                  },
                  child: Container(
                    width: 93.w,
                    height: 74.h,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 11.h),
                        SvgPicture.asset(
                          'assets/icons/book.svg',
                          height: 32.h,
                          width: 29.26.w,
                          color: snapshot.data == 3 ? Colors.red : Colors.grey,
                        ),
                        SizedBox(height: 12.h),
                        Text('Правила',
                            style: snapshot.data == 3
                                ? styleSelect
                                : styleUnSelect),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
