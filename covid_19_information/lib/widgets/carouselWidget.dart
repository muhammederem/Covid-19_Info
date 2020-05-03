import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid_19/detailPage.dart';
import 'package:covid_19/model/model.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../core.dart';
import 'counter.dart';

class CarouselDeneme extends StatefulWidget {
  @override
  _CarouselDenemeState createState() => _CarouselDenemeState();
}

class _CarouselDenemeState extends State<CarouselDeneme> {
  List<Days> days;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    void goSwiperPages(List<Days> days, int position) async {
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) => DaysDetail(days[position])));
    }

    return FutureBuilder(
        future: fetchPhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? (CarouselSlider.builder(
                  options: CarouselOptions(
                    autoPlayAnimationDuration: Duration(seconds: 2),
                    autoPlay: true,
                    viewportFraction: 0.8,
                    height: MediaQuery.of(context).size.height * 0.30,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int position) {
                    if (snapshot.data.length != 0) {
                      return GestureDetector(
                          onTap: () {
                            goSwiperPages(snapshot.data, position);
                          },
                          child: Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color(0xFF00716f),
                                        Color(0xFF00a6a4),
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Center(
                                            child: Text(
                                                returnDate(snapshot
                                                    .data[position].date),
                                                style:
                                                    kHeadingTextStyle.copyWith(
                                                  color: Colors.white,
                                                ))),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 40, 10, 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Counter(
                                                color: Colors.white,
                                                number: int.parse(snapshot
                                                    .data[position].cases),
                                                title: "Enfekte",
                                              ),
                                              Counter(
                                                color: Colors.white,
                                                number: int.parse(snapshot
                                                    .data[position].deaths),
                                                title: "Ölümler",
                                              ),
                                              Counter(
                                                color: Colors.white,
                                                number: int.parse(snapshot
                                                    .data[position].recovered),
                                                title: "İyileşen",
                                              ),
                                            ],
                                          )),
                                    ],
                                  ))));
                    } else {
                      fetchPhotos();
                    }
                  },
                ))
              : Center(child: CircularProgressIndicator());
        });
  }
}
