import 'package:flutter/material.dart';

import 'model/tourism_place.dart';

class DetailScreen extends StatelessWidget {
  final TourismPlace place;
  DetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 800) {
        return DetailWebPage(place: place);
      } else {
        return DetailMobilePage(place: place);
      }
    });
  }
}

class DetailWebPage extends StatefulWidget {
  final TourismPlace place;

  DetailWebPage({required this.place});

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "WISATA BANDUNG",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
              width: 1200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(169, 60, 140, 160),
                      offset: Offset(0, 0),
                      blurRadius: 5,
                    )
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Hero(
                        tag: "image_${widget.place.name}",
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(widget.place.imageAsset))),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                            widget.place.name),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.calendar_today),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(widget.place.openDays),
                              ],
                            ),
                            FavoriteButton()
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.access_time_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text(widget.place.openTime),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.monetization_on),
                            SizedBox(
                              width: 5,
                            ),
                            Text(widget.place.ticketPrice),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 20),
                          child: Text(
                            widget.place.description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: SizedBox(
                height: 150,
                width: 1200,
                child: ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  children: widget.place.imageUrls.map((url) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(url),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class DetailMobilePage extends StatelessWidget {
  final TourismPlace place;

  const DetailMobilePage({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(children: <Widget>[
                  Hero(
                      tag: "image_${place.name}",
                      child: Image.asset(place.imageAsset)),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            child: FavoriteButton(),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
                Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    child: Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                        place.name)),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(Icons.calendar_today),
                          SizedBox(
                            height: 5,
                          ),
                          Text(place.openDays),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.access_time_outlined),
                          SizedBox(
                            height: 5,
                          ),
                          Text(place.openTime),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.monetization_on),
                          SizedBox(
                            height: 5,
                          ),
                          Text(place.ticketPrice),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    place.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: place.imageUrls.map((url) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(url),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}
