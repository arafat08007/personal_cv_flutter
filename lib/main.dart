import 'dart:convert';
import 'dart:io';
import 'package:Nazrul_Islam_mollah/widget/CustomTextFeild.dart';
import 'package:dio/dio.dart';
//import 'package:flutter_fb_news/flutter_fb_news.dart';
import 'package:Nazrul_Islam_mollah/view/PhotGallery.dart';
import 'package:Nazrul_Islam_mollah/model/GlobalInfo.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

//import 'package:lottie/lottie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ndialog/ndialog.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';

import 'controller/home_controller.dart';
import 'package:get/get.dart';
import './controller/API.dart';

import 'package:http/http.dart' as http;
//model
import './model/EducationDataModel.dart';
import 'model/messageModel.dart';
import 'widget/CustomButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  // Fetch content from the json file

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselController buttonCarouselController = CarouselController();
  TextEditingController nameEditController = TextEditingController();
  TextEditingController emailEditController = TextEditingController();
  TextEditingController subjectEditController = TextEditingController();
  TextEditingController messageBodyEditController = TextEditingController();

  List _bioData =[];
  List _educationData = [];
  List _politicsData = [];
  List _timelineData = [];
  List _socialActData = [];
  List _postData = [];
  List _qouteData   = [];

  List _imagesData = [];
  List _missionData = [] ;


  final dio = Dio();
  //fb page feed
  String fbPageId = "";
  String fbAccessTockent = "";
  String fbAppId = "2076096689448739";

  // Fetch content from the json file
  Future<void> readBioJson() async {
    var edata;
    print('Reading bio data, please wait...');
    _educationData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res = await http.get(Uri.parse(GlobalAPI.bioData));
      if (res.statusCode == 200) {
        edata = await json.decode(res.body);
        print ('bio api response/n') ;
        print (edata);
      }
      setState(() {
        _bioData = edata["bios"];
      });
    }
    catch (e){
      debugPrint(e.toString());
    }
    print(_bioData.length);

  }

  Future<void> readQuoteJson() async {
    var edata;
    print('Reading quote data, please wait...');
    _qouteData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res = await http.get(Uri.parse(GlobalAPI.quoteData));
      if (res.statusCode == 200) {
        edata = await json.decode(res.body);
        print ('quote api response/n') ;
        print (edata);
      }
      setState(() {
        _qouteData = edata["quotes"];
      });
    }
    catch (e){
      debugPrint(e.toString());
    }
    print(_qouteData.length);

  }
  Future<void> readMissionJson() async {
    var edata;
    print('Reading missions data, please wait...');
    _missionData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res = await http.get(Uri.parse(GlobalAPI.missionData));
      if (res.statusCode == 200) {
        edata = await json.decode(res.body);
        print ('missions api response/n') ;
        print (edata);
      }
      setState(() {
        _missionData = edata["missions"];
      });
    }
    catch (e){
      debugPrint(e.toString());
    }
    print(_missionData.length);

  }

  Future<void> readEducationJson() async {
    var edata;
    print('Reading Education data, please wait...');
    _educationData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res = await http.get(Uri.parse(GlobalAPI.educationData));
      if (res.statusCode == 200) {
        edata = await json.decode(res.body);
        print ('Education api response/n') ;
        print (edata);
      }
      setState(() {
        _educationData = edata["educations"];
      });
    }
    catch (e){
      debugPrint(e.toString());
    }
    print(_educationData.length);
  }

  Future<void> readpoliticJson() async {
    var edata;
    print('Reading political data, please wait...');
    _politicsData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res = await http.get(Uri.parse(GlobalAPI.politicData));
      if (res.statusCode == 200) {
        edata = await json.decode(res.body);
        print ('political api response/n') ;
        print (edata);
      }
      setState(() {
        _politicsData = edata["politics"];
      });
    }
    catch (e){
      debugPrint(e.toString());
    }
    print(_politicsData.length);

  }

  Future<void> readsocialJson() async {
    var edata;
    print('Reading missions data, please wait...');
    _socialActData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res = await http.get(Uri.parse(GlobalAPI.activityData));
      if (res.statusCode == 200) {
        edata = await json.decode(res.body);
        print ('missions api response/n') ;
        print (edata);
      }
      setState(() {
        _socialActData = edata["activities"];
      });
    }
    catch (e){
      debugPrint(e.toString());
    }
    print(_socialActData.length);
  }

  Future<void> readTimelineJson() async {
    var edata;
    print('Reading missions data, please wait...');
    _timelineData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res = await http.get(Uri.parse(GlobalAPI.timelineData));
      if (res.statusCode == 200) {
        edata = await json.decode(res.body);
        print ('missions api response/n') ;
        print (edata);
      }
      setState(() {
        _timelineData = edata["activities"];
      });
    }
    catch (e){
      debugPrint(e.toString());
    }
    print(_timelineData.length);
  }

  Future<void> readPostJson() async {
    print('Reading post data, please wait...');
    _postData.clear();
    String response = await rootBundle.loadString('data/postData.json');
    final edata = await json.decode(response);
    print(edata.toString());
    setState(() {
      _postData = edata["post"];
    });
    print(_postData.toString());
  }

  Future<void> readGalleryJson() async {
    var edata;
    print('Reading photo data, please wait...');
    _imagesData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res = await http.get(Uri.parse(GlobalAPI.photoData));
      if (res.statusCode == 200) {
        edata = await json.decode(res.body);
        print ('photo api response/n') ;
        print (edata);
      }
      setState(() {
        _imagesData = edata["photos"];
      });
    }
    catch (e){
      debugPrint(e.toString());
    }
    print(_imagesData.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readBioJson();
    readQuoteJson ();
    readMissionJson();
    readEducationJson();
    readpoliticJson();
    readsocialJson();
    readTimelineJson();
    readGalleryJson();
    readPostJson();

    print("initState() called" );
  }
  @override
  void dispose() {
    //buttonCarouselController.dispose();
    // ignore: avoid_print
    nameEditController.dispose();
    emailEditController.dispose();
    subjectEditController.dispose()   ;
    messageBodyEditController.dispose();
    print('Dispose used');
    super.dispose();
  }

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF023020),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.facebook_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              print('Fb button clicked');
              openFb();
              // readEducationJson();
              // do something
            },
          ),
          IconButton(
            icon: Icon(
              Icons.deblur,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              print('Click whatsapp');
              openWhatsapp("+8801717998754", "Hello Vi");
            },
          ),
          IconButton(
            icon: Icon(
              Icons.wordpress_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              print('Click on open website');
              openWebsite();
            },
          )
        ],
      ),
      backgroundColor: Color(0xFF023020),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              name,
              profilTitle,
              BioDesc (_bioData,context),
              Divider(
                indent: 50,
                endIndent: 50,
                thickness: 0.3,
                color: Colors.white,
              ),
              Qoute(_qouteData, context),
              Divider(
                indent: 50,
                endIndent: 50,
                thickness: 0.3,
                color: Colors.white,
              ),
              MissionVision(_missionData,context),
              educationTitle,
              education(_educationData, context),
              formationTitle,
              politics(_politicsData, context),
              competenceTitle,
              SocialActvites(_socialActData, context),
              //formation,
              TimelineTitle,
              TimelineWidget(_timelineData, context),
              PhotoGalleryTitle,
              galleryPicture(_imagesData, context),
              //langueTitle,
              //langue,
              contatcTitle,
              contact(context, nameEditController, emailEditController, subjectEditController, messageBodyEditController ),
            ],
          ),
        ),
      ),
    );
  }

  void openFb() async {
    final Uri url = Uri.parse('https://www.facebook.com/Dhaka14NazrulIslamMollah');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void openWebsite() async {
    final Uri url = Uri.parse('https://nazrulislammollah.com/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<String> openWhatsapp(String phone, String message) async {
    try {
      if (Platform.isAndroid) {
        print('platform\t' + Platform.operatingSystem);
        // add the [https]
        return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
      } else if (Platform.isIOS) {
        print('platform\t' + Platform.operatingSystem);
        // add the [https]
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
      } else {
        print('platform' + Platform.operatingSystem);
        Fluttertoast.showToast(
            msg:
                "Unable to open whatsapp , either Whatsapp missing or permission denied",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print('Unable to load whatsapp\t' + e.toString());
    }
  }

}


Widget BioDesc (_BioDesc,context) {
  return  _BioDesc.isNotEmpty?
  Container(
    width: double.infinity,
    padding: EdgeInsets.all(25),
    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xFFEFC777),
    ),
    child: (
        Text(_BioDesc[0]["description"])
    ),
  ):

  Container(
    width: double.infinity,
    padding: EdgeInsets.all(25),
    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xFFEFC777),
    ),
    child: Text(
      "নিজের ব্যাপারে সর্বোচ্চ ২০০ শব্দে কিছু দেখাবে",
      style: TextStyle(
        color: Color(0xFF2C352D),
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
Widget Qoute(_qouteData, context) {
  final homeController = Get.find<HomeController>();

  return _qouteData.isNotEmpty
      ? Column(
          children: [
            Container(
              color: Color(0xFF023020),
              height: MediaQuery.of(context).size.height * 0.13,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Center(
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                    aspectRatio: 2.0,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      homeController.selectedIndex.value = index;
                    },
                  ),
                  itemCount: _qouteData.length, // The length of the posts list
                  itemBuilder: (context, index, realIndex) {
                    // A function that returns a widget for each post
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF023020),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "\"${_qouteData[index]['description']}\"",
                            // The post description
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Obx(
              () => DotsIndicator(
                dotsCount: _qouteData.length, // The length of the posts list
                position: homeController.selectedIndex.value.toDouble(),
                decorator: DotsDecorator(
                    color: Colors.white, // The inactive dot color
                    activeColor: Colors.yellowAccent // The active dot color
                    ),
              ),
            ),
          ],
        )
      : Container(
          child: Text('NO QUOTE FOUND!'),
        );
}
Widget MissionVision (_missionData , context) {
  return  _missionData.isNotEmpty?
  Container(
    padding: EdgeInsets.only(top: 15),
    alignment: Alignment.topCenter,
    child: Column(
      children: [
        Text(
          'মিশন ও ভিশন',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(_missionData[0]["description"],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            )),
      ],
    ),
  )
      :Container(
    padding: EdgeInsets.only(top: 15),
    //alignment: Alignment.centerLeft,
    alignment: Alignment.topLeft,
    child: Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Text(
            'মিশন ও ভিশন',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Mission Text',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
              )),
          Divider(
            indent: 50,
            endIndent: 50,
            thickness: 0.5,
            color: Colors.amber,
          ),
          Text('Vision Text',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
              )),
        ],
      ),
    ),
  );          }
