import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdd/core/bloc/training_exam/training_exam_bloc.dart';
import 'package:pdd/helpers/route.dart';
import 'package:pdd/model/question.dart';
import 'package:pdd/model/ticket.dart';

class StartTestPage extends StatefulWidget {
  final List<Question> questions;

  const StartTestPage({super.key, required this.questions});
  @override
  State<StartTestPage> createState() => _StartTestPageState();
}

class _StartTestPageState extends State<StartTestPage> {
  PageController pageController = PageController();
  int currentIndex = 0;
  ScrollController _questionComtroller = ScrollController();

  @override
  void dispose() {
    print('dispose');
    widget.questions.forEach((element) {
      element.state = null;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    TextStyle textStyle2 = const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

    return BlocProvider<TrainingTestBloc>(
      create: (context) => TrainingTestBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          title: Text(
            widget.questions.first.ticketNumber,
            style: textStyle1,
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              height: 70.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.questions.length,
                controller: _questionComtroller,
                itemBuilder: ((context, index) {
                  return BlocBuilder<TrainingTestBloc, TrainingState>(
                    buildWhen: (previous, current) {
                      return true;
                    },
                    builder: (context, snapshot) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right:
                              index == widget.questions.length - 1 ? 20.w : 0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // if ((widget.questions[currentIndex].state != null &&
                            //         currentIndex + 1 == index) ||
                            //     index < currentIndex) {
                            currentIndex = index;
                            setState(() {});
                            jumpPage(index);
                            if (index < 17) {
                              _questionComtroller.animateTo(
                                  (70 * index - 240).toDouble(),
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.easeInOutQuint);
                              // }
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50.h,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: widget.questions[index].state == null
                                      ? Colors.grey[100]
                                      : widget.questions[index].state!
                                          ? Colors.green[300]
                                          : Colors.red[300],
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: textStyle2.copyWith(
                                        color: widget.questions[index].state ==
                                                null
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Stack(
                children: [
                  PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: widget.questions
                        .map((e) => ItemTest(question: e))
                        .toList(),
                  ),
                  BlocBuilder<TrainingTestBloc, TrainingState>(
                    buildWhen: (previous, current) {
                      return true;
                    },
                    builder: (context, snapshot) {
                      if (widget.questions[currentIndex].state != null) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: (() {
                              if (currentIndex == widget.questions.length - 1) {
                                Navigator.of(context).pushNamed(
                                    AppRouter.result,
                                    arguments: widget.questions);
                              } else {
                                jumpPage(++currentIndex);
                                BlocProvider.of<TrainingTestBloc>(context)
                                    .add(AnswerEvents());
                              }
                            }),
                            child: Container(
                              height: 60.h,
                              margin: const EdgeInsets.only(
                                bottom: 40,
                                right: 15,
                                left: 15,
                              ),
                              decoration: BoxDecoration(
                                  color: widget.questions[currentIndex].state!
                                      ? Colors.green[300]
                                      : Colors.red[300],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: widget.questions[currentIndex].state!
                                    ? Text(
                                        'Продолжить',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    : Text(
                                        'Продолжить',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void jumpPage(int page) => pageController.animateToPage(page,
      duration: const Duration(seconds: 1), curve: Curves.easeInOutCubic);
}

class ItemTest extends StatefulWidget {
  Question question;

  ItemTest({required this.question});

  @override
  State<ItemTest> createState() => _ItemTestState();
}

class _ItemTestState extends State<ItemTest> {
  List<String> coments = [];
  int? choice;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.question.state);
    TextStyle textStyle1 = const TextStyle(
      color: Colors.black,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    );
    print(widget.question.image);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 30.h)),
          if (!widget.question.image.contains('no_image'))
            SliverToBoxAdapter(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(widget.question.image),
              ),
            ),
          if (!widget.question.image.contains('no_image'))
            SliverToBoxAdapter(
              child: SizedBox(
                height: 30.h,
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 5),
              child: Text(
                widget.question.question,
                style: textStyle1,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 30.h)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: widget.question.answers.length,
              (context, index) {
                return BlocBuilder<TrainingTestBloc, TrainingState>(
                    buildWhen: (previous, current) {
                  return true;
                }, builder: (context, snapshot) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: GestureDetector(
                      onTap: () {
                        if (widget.question.state == null) {
                          if (widget.question.answers[index].isCorrect) {
                            widget.question.state = true;
                          } else {
                            widget.question.state = false;
                          }
                          choice = index;
                          BlocProvider.of<TrainingTestBloc>(context)
                              .add(AnswerEvents());
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: widget.question.state != null
                              ? widget.question.answers[index].isCorrect
                                  ? Colors.green[300]
                                  : Colors.red[100]
                              : Colors.grey[100],
                        ),
                        child: Row(
                          children: [
                            VerticalDivider(
                              width: 5.w,
                              color: Colors.black,
                            ),
                            Text(
                              '${index + 1}.',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            VerticalDivider(
                              width: 5.w,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              // margin: EdgeInsets.only(right: 100),
                              width: MediaQuery.of(context).size.width - 130,
                              child: Text(
                                widget.question.answers[index].answerText,
                                maxLines: 10,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const Spacer(),
                            choice != null && index == choice
                                ? const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 15,
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          if (widget.question.state != null)
            SliverToBoxAdapter(
              child: Text(
                widget.question.answerTip,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          if (widget.question.state != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffF2F2F2),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffF2F2F2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: TextButton(
              onPressed: () {
                setState(() {
                  coments.add(_controller.text);
                });
              },
              child: const Text("Отправить"),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                  itemCount: coments.length,
                  itemBuilder: (context, index) {
                    return Text(coments[index]);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
