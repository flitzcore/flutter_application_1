import 'package:flutter/material.dart';
import 'model/tourism_place.dart';

import 'detail_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wisata Bandung'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return TourismPlaceList();
          } else if (constraints.maxWidth <= 1020) {
            return TourismPlaceGrid(gridCount: 3);
          } else if (constraints.maxWidth <= 1200) {
            return TourismPlaceGrid(gridCount: 4);
          } else {
            return TourismPlaceGrid(gridCount: 6);
          }
        },
      ),
    );
  }
}

class TourismPlaceGrid extends StatelessWidget {
  int gridCount;

  TourismPlaceGrid({required this.gridCount});
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: GridView.count(
          crossAxisCount: gridCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: tourismPlaceList.map((place) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailScreen(place: place);
                }));
              },
              child: Card(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Hero(
                          tag: "image_${place.name}",
                          child:
                              Image.asset(place.imageAsset, fit: BoxFit.cover)),
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                place.name,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(place.location),
                            ],
                          )),
                    )
                  ])),
            );
          }).toList()),
    );
  }
}

class TourismPlaceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final TourismPlace place = tourismPlaceList[index];
        child:
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailScreen(place: place);
            }));
          },
          child: Card(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Expanded(
                  child: Hero(
                      tag: "image_${place.name}",
                      child: Image.asset(place.imageAsset)),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            place.name,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(place.location),
                        ],
                      )),
                )
              ])),
        );
      },
      itemCount: tourismPlaceList.length,
    );
  }
}
