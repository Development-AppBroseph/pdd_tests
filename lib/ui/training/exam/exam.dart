import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdd/helpers/route.dart';
import 'package:pdd/model/ticket.dart';

class ExamPage extends StatelessWidget {
  List<Question> ticket = [
    // Ticket(title: 'Проверка знаний'),
    // Ticket(title: 'Проверка знаний'),
    // Ticket(title: 'Проверка знаний'),
    // Ticket(title: 'Проверка знаний'),
    // Ticket(title: 'Проверка знаний'),
    // Ticket(title: 'Проверка знаний'),
    // Ticket(title: 'Проверка знаний'),
    // Ticket(title: 'Проверка знаний'),
    // Ticket(title: 'Проверка знаний'),
  ];

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

    return Material(
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
                      Icons.chevron_left,
                      size: 50.h,
                    ),
                  ),
                ),
                Text(
                  'Экзамен ПДД',
                  style: textStyle1,
                ),
                const SizedBox(
                  width: 50,
                  height: 50,
                )
              ],
            ),
            SizedBox(height: 50.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ticket.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(AppRouter.startExam),
                          child: Container(
                            height: 80.h,
                            padding: EdgeInsets.all(20.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20.w,
                                  child: Text(
                                    '${index + 1}',
                                    style: textStyle1,
                                  ),
                                ),
                                VerticalDivider(
                                  width: 12.w,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  ticket[index].title,
                                  style: textStyle1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
