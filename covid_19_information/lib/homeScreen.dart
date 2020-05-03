import 'package:calendar_strip/calendar_strip.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'core.dart';
import 'model/model.dart';
import 'widgets/carouselWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "Hayat",
              textBottom: "eve sığar.",
              offset: offset,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  FutureBuilder<List<Days>>(
                      future: fetchPhotos(),
                      builder: (contex, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);

                        return snapshot.hasData
                            ? Center(
                                child: Text(
                                  returnDate(snapshot.data.last.date) +
                                      " Güncel Verileri",
                                  style: kTitleTextstyle,
                                ),
                              )
                            : Center(child: CircularProgressIndicator());
                      }),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: FutureBuilder<List<Days>>(
                      future: fetchPhotos(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);

                        return snapshot.hasData
                            ? (Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Counter(
                                    color: kInfectedColor,
                                    number: int.parse(snapshot.data.last.cases),
                                    title: "Enfekte",
                                  ),
                                  Counter(
                                    color: kDeathColor,
                                    number:
                                        int.parse(snapshot.data.last.deaths),
                                    title: "Ölümler",
                                  ),
                                  Counter(
                                    color: kRecovercolor,
                                    number:
                                        int.parse(snapshot.data.last.recovered),
                                    title: "İyileşen",
                                  ),
                                ],
                              ))
                            : Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  CarouselDeneme(),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
