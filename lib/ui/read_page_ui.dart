import 'dart:async';
import 'package:flutter/material.dart';

import '../admob_services.dart';
import '../consumable_storee.dart';

class ReadPageUI extends StatefulWidget {
  String string;
  int wpmSvalue;
  Color currentColor;
  Color currentColorF;
  double textSize;
  String cfn;

  ReadPageUI(
      {Key key,
      this.string,
      this.wpmSvalue,
      this.currentColor,
      this.currentColorF,
      this.textSize,
      this.cfn})
      : super(key: key);

  @override
  _ReadPageUIState createState() => _ReadPageUIState();
}

class _ReadPageUIState extends State<ReadPageUI> {
  int _start = 0;
  int _current = 0;
  String text = '';
  int value = 0;
  List<String> mylist = [];
  List<String> textParts = [];
  int _timerCounter = 0;
  Duration duration = Duration();
  Timer timer;

  bool isPlaying = true;
  // BannerAd _anchoredBanner;
  bool _loadingAnchoredBanner = false;

  @override
  void initState() {
    // TODO: implement initState
    text = widget.string;
    value = widget.wpmSvalue;

    String toSplitStrint = text.replaceAll('\n', ' ');
    List<String> textParts = toSplitStrint.split(" ");
    print(text);
    mylist.clear();
    for (var single in textParts) {
      mylist.add((single));
      print(single);
    }

    _current = mylist.length;
    _start = mylist.length - 1;
    startTimer();
    print(_start);
    print(_current);
    fetchpurchased();
    super.initState();
  }

  void startTimer() {
    int speed = (1000 * (60 / value)).toInt();
    timer = Timer.periodic(Duration(milliseconds: speed), (_) => addTimer());
  }

  void addTimer() {
    final addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds == _current) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void dispose() {
    // _anchoredBanner?.dispose();//eeeeeeee
    super.dispose();
  }
  // static final AdRequest request = AdRequest(
  //   keywords: <String>['foo', 'bar'],
  //   contentUrl: 'http://foo.com/bar.html',
  //   nonPersonalizedAds: true,
  // );
  // Future<void> _createAnchoredBanner(BuildContext context) async {
  //   final AnchoredAdaptiveBannerAdSize size =
  //   await AdSize.getAnchoredAdaptiveBannerAdSize(
  //     Orientation.portrait,
  //     MediaQuery.of(context).size.width.truncate(),
  //   );
  //
  //   if (size == null) {
  //     print('Unable to get height of anchored banner.');
  //     return;
  //   }
  //
  //   final BannerAd banner = BannerAd(
  //     size: size,
  //     request: request,
  //     adUnitId: Platform.isAndroid
  //         ? 'ca-app-pub-3940256099942544/6300978111'
  //         : 'ca-app-pub-3940256099942544/2934735716',
  //     listener: BannerAdListener(
  //       onAdLoaded: (Ad ad) {
  //         print('$BannerAd loaded.');
  //         setState(() {
  //           _anchoredBanner = ad as BannerAd;
  //         });
  //       },
  //       onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //         print('$BannerAd failedToLoad: $error');
  //         ad.dispose();
  //       },
  //       onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
  //       onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
  //     ),
  //   );
  //   return banner.load();
  // }

  @override
  Widget build(BuildContext context) {
    //
    // String oneDigits(int n) => n.toString().padLeft(1);
    // final seconds = oneDigits(duration.inSeconds.remainder(_current));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (BuildContext context) {
        if (!_loadingAnchoredBanner) {
          _loadingAnchoredBanner = true;
          // _createAnchoredBanner(context);
        }
        String oneDigits(int n) => n.toString().padLeft(1);
        final seconds = oneDigits(duration.inSeconds.remainder(_current));
        return Scaffold(
          appBar: AppBar(

            title: Text(
              'Scready',
              style: TextStyle(fontFamily: widget.cfn),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      widget.currentColor.withOpacity(1),
                      widget.currentColor.withOpacity(0.8),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.currentColor.withOpacity(1),
                widget.currentColor.withOpacity(0.2),
              ],
            )),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Image.asset("assets/scready/4.png"),
                    ),

                    // if (_anchoredBanner != null)
                    //   Container(
                    //     color: Colors.green,
                    //     width: _anchoredBanner.size.width.toDouble(),
                    //     height: _anchoredBanner.size.height.toDouble(),
                    //     child: AdWidget(ad: _anchoredBanner),
                    //   ),
                  ],
                ),
                homePageWidgets(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget homePageWidgets() {
    return Container(
      child: ListView(children: [
        Padding(
          padding: EdgeInsets.only(top: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: widget.currentColor.withOpacity(0.8),
                width: 320,
                height: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "${mylist[duration.inSeconds.remainder(_current)]}",
                // "${mylist[seconds]}",
                //"$mylist[$seconds]",
                style: TextStyle(
                    fontSize: widget.textSize,
                    color: widget.currentColorF,
                    fontFamily: widget.cfn),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: widget.currentColor.withOpacity(0.8),
                width: 320,
                height: 3,
              ),
              // Text(
              //   "$slideonevalue",
              //   // "${mylist[seconds]}",
              //   //"$mylist[$seconds]",
              //   style: TextStyle(fontSize: 30),
              // ),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          color: widget.currentColor.withOpacity(0.8),
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.arrow_left,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (isPlaying == true) {
                          timer.cancel();
                        } else {
                          // startTimer();
                        }
                        isPlaying = !isPlaying;

                        mylist[duration.inSeconds.remainder(_current)] =
                            mylist[0];
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isPlaying == true) {
                          timer.cancel();
                        } else {
                          startTimer();
                        }
                        isPlaying = !isPlaying;
                      });
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          color: widget.currentColor.withOpacity(0.8),
                          shape: BoxShape.circle),
                      child: isPlaying == true
                          ? Icon(
                              Icons.pause,
                              size: 35,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.play_arrow,
                              size: 35,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          color: widget.currentColor.withOpacity(0.8),
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.arrow_right,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (isPlaying == true) {
                          timer.cancel();
                        } else {
                          // startTimer();
                        }
                        isPlaying = !isPlaying;

                        mylist[duration.inSeconds.remainder(_current)] =
                            mylist[mylist.length - 1];
                      });
                    },
                  )
                ],
              ),

              SizedBox(
                height: 30,
              ),

              _consumables.length != 0 ? Container() : Container(
                height: 100,
                color: Colors.red,
                child: AdmobServices(),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  bool lightTheme = true;
  Color currentColor = Colors.blueAccent;
  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);
  List<Color> currentColors = [Colors.blueAccent, Colors.blue];


  List<String> _consumables = [];
  void fetchpurchased() async{
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
      print("_consumables");
      print(_consumables);
    });
  }
}