Widget education(_educationData, context) {
  return _educationData.isNotEmpty
      ? Container(
    width: MediaQuery.of(context).size.width,
    height: 200,
    child: ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: _educationData.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.black54,
          margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
          child: ListTile(
            leading: Text(_educationData[index]["year"],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.amber)),
             title: Text(_educationData[index]["title"],
                style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 16,
                     color: Colors.amber)),
            subtitle: Text(_educationData[index]["description"],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.white)),
          ),
        );
      },
    ),
  )
      : Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF16181D),
      ),
      child: Text('No Data found!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.redAccent)));
  ;
}

Widget politics(_politicsData, context) {
  return _politicsData.isNotEmpty
      ? Container(
    width: MediaQuery.of(context).size.width,
    height: 200,
    child: ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: _politicsData.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.black54,
          elevation: 0,
          margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
          child: ListTile(
            leading: Text(_politicsData[index]["year"],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.amber)),
            title: Text(_politicsData[index]["title"],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.amber)),
            subtitle: Text(_politicsData[index]["description"],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.white)),
          ),
        );
      },
    ),
  )
      : Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF16181D),
      ),
      child: Text('No Data found!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.redAccent)));
}
Widget SocialActvites(_socialActData, context) {
  return _socialActData.isNotEmpty
      ? Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFF16181D),
    ),
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            //     width: 300,
            height: MediaQuery.of(context).size.height*0.3,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFF16181D),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: _socialActData.length,
              itemBuilder: (context, index) {
                return Card(
                    color: Color(0xFF16181D),
                    child: Column(children: <Widget>[
                      Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Image.network(
                              _socialActData[index]["image"]
                                  .toString(),
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception,
                                  StackTrace stackTrace) {
                                return Text('404 Not Found!');
                              },
                            ),
                            Positioned(
                              bottom: 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  getFormatedDate(_socialActData[index]["timestamp"]
                                      .toString()),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ),
                            ),
                          ]),
                      Divider(
                        thickness: 0.3,
                        color: Colors.amber,
                        height: 5,
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          _socialActData[index]["title"].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          maxLines: 5,
                          softWrap: true,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          _socialActData[index]["description"].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 8,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          maxLines: 5,
                          softWrap: true,
                        ),
                      )
                    ]));
              },
            ),
          ),
        ],
      ),
    ),
  )
      : Container(
    width: 150,
    height: 150,
    margin: EdgeInsets.only(right: 25),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.redAccent,
    ),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage(
              "images/noimage.jpg",
            ),
            width: 50,
            height: 50,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Text(
            "Nothing found",
            style: GoogleFonts.lato(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

getFormatedDate(_date) {
  var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
  var inputDate = inputFormat.parse(_date);
  var outputFormat = DateFormat('MMMM, yyyy');
  return outputFormat.format(inputDate);
}
Widget galleryPicture(_imageData, context) {


  return _imageData.isNotEmpty
      ? Container(
        height: MediaQuery.of(context).size.height * 0.4,
        margin: EdgeInsets.all(3),
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
              childAspectRatio: (2 / 2.5),

          ),
          itemCount: _imageData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(3),
              child: GestureDetector(
                onTap: (){
                  CustomDailog(context,_imageData[index]['title'],
                     "",
                     // _imageData[index]['Description'].i,
                      true,
                      _imageData[index]['image']
                  );
                },
                child: Image.network(_imageData[index]['image'],
                  fit: BoxFit.fill,
                  height: 120.0,
                  width: 120.0,),
              ),
            );
          },
        ),
      )
      : Container(
          child: Text('NO POST FOUND!'),
        );
}

