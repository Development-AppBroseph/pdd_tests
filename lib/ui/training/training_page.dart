import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdd/helpers/route.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleButton = const TextStyle(
      color: Colors.white,
      fontSize: 19,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    );

    TextStyle textStyle1 = const TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/computer.svg',
          height: 200.h,
        ),
        SizedBox(height: 50.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.white,
                  ),
                  height: 80.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: '423 ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                                text: '/800',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[400])),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 3,
                                width: 140,
                                margin: EdgeInsets.all(10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.r),
                                  color: Colors.grey[300],
                                ),
                              ),
                              Container(
                                height: 3,
                                width: 80,
                                margin: EdgeInsets.all(10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.r),
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'Вопросы',
                        style: textStyle1,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.white,
                  ),
                  height: 80.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: '13 ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                                text: '/40',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[400])),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 3,
                                width: 140,
                                margin: EdgeInsets.all(10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.r),
                                  color: Colors.grey[300],
                                ),
                              ),
                              Container(
                                height: 3,
                                width: 40,
                                margin: EdgeInsets.all(10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.r),
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'Билеты',
                        style: textStyle1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 80.h,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRouter.training),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                    child: Text(
                      'Билеты',
                      style: textStyleButton,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: SizedBox(
                  height: 80.h,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRouter.exam),
                    child: Text(
                      'Экзамен',
                      style: textStyleButton,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
