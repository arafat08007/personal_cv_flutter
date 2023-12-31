import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Nazrul_Islam_mollah/widget/CustomTextFeild.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';


import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ndialog/ndialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'controller/home_controller.dart';
import 'package:get/get.dart';
import './controller/API.dart';

import 'package:http/http.dart' as http;
//model
import 'model/messageModel.dart';
import 'widget/CustomButton.dart';
import 'controller/LocalLanguageController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);


  // Fetch content from the json file

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: Locale('en','US'),
      home: HomePage(),
    );
  }
}



class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  CarouselController buttonCarouselController = CarouselController();
  TextEditingController nameEditController = TextEditingController();
  TextEditingController emailEditController = TextEditingController();
  TextEditingController subjectEditController = TextEditingController();
  TextEditingController messageBodyEditController = TextEditingController();
   AnimationController Animcontroller;

  List _bioData =[];
  List _educationData = [];
  List _politicsData = [];
  List _timelineData = [];
  List _socialActData = [];
  List _postData = [];
  List _qouteData   = [];
  List _imagesData = [];
  List _missionData = [] ;
  final List locale =[
    {'name':'ENGLISH','locale': Locale('en','US')},
    {'name':'বাংলা','locale': Locale('bn','BD')},
  ];
  var localelang;
  final dio = Dio();
  //fb page feed
  String fbPageId = "";
  String fbAccessTockent = "";
  String fbAppId = "2076096689448739";
 // bool _isLoading = true;
  //progressindicatior
   ValueNotifier<double> valueNotifier;

  int keyForRepaint = 0;
  // Fetch content from the json file
  Future<void> readBioJson(String localName) async {
    var edata;
    print('Reading bio data, please wait...');
    _educationData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res = await http.get(Uri.parse( localName == "eng" ? GlobalAPI.bioData : GlobalAPI.bioDataBN));
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

  Future<void> readQuoteJson(String localName) async {
    var edata;
    print('Reading quote data, please wait...');
    _qouteData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res =      await http.get(Uri.parse( localName == "eng" ? GlobalAPI.quoteData : GlobalAPI.quoteDataBN));
      //await http.get(Uri.parse(GlobalAPI.quoteData));
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
  Future<void> readMissionJson(String localName) async {
    var edata;
    print('Reading missions data, please wait...');
    _missionData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res = await http.get(Uri.parse( localName == "eng" ? GlobalAPI.missionData : GlobalAPI.missionDataBN));
      //await http.get(Uri.parse(GlobalAPI.missionData));
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

  Future<void> readEducationJson(String localName) async {
    var edata;
    print('Reading Education data, please wait...');
    _educationData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res =     await http.get(Uri.parse( localName == "eng" ? GlobalAPI.educationData : GlobalAPI.educationDataBN));
      // await http.get(Uri.parse(GlobalAPI.educationData));
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

  Future<void> readpoliticJson(String localName) async {
    var edata;
    print('Reading political data, please wait...');
    _politicsData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res =  await http.get(Uri.parse( localName == "eng" ? GlobalAPI.politicData : GlobalAPI.politicDataBN));
      //await http.get(Uri.parse(GlobalAPI.politicData));
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

  Future<void> readsocialJson(String localName) async {
    var edata;
    print('Reading missions data, please wait...');
    _socialActData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res = await http.get(Uri.parse( localName == "eng" ? GlobalAPI.activityData : GlobalAPI.activityDataBN));
      //await http.get(Uri.parse(GlobalAPI.activityData));
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

  Future<void> readTimelineJson(String localName) async {
    var edata;
    print('Reading Timeline data, please wait...');
    _timelineData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res =     await http.get(Uri.parse( localName == "eng" ? GlobalAPI.timelineData : GlobalAPI.timelineDataBN));
      //await http.get(Uri.parse(GlobalAPI.timelineData));
      if (res.statusCode == 200) {
        edata = await json.decode(res.body);
        print ('Timeline api response/n') ;
        print (edata);
      }
      setState(() {
        _timelineData = edata["timelines"];
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

  Future<void> readGalleryJson(String localName) async {
    var edata;
    print('Reading photo data, please wait...');
    _imagesData.clear();
    try {
      // String response = await rootBundle.loadString('data/education.json');
      http.Response res = await http.get(Uri.parse( localName == "eng" ? GlobalAPI.photoData : GlobalAPI.photoDataBN));
      //await http.get(Uri.parse(GlobalAPI.photoData));
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
  //languge
  buildLanguageDialog(BuildContext context){
    showDialog(context: context,
        builder: (builder){
          return StatefulBuilder(builder: (context , setState) {
            return  AlertDialog(
              title: Text('Choose Your Language'),
              content: Container(
                width: double.maxFinite,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
                          print("local name "+locale[index]['name']);
                          setState(() {
                            updateLanguage(locale[index]['locale']);
                            readBioJson(
                                locale[index]['name'] == "বাংলা" ?
                                    "bn" : "eng"
                            );
                            readQuoteJson (locale[index]['name'] == "বাংলা" ?
                            "bn" : "eng");
                            readMissionJson(locale[index]['name'] == "বাংলা" ?
                            "bn" : "eng");
                            readEducationJson(locale[index]['name'] == "বাংলা" ?
                            "bn" : "eng");
                            readpoliticJson(locale[index]['name'] == "বাংলা" ?
                            "bn" : "eng");
                            readsocialJson(locale[index]['name'] == "বাংলা" ?
                            "bn" : "eng");
                            readTimelineJson(locale[index]['name'] == "বাংলা" ?
                            "bn" : "eng");
                            readGalleryJson(locale[index]['name'] == "বাংলা" ?
                            "bn" : "eng");
                          });
                        },),
                      );
                    }, separatorBuilder: (context,index){
                  return Divider(
                    color: Colors.blue,
                  );
                }, itemCount: locale.length
                ),
              ),
            );
          }) ;

        }
    );
  }
  updateLanguage(Locale locale){
    print('Updating language  with \t ${locale}');
    Get.back();
    Get.updateLocale(locale);
   
  }

  @override
  void initState() {
    // TODO: implement initState
    Animcontroller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    Animcontroller.repeat(reverse: true);


    readBioJson("eng");
    readQuoteJson ("eng");
    readMissionJson("eng");
    readEducationJson("eng");
    readpoliticJson("eng");
    readsocialJson("eng");
    readTimelineJson("eng");
    readGalleryJson("eng");
   // readPostJson();

    valueNotifier = ValueNotifier(0.0);
    Timer(Duration(seconds: 7), () {
      setState(() {
       // Get.updateLocale(localelang)    ;
        //_isLoading = false;
      });
    });
    super.initState();
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
    Animcontroller.dispose();
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
        backgroundColor:Color(0XFFD2F0EA), // Color(0xFF023020),
        actions: <Widget>[
          //fb
          IconButton(
            icon: Icon(
              Icons.translate,
              color: Colors.black,
            ),
            onPressed: () {
              print('translation is ongoing ....');
              buildLanguageDialog(context) ;

              // readEducationJson();
              // do something
            },
          ),
          IconButton(
            icon: Icon(
              Icons.facebook_outlined,
              color: Colors.black,
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
              FontAwesome.youtube,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
              print('Click whatsapp');
              openWebsite("https://www.youtube.com/@nazrulislammollah14");
              //openWhatsapp("+8801717998754", "Hello Vi");
            },
          ),
          IconButton(
            icon: Icon(
              FontAwesome.globe,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
              print('Click on open website');
              openWebsite("https://nazrulislammollah.com/en");
            },
          )
        ],
      ),
    //  backgroundColor: Color(0xFF023020),
      backgroundColor: Color (0XFFD2F0EA),
      body:  SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
         //  child: _isLoading ? Align(
         // alignment: Alignment.center,
         //    child: CircularPercentIndicator(
         //      radius: 120.0,
         //      lineWidth: 13.0,
         //      animation: true,
         //      animationDuration: 1200,
         //      percent: 1.0,
         //      center: new Text(
         //        "100.0%",
         //        style:
         //        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
         //      ),
         //      footer: new Text(
         //        "Loading data, please wait...",
         //        style:
         //        new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
         //      ),
         //      circularStrokeCap: CircularStrokeCap.round,
         //      progressColor: Colors.purple,
         //    ),
         //  ):
         child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              profileName(),
              profileTitle(context),
              BioDesc (_bioData,context),
              Divider(
                indent: 50,
                endIndent: 50,
                thickness: 0.3,
                color: Colors.grey,
              ),
              Qoute(_qouteData, context),
              Divider(
                indent: 50,
                endIndent: 50,
                thickness: 0.3,
                color: Colors.grey,
              ),
              MissionVisionTtile(context),
              MissionVision(_missionData,context),
              Divider(
                indent: 50,
                endIndent: 50,
                thickness: 0.5,
                color: Colors.grey,
              ),
              educationTitle(context),
              education(_educationData, context),
              formationTitle(context),
              politics(_politicsData, context),
              competenceTitle(context),
              SocialActvites(_socialActData, context),
              //formation,
              TimelineTitle (context),
              TimelineWidget(_timelineData, context),
              PhotoGalleryTitle (context),
              galleryPicture(_imagesData, context),
              //langueTitle,
              //langue,
              contatcTitle(context),
              contact(context, nameEditController, emailEditController, subjectEditController, messageBodyEditController ),
            ],
          ),
        ),
      ),
    );
  }

  void openFb() async {
    final Uri url = Uri.parse('https://www.facebook.com/Dhaka14NazrulIslamMollah');
    String fburl=   'https://www.facebook.com/Dhaka14NazrulIslamMollah';
    if (await canLaunchUrl(Uri.parse(fburl))) {
      await launchUrl(Uri.parse(fburl),
          mode: LaunchMode.externalApplication);
    }
      throw Exception('Could not launch $url');
    }


  void openWebsite(String s) async {
    final Uri url = Uri.parse(s);
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

  Widget profileTitle (BuildContext context){
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 30,
          ),
          child:
          Row(
            children: [
              Icon(Icons.info, color:Color(0XFF1D3C78), size: 20),
              Text("\t"+"bioTitle".tr,
                style: GoogleFonts.lato(
                  fontSize: 22,
                  color:Color(0XFF1D3C78),
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )

        //   RichText(
        //     text: TextSpan(
        //       children: [
        //         WidgetSpan(child: Icon(Icons.info, color:Color(0XFF002147), size: 20),),
        //         TextSpan( text:"\t hello".tr,
        //       style: GoogleFonts.lato(
        //         fontSize: 22,
        //         color: Color(0XFF002147),
        //         fontWeight: FontWeight.bold,
        //       )
        //
        //     ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget profileName(){
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: 200,
              height: 200,

              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 48, // Image radius
                backgroundImage: AssetImage('./images/profile.png'),
              ),
            ),
          ),
          Divider(
            indent: 50,
            endIndent: 50,
            thickness: 0.5,
            height: 50,
            color: Colors.grey,
          ),
          Text(
            "person_name".tr,
            style: GoogleFonts.lato(
              fontSize: 26,
              color:  Color(0XFF1D3C78),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5,)    ,
          Text(
            "person_title".tr,
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Color(0XFF1D3C78),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget BioDesc (_BioDesc,context) {
    return  _BioDesc.isNotEmpty?
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:  Color(0XFFEBFFF3),
      ),
      child: (
          Text(_BioDesc[0]["description"].toString().trim(), textAlign: TextAlign.justify, style: TextStyle(fontSize: 14, height: 1.5 , color: Color(0XFF1D3C78)), )
      ),
    ): CircularProgressIndicator(
      value: Animcontroller.value,
    );
    
  }
  Widget Qoute(_qouteData, context) {
    final homeController = Get.find<HomeController>();

    return _qouteData.isNotEmpty
        ?
    Column(
      children: [
        Container(
          // color: Color(0xFF023020),
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
                  // decoration: BoxDecoration(
                  //   color: Color(0xFF023020),
                  // ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "\"${_qouteData[index]['description'].toString().trim()}\"",
                        // The post description
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0XFF1D3C78),
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,

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
                activeColor: Colors.grey // The active dot color
            ),
          ),
        ),
      ],
    )
        : CircularProgressIndicator(
      value: Animcontroller.value,
    );
  }
  Widget MissionVision (_missionData , context) {
    return  _missionData.isNotEmpty?
    Container(
      padding: EdgeInsets.only(left: 15, bottom: 15, right: 15),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(_missionData[0]["description"].toString().trim(),
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: Color(0XFF1D3C78),
              )),

        ],
      ),
    )
        :
    CircularProgressIndicator(
      value: Animcontroller.value,
    );       }
  Widget education(_educationData, context) {
    return _educationData.isNotEmpty
        ?
    ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: _educationData.length,
      itemBuilder: (context, index) {
        return Container(
          color: Color(0XFFEBFFF3),
          margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(_educationData[index]["year"].toString().trim()+"\t|\t"+_educationData[index]["title"].toString().trim(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0XFF1D3C78),)),
              ),
              SizedBox(height: 5,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(_educationData[index]["description"].toString().trim(),
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Color(0XFF1D3C78),)),
              ),

            ],
          ),
        );
      },
    )
        : CircularProgressIndicator(
      value: Animcontroller.value,
    );

  }
  Widget politics(_politicsData, context) {
    return _politicsData.isNotEmpty
        ? ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: _politicsData.length,
          itemBuilder: (context, index) {
            return Container(
              color: Color(0XFFEBFFF3),
              margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(_politicsData[index]["year"].toString().trim()+"\t|\t"+_politicsData[index]["title"].toString().trim(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Color(0XFF1D3C78),)),
                  ),
                  SizedBox(height: 5,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(_politicsData[index]["description"].toString().trim(),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Color(0XFF1D3C78),)),
                  ),

                ],
              ),
            );
          },
        )
        : CircularProgressIndicator(
      value: Animcontroller.value,
    );
  }
  Widget SocialActvites(_socialActData, context) {
    return _socialActData.isNotEmpty
        ? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(            //     width: 300,
                height: MediaQuery.of(context).size.height*0.58,
                // margin: EdgeInsets.only(right: 15),

                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: _socialActData.length,
                  itemBuilder: (context, index) {
                    return Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0XFFEBFFF3),
                        ),

                        // color: Colors.white70,
                        child: Column(children: <Widget>[

                          Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),

                                ),

                            child: CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 2000),

                             // width: MediaQuery.of(context).size.width*0.7,
                              fit: BoxFit.fill,
                              imageUrl:
                              _socialActData[index]["image"].toString(),
                              placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                          SizedBox(height: 10,),


                          SizedBox(
                            width:  MediaQuery.of(context).size.width*0.6,
                            child: Text(
                              _socialActData[index]["title"].toString().trim(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  color: Color(0XFF062B5B)),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              maxLines: 5,
                              softWrap: true,
                            ),
                          ),
                          Divider(
                            indent: 50,
                            endIndent: 50,
                            thickness: 0.3,
                            color: Colors.grey,
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              getFormatedDate(_socialActData[index]["timestamp"]
                                  .toString().trim()),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.grey),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                          Divider(
                            indent: 50,
                            endIndent: 50,
                            thickness: 0.3,
                            color: Colors.grey,
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.65,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5,top: 3,right: 5,bottom: 3),
                              child: Text(
                                _socialActData[index]["description"].toString().trim(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0XFF062B5B)),
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.clip,
                                maxLines: 5,
                                softWrap: true,
                              ),
                            ),
                          ),
                         
                        ]));
                  },
                ),
              ),
            ],
          ),
        )
        :
    CircularProgressIndicator(
      value: Animcontroller.value,
    );
  }
  Widget TimelineWidget(_timelineData, context) {
    //print('Timeline data count >>>>'+_timelineData.length)   ;

    return _timelineData.isNotEmpty
        ? SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            //   padding: EdgeInsets.all(value),//     width: 300,
            height: MediaQuery.of(context).size.height*0.40,
            width: MediaQuery.of(context).size.width*0.9,

            // margin: EdgeInsets.only(right: 15),

            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: _timelineData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left:5, right: 10, top:10),
                  padding: EdgeInsets.only(left: 10, right: 10, top:35),
                  decoration: BoxDecoration(
                    color: Color(0XFFEBFFF3) ,
                    borderRadius: BorderRadius.circular(10),

                  ),

                  child: Column(children: <Widget>[
                    // _timelineData[index]["icon"].toString()
                    //Icon(FontAwesome._timelineData[index]["icon"].toString()),
                    Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.calendar_month_outlined, size: 36, color:Color(0XFF062B5B).withOpacity(0.5),)),
                    Align(
                      alignment: Alignment.center,
                      child:
                      Text(
                        _timelineData[index]["year"]
                            .toString().trim(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32 ,

                            color: Colors.grey),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                    Divider(
                      height: 5,
                      indent: 50,
                      endIndent: 50,
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Text(
                        _timelineData[index]["title"].toString().trim(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Color(0XFF062B5B)),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        maxLines: 5,
                        softWrap: true,
                      ),
                    ),
                    Divider(
                      height: 5,
                      indent: 50,
                      endIndent: 50,
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width:   MediaQuery.of(context).size.width*0.5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5,top: 3,right: 5,bottom: 3),
                        child: Text(
                          _timelineData[index]["description"].toString().trim(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0XFF062B5B)),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          softWrap: true,
                        ),
                      ),
                    )
                  ]),
                );
              },
            ),
          ),
        ],
      ),
    )
        :
    CircularProgressIndicator(

      //value: Animcontroller.value,
    );
    //childHorizontal: HorizontalTimeline();
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
        : CircularProgressIndicator(
      value: Animcontroller.value,
    );
  }
}




