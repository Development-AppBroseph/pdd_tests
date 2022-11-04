import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdd/helpers/route.dart';
import 'package:pdd/model/ticket.dart';

class Training extends StatefulWidget {
  @override
  State<Training> createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  List<List<Question>> tickets = [];
  @override
  void initState() {
    _getTickets();
    super.initState();
  }

  void _getTickets() async {
    for (var count = 1; count < 41; count++) {
      var ticket = await DefaultAssetBundle.of(context).loadString(
        'assets/pdd/questions/A_B/tickets/Билет $count.json',
      );
      // print(ticket);
      tickets.add(questionFromJson(ticket));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Билеты ПДД',
          style: textStyle1,
        ),
        backgroundColor: Colors.white.withOpacity(0),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tickets.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 15.h),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            AppRouter.startTest,
                            arguments: tickets[index]),
                        child: Container(
                          height: 80.h,
                          padding: EdgeInsets.all(20.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Row(
                            children: [
                              // SizedBox(
                              //   width: 20.w,
                              //   child: Text(
                              //     '${index + 1}',
                              //     style: textStyle1,
                              //   ),
                              // ),
                              // VerticalDivider(
                              //   width: 12.w,
                              //   color: Colors.black,
                              // ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                tickets[index].first.ticketNumber,
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
    );
  }
}