Widget name = Container(
  child: Column(
    children: <Widget>[
      Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Image(
            image: AssetImage('images/profile.png'),
            height: 100,
            width: 100,
          ),
        ),
      ),
      Divider(
        indent: 50,
        endIndent: 50,
        thickness: 0.3,
        color: Colors.white,
      ),
      Text(
        "নজরুল ইসলাম মোল্লা",
        style: GoogleFonts.lato(
          fontSize: 20,
          color: Colors.yellow,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        "ঢাকা-১৪",
        style: GoogleFonts.lato(
          fontSize: 18,
          color: Color(0xFFFAFAFA),
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
);

Widget profilTitle = Container(
  alignment: Alignment.centerLeft,
  child: Padding(
    padding: const EdgeInsets.only(
      top: 20,
      left: 30,
    ),
    child: Text(
      "আমার সম্পর্কিত",
      style: GoogleFonts.lato(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);



Widget formationTitle = Container(
  alignment: Alignment.centerLeft,
  child: Padding(
    padding: const EdgeInsets.only(
      top: 10,
      left: 30,
    ),
    child: Text(
      "রাজনীতি",
      style: GoogleFonts.lato(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);

Widget educationTitle = Container(
  alignment: Alignment.centerLeft,
  child: Padding(
    padding: const EdgeInsets.only(
      top: 20,
      left: 30,
    ),
    child: Text(
      "শিক্ষাগত যোগ্যতা",
      style: GoogleFonts.lato(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);



Widget competenceTitle = Container(
  alignment: Alignment.centerLeft,
  child: Padding(
    padding: const EdgeInsets.only(
      top: 20,
      left: 30,
    ),
    child: Text(
      "সামাজিক কর্ম",
      style: GoogleFonts.lato(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);



Widget TimelineTitle = Container(
  alignment: Alignment.centerLeft,
  child: Padding(
    padding: const EdgeInsets.only(
      top: 20,
      left: 30,
    ),
    child: Text(
      "টাইমলাইন",
      style: GoogleFonts.lato(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);

Widget TimelineWidget(_timelineData, context) {
  return Container(
    child: Text('Data fetching ... \n please wait...', style: GoogleFonts.lato(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),),
  ) ;
  //childHorizontal: HorizontalTimeline();
}

Widget PhotoGalleryTitle = Container(
  alignment: Alignment.centerLeft,
  child: Padding(
    padding: const EdgeInsets.only(
      top: 20,
      left: 30,
    ),
    child: Text(
      "ফটো গ্যালারী",
      style: GoogleFonts.lato(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);

Widget langueTitle = Container(
  alignment: Alignment.centerLeft,
  child: Padding(
    padding: const EdgeInsets.only(
      top: 20,
      left: 30,
    ),
    child: Text(
      "Compétence Linguistique",
      style: GoogleFonts.lato(
        fontSize: 25,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);
Widget langue = Container(
  width: double.infinity,
  padding: EdgeInsets.all(25),
  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Color(0xFF16181D),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(
        child: Column(
          children: <Widget>[
            Text(
              "Arabe",
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Bilingue",
              style: GoogleFonts.lato(
                fontSize: 12,
                color: Color(0xFF6E717E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      Container(
        child: Column(
          children: <Widget>[
            Text(
              "Francais",
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "TCF-C1",
              style: GoogleFonts.lato(
                fontSize: 12,
                color: Color(0xFF6E717E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      Container(
        child: Column(
          children: <Widget>[
            Text(
              "Anglais",
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Courant",
              style: GoogleFonts.lato(
                fontSize: 12,
                color: Color(0xFF6E717E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

Widget contatcTitle = Container(
  alignment: Alignment.centerLeft,
  child: Padding(
    padding: const EdgeInsets.only(
      top: 20,
      left: 30,
    ),
    child: Text(
      "যোগাযোগ",
      style: GoogleFonts.lato(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);

Widget contact (context, TextEditingController nameEditController, TextEditingController emailEditController, TextEditingController subjectEditConroller, TextEditingController messageBodyConroller){
return Container(
  width: MediaQuery.of(context).size.width,
  padding: EdgeInsets.all(25),
  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
    ),
    color: Color(0xFF8AC185),
  ),
  child: Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
   // crossAxisAlignment: CrossAxisAlignment.baseline,
    children:
    [
        Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[

        Expanded(
          child: CustomTextField(
            baseColor: Colors.black,
            borderColor: Colors.black,
            errorColor: Colors.yellow,
            controller: nameEditController,
            hint: "Name",
            inputType: TextInputType.text,

          ),
        ),
         Expanded(
           child: CustomTextField(
             baseColor: Colors.black,
             borderColor: Colors.black,
            errorColor: Colors.red,
            controller: emailEditController,
            hint: "Email",
            inputType: TextInputType.emailAddress,

        ),
         )
      ],
    ),
        CustomTextField(
          baseColor: Colors.black,
          borderColor: Colors.black,
        errorColor: Colors.red,
        controller: subjectEditConroller,
        hint: "Subject",
        inputType: TextInputType.text,
      ),
        CustomTextField(
          baseColor: Colors.black,
          borderColor: Colors.black,
        errorColor: Colors.red,
        controller: messageBodyConroller,
        hint: "Message body",
        minline: 1,
        maxline: 5,
        inputType: TextInputType.text,
      ),
      CustomButton(
        onPressed: (){
          SendMessage(nameEditController.text, emailEditController.text, subjectEditConroller.text, messageBodyConroller.text);
          print('SEND');
        },
      ),
  ]
  ),
);
}

Future<MessageSend> SendMessage(String name, String email, String subject, String mbody) async {
  print(name + email+subject+mbody);
  
  final response = await http.post(Uri.parse(GlobalAPI.sendMsg),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'subject': subject,
        'messagebody': mbody
      }),
  );
  if(response.statusCode ==200){
    return MessageSend.fromJson(jsonDecode(response.body));

  }
  else {
    throw Exception('Failed to Send message.');
  }


}
Widget vie = Container(
  width: double.infinity,
  padding: EdgeInsets.only(
    top: 25,
  ),
  margin: EdgeInsets.only(left: 10, right: 10),
  child: Column(
    children: <Widget>[
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
              ),
              width: 165,
              height: 165,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFF16181D),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Icon(FontAwesomeIcons.futbol, size: 18),
                  ),
                  Text(
                    "Club\nSport",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Président",
                    style: GoogleFonts.lato(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "2020-Présent",
                    style: GoogleFonts.lato(
                      fontSize: 11,
                      color: Color(0xFF6E717E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
              ),
              width: 165,
              height: 165,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFF16181D),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Icon(FontAwesomeIcons.portrait, size: 18),
                  ),
                  Text(
                    "Club Innovation",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Conseiller Général",
                    style: GoogleFonts.lato(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "2020-Présent",
                    style: GoogleFonts.lato(
                      fontSize: 11,
                      color: Color(0xFF6E717E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 25),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                width: 165,
                height: 165,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFF16181D),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Icon(FontAwesomeIcons.magic, size: 18),
                    ),
                    Text(
                      "Association Lit-Up",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Création Artistique",
                      style: GoogleFonts.lato(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "2019-2020",
                      style: GoogleFonts.lato(
                        fontSize: 11,
                        color: Color(0xFF6E717E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                width: 165,
                height: 165,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFF16181D),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Icon(FontAwesomeIcons.pencilRuler, size: 18),
                    ),
                    Text(
                      "Bde Révolution",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Chef Départ Media",
                      style: GoogleFonts.lato(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "2018-2019",
                      style: GoogleFonts.lato(
                        fontSize: 11,
                        color: Color(0xFF6E717E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);

CustomDailog(context,  String title, String descripiton , isZoom, String imgsrc){
  String dailogTitle =title.isNotEmpty? title.toString(): "No title found";
  String dailogDesc =descripiton.isNotEmpty? descripiton.toString(): "No Desc found";
  String img = imgsrc.isNotEmpty? imgsrc :"images/noimage.jpg";
  if(!isZoom) {
    return NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text(dailogTitle),
      content: Text(dailogDesc),
      actions: <Widget>[
        TextButton(
            child: Text("Okay"), onPressed: () => Navigator.pop(context)),
        //  TextButton(child: Text("Close"), onPressed: () => Navigator.pop(context)),
      ],
    ).show(context);
  }
  else {
   return ZoomDialog(
      zoomScale: 3,
      child: Container(
        width: MediaQuery.of(context).size.width*0.6,
        height: MediaQuery.of(context).size.height*0.6,

        child: Column(
          children: [
            Text(dailogTitle),
            Divider(),
          Image.network(img,
          fit: BoxFit.fill,
          height: 200.0,
          width: 200.0,),
            Text(dailogDesc),



          ],
        ),
        color: Colors.black54,
        padding: EdgeInsets.all(20),
      ),
    ).show(context);
  }
}