Widget MissionVisionTtile (BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 30,
        bottom: 10,
      ),
      child:
      RichText(
        text: TextSpan(
          children: [
            WidgetSpan(child: Icon(
                Icons.remove_red_eye_sharp, color: Color(0XFF1D3C78),
                size: 24),),
            // TextSpan( text:"\t রুপকল্প ও অভিলক্ষ্য",
            //     style: GoogleFonts.lato(
            //       fontSize: 20,
            //       color: Color(0XFF002147),
            //       fontWeight: FontWeight.bold,
            //     )
            //
            // ),
            TextSpan(text: "\t"+"missionTitle".tr,
                style: GoogleFonts.lato(
                  fontSize: 22,
                  color: Color(0XFF1D3C78),
                  fontWeight: FontWeight.bold,
                )

            ),
          ],
        ),
      ),
    ),
  );
}




// Widget politics(_politicsData, context) {
//   return _politicsData.isNotEmpty
//       ? Container(
//     padding: EdgeInsets.only(left:15,right: 15),
//     width: MediaQuery.of(context).size.width,
//     height:  MediaQuery.of(context).size.height*0.3,
//     child: ListView.builder(
//       shrinkWrap: true,
//       physics: BouncingScrollPhysics(),
//       itemCount: _politicsData.length,
//       itemBuilder: (context, index) {
//         return Card(
//           color: Color(0XFFEBFFF3),
//           elevation: 0,
//           margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
//           child: ListTile(
//             leading: Text(_politicsData[index]["year"].toString().trim()+'\t |',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 24,
//                     color: Color(0XFF1D3C78))),
//             title: Text(_politicsData[index]["title"].toString().trim(),
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                     color: Color(0XFF1D3C78),)),
//             subtitle: Text(_politicsData[index]["description"].toString().trim(),
//                 style: TextStyle(
//                     fontWeight: FontWeight.normal,
//                     fontSize: 16,
//                     color: Color(0XFF1D3C78),)),
//           ),
//         );
//       },
//     ),
//   )
//       : Container(
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.all(20),
//       margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Color(0xFF16181D),
//       ),
//       child: Text('No Data found!',
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//               color: Colors.redAccent)));
// }


  getFormatedDate(_date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('MMMM, yyyy');
    return outputFormat.format(inputDate);
  }


  Widget name = Container(
    child: Column(
      children: <Widget>[
        Center(
          child: Container(
            width: 150,
            height: 150,
            // decoration: BoxDecoration(
            //   gradient: const LinearGradient(
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //     colors: [ Color(0xFF846AFF), Color(0xFF755EE8), Colors.purpleAccent,Colors.amber,],
            //   ),
            //   borderRadius: BorderRadius.circular(70),
            // ),
            child: CircleAvatar(
              backgroundColor:  Color(0XFFEBFFF3),
              radius: 48, // Image radius
              backgroundImage: AssetImage('./images/profile.png'),
            ),
          ),
        ),
        Divider(
          indent: 50,
          endIndent: 50,
          thickness: 0.3,
          color: Colors.grey,
        ),
        Text(
          "person_name".tr,
          style: GoogleFonts.lato(
            fontSize: 28,
            color:  Color(0XFF002147),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "person_title".tr,
          style: GoogleFonts.lato(
            fontSize: 16,
            color:  Color(0XFF002147),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );




Widget educationTitle (BuildContext context){
  return
Container(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 30,
        bottom: 10,
      ),
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(child: Icon(Icons.school, color:Color(0XFF1D3C78), size: 24),),

            TextSpan( text:"\t"+"educationTitle".tr,
                style: GoogleFonts.lato(
                  fontSize: 22,
                  color: Color(0XFF1D3C78),
                  fontWeight: FontWeight.bold,
                )

            ),
          ],
        ),
      ),
    )
);
}
  Widget formationTitle(BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 30,
        bottom: 10,
      ),
      child:
      RichText(
        text: TextSpan(
          children: [
            WidgetSpan(child: Icon(Icons.business_sharp, color:Color(0XFF1D3C78), size: 24),),
            // TextSpan( text:"\t রাজনীতি",
            //     style: GoogleFonts.lato(
            //       fontSize: 20,
            //       color: Color(0XFF002147),
            //       fontWeight: FontWeight.bold,
            //     )
            //
            // ),
            TextSpan( text:"\t"+"politicsTitle".tr,
                style: GoogleFonts.lato(
                  fontSize: 22,
                  color:Color(0XFF1D3C78),
                  fontWeight: FontWeight.bold,
                )

            ),
          ],
        ),
      ),
    ),
  );
}




  //সামাজিক কর্মকান্ড
  Widget competenceTitle (BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(
          top: 20,
          left: 30,
          bottom: 10
      ),
      child:
      RichText(
        text: TextSpan(
          children: [
            WidgetSpan(child: Icon(Icons.local_activity, color:Color(0XFF1D3C78), size: 24),),
            // TextSpan( text:"\t সামাজিক কর্মকান্ড",
            //     style: GoogleFonts.lato(
            //       fontSize: 20,
            //       color: Color(0XFF002147),
            //       fontWeight: FontWeight.bold,
            //     )
            //
            // ),
            TextSpan( text:"\t"+"socialactivityTitle".tr,
                style: GoogleFonts.lato(
                  fontSize: 22,
                  color: Color(0XFF1D3C78),
                  fontWeight: FontWeight.bold,
                )

            ),
          ],
        ),
      ),
    ),
  ); }



    Widget TimelineTitle (BuildContext context) {
      return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 30,
          bottom: 10,
        ),
        child:
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(child: Icon(Icons.timelapse_rounded, color:Color(0XFF1D3C78), size: 24),),

              TextSpan( text:"\t"+"timelineTitle".tr,
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    color: Color(0XFF1D3C78),
                    fontWeight: FontWeight.bold,
                  )

              ),
            ],
          ),
        ),
      ),
    );
}



    Widget PhotoGalleryTitle (BuildContext context) {
      return Container(
        alignment: Alignment.centerLeft,
         child: Padding(
        padding: const EdgeInsets.only(
            top: 20,
            left: 30,
            bottom: 10
        ),
        child:
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(child: Icon(Icons.photo_album, color:Color(0XFF1D3C78), size: 24),),

              TextSpan( text:"\t" +"photogalleryTitle".tr,
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    color: Color(0XFF1D3C78),
                    fontWeight: FontWeight.bold,
                  )

              ),
            ],
          ),
        ),
      ),
    );
}


    Widget contatcTitle (BuildContext context){
  return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 30,
          bottom: 10,
        ),
        child:
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(child: Icon(Icons.contact_phone_rounded, color:Color(0XFF1D3C78), size: 24),),

              TextSpan( text:"\t"+"contactTitle".tr,
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    color: Color(0XFF1D3C78),
                    fontWeight: FontWeight.bold,
                  )

              ),
            ],
          ),
        ),
      ),
    );
}

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
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ Color(0xFF44A08D), Color(0xFF093637)],
          ),
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
                      baseColor: Colors.white,
                      borderColor: Colors.white,
                      errorColor: Colors.yellow,
                      controller: nameEditController,
                      hint: "msgName".tr,
                      fsize: 12.0,
                      inputType: TextInputType.text,

                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      baseColor: Colors.white,
                      borderColor: Colors.white,
                      errorColor: Colors.red,
                      controller: emailEditController,
                      hint: "msgMail".tr,
                      fsize: 12.0,
                      inputType: TextInputType.emailAddress,

                    ),
                  )
                ],
              ),
              CustomTextField(
                baseColor: Colors.white,
                borderColor: Colors.white,
                errorColor: Colors.red,
                controller: subjectEditConroller,
                hint: "msgSubject".tr,
                fsize: 12.0,
                inputType: TextInputType.text,
              ),
              CustomTextField(
                baseColor: Colors.white,
                borderColor: Colors.white,
                errorColor: Colors.red,
                controller: messageBodyConroller,
                hint: "msg".tr,
                fsize: 12.0,
                minline: 1,
                maxline: 5,
                inputType: TextInputType.text,
              ),
              SizedBox(height: 10,),

              CustomButton(
                buttonlebel: "msgBtn".tr,
                onPressed: (){
                 //SendMessage(nameEditController.text, emailEditController.text, subjectEditConroller.text, messageBodyConroller.text);
                  SendMail('petronojrul@gmail.com',nameEditController.text, emailEditController.text, subjectEditConroller.text, messageBodyConroller.text, context);
                  print('SEND');
                },
              ),
              Text(
                  "msgInstruction".tr,
                style: GoogleFonts.lato(
                  fontSize: 10,
                  color:  Color(0XFFFFFFFF),
                  
                ),
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

SendMail(String toMailId, String name, String email, String subject, String mbody, BuildContext context)  async {
  print(name + email + subject + mbody);

  var url = 'mailto:$toMailId?subject=$subject&body=$mbody';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
   

    CustomDailog(context,  String title, String descripiton , isZoom, String imgsrc){
      String dailogTitle =title.isNotEmpty? title.toString(): "TitleNotFound".tr;
      String dailogDesc =descripiton.isNotEmpty? descripiton.toString(): "DescNotFound".tr;
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
                Text(dailogTitle, style: TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center,),
                Divider(),
                Image.network(img,
                  fit: BoxFit.fill,
                  height: 200.0,
                  width: 200.0,),
                Divider(height: 20,),
                Text(dailogDesc,style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center,),



              ],
            ),
            color: Colors.black54,
            padding: EdgeInsets.all(20),
          ),
        ).show(context);
      }
    }


