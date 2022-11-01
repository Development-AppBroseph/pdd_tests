import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdd/core/bloc/training_exam/training_exam_bloc.dart';
import 'package:pdd/helpers/route.dart';
import 'package:pdd/model/question.dart';

class StartExamPage extends StatefulWidget {
  @override
  State<StartExamPage> createState() => _StartExamPagePageState();
}

class _StartExamPagePageState extends State<StartExamPage> {
  PageController pageController = PageController();
  int currentIndex = 0;

  List<Question> question = [
    Question(
      image: 'image',
      question: 'Как меня зовут?',
      answer: {
        'Дима': false,
        'Олег': true,
        'Алёша': false,
      },
    ),
    Question(
      image: 'image',
      question: 'Столица мира?',
      answer: {
        'Москва': false,
        'Волковысск': false,
        'ХМАО': true,
      },
    ),
    Question(
      image: 'image',
      question: 'В чем сила брат?',
      answer: {
        'Деньгах': false,
        'Правде': true,
        'Власти': false,
      },
    ),
    Question(
      image: 'image',
      question: 'Как меня зовут?',
      answer: {
        'Дима': false,
        'Олег': true,
        'Алёша': false,
      },
    ),
    Question(
      image: 'image',
      question: 'Столица мира?',
      answer: {
        'Москва': false,
        'Волковысск': false,
        'ХМАО': true,
      },
    ),
  ];

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
      child: Material(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      color: Colors.transparent,
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.clear,
                        size: 30.h,
                      ),
                    ),
                  ),
                  Text(
                    'Экзамен №..',
                    style: textStyle1,
                  ),
                  const SizedBox(
                    width: 50,
                    height: 50,
                  )
                ],
              ),
              SizedBox(height: 50.h),
              SizedBox(
                height: 50.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: question.length,
                  itemBuilder: ((context, index) {
                    return BlocBuilder<TrainingTestBloc, TrainingState>(
                      buildWhen: (previous, current) {
                        return true;
                      },
                      builder: (context, snapshot) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 20.w,
                              right: index == question.length - 1 ? 20.w : 0),
                          child: GestureDetector(
                            onTap: question[index].state == null
                                ? () {
                                    currentIndex = index;
                                    jumpPage(index);
                                  }
                                : null,
                            child: Container(
                              width: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: question[index].state == null
                                    ? Colors.white
                                    : question[index].state!
                                        ? Colors.green[300]
                                        : Colors.red[300],
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: textStyle2,
                                ),
                              ),
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
                      children:
                          question.map((e) => ItemTest(question: e)).toList(),
                    ),
                    BlocBuilder<TrainingTestBloc, TrainingState>(
                        buildWhen: (previous, current) {
                      return true;
                    }, builder: (context, snapshot) {
                      if (question[currentIndex].state != null) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: (() {
                              if (currentIndex == question.length - 1) {
                                Navigator.of(context).pushNamed(
                                    AppRouter.result,
                                    arguments: question);
                              } else {
                                jumpPage(++currentIndex);
                                BlocProvider.of<TrainingTestBloc>(context)
                                    .add(AnswerEvents());
                              }
                            }),
                            child: Container(
                              height: 60.h,
                              color: question[currentIndex].state!
                                  ? Colors.green[300]
                                  : Colors.red[300],
                              child: Center(
                                child: question[currentIndex].state!
                                    ? Text(
                                        'Правильно',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    : Text(
                                        'Неправильно',
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
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void jumpPage(int page) => pageController.animateToPage(page,
      duration: const Duration(seconds: 1), curve: Curves.easeInOutCubic);
}

class ItemTest extends StatelessWidget {
  Question question;
  int? choice;

  ItemTest({required this.question});
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Image.asset('assets/images/prev_question.webp'),
          Text(
            question.question,
            style: textStyle1,
          ),
          SizedBox(
            height: 30.h,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: question.answer.length,
              itemBuilder: (context, index) {
                return BlocBuilder<TrainingTestBloc, TrainingState>(
                    buildWhen: (previous, current) {
                  return true;
                }, builder: (context, snapshot) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: GestureDetector(
                      onTap: () {
                        if (question.state == null) {
                          if (question.answer.values.elementAt(index)) {
                            question.state = true;
                          } else {
                            question.state = false;
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
                            color: question.state != null
                                ? question.answer.values.elementAt(index)
                                    ? Colors.green[300]
                                    : Colors.red[300]
                                : null),
                        child: Row(
                          children: [
                            Text(
                              '${index + 1}',
                            ),
                            VerticalDivider(
                              width: 12.w,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              question.answer.keys.elementAt(index),
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
        ],
      ),
    );
  }
}
