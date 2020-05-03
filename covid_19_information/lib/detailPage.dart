import 'package:covid_19/core.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'model/model.dart';
import 'widgets/counter.dart';
import 'widgets/my_header.dart';

class DaysDetail extends StatefulWidget {
  Days days;
  DaysDetail(this.days);
  @override
  _DaysDetailPageState createState() => _DaysDetailPageState(days);
}

class _DaysDetailPageState extends State<DaysDetail> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  Days days;
  _DaysDetailPageState(this.days);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            controller: controller,
            child: Column(children: <Widget>[
              MyHeader(
                image: "assets/icons/Drcorona.svg",
                textTop: "Hayat",
                textBottom: "eve sığar.",
                offset: offset,
              ),
              SizedBox(height: 20),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          returnDate(days.date) + " Günlük Verileri",
                          style: TextStyle(fontSize: 22),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color: kInfectedColor,
                          number: int.parse(days.cases),
                          title: "Enfekte",
                        ),
                        Counter(
                          color: Color(0xFF00a6a4),
                          number: int.parse(days.recovered),
                          title: "İyileşen",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          child: Counter(
                            color: kDeathColor,
                            number: int.parse(days.deaths),
                            title: "Ölümler",
                          ),
                          padding: EdgeInsets.only(left: 15),
                        ),
                        Counter(
                          color: Color(0xFF00716f),
                          number: int.parse(days.tests),
                          title: "Günlük Test",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color: kInfectedColor,
                          number: int.parse(days.totalCases),
                          title: "Toplam Vaka",
                        ),
                        Counter(
                          color: Color(0xFF00a6a4),
                          number: int.parse(days.totalRecovered),
                          title: "Toplam İyileşen",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color: kInfectedColor,
                          number: int.parse(days.totalIntensiveCare),
                          title: "Toplam Yoğun\n           Bakım",
                        ),
                        Counter(
                          color: kDeathColor,
                          number: int.parse(days.totalIntubated),
                          title: "Toplam Entübe",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color: kDeathColor,
                          number: int.parse(days.totalDeaths),
                          title: "Toplam Ölen",
                        ),
                        Counter(
                          color: Color(0xFF00716f),
                          number: int.parse(days.totalTests),
                          title: "Toplam Test",
                        ),
                      ],
                    )
                  ])),
            ])));
  }
}
