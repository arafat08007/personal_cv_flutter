import 'dart:convert';
import 'dart:io';

//import 'package:flutter_fb_news/flutter_fb_news.dart';
import 'package:Nazrul_Islam_mollah/view/PhotGallery.dart';
import 'package:Nazrul_Islam_mollah/model/GlobalInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
//import 'package:lottie/lottie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';

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
      home:  HomePage(),

    );
  }
}

class HomePage extends StatefulWidget {
  HomePage ({Key key}) : super (key:key) ;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  CarouselController buttonCarouselController = CarouselController();
  List _educationData = [];
  List _politicsData = [];
  List _timelineData = [];
  List _socialActData =[];
  List _postData =[];

  //fb page feed
  String fbPageId ="";
  String fbAccessTockent ="";
  String fbAppId ="2076096689448739";
  
  
  // Fetch content from the json file
  Future<void> readEducationJson() async {
    print('Reading Education data, please wait...');
    _educationData.clear();
     String response = await rootBundle.loadString('data/education.json');
    final edata = await json.decode(response);
    print(edata.toString())  ;
    setState(() {
      _educationData = edata["education"];
    });
    print(_educationData.length);
  }
  Future<void> readpoliticJson() async {
    print('Reading Political data, please wait...');
    _politicsData.clear();
    String response = await rootBundle.loadString('data/politics.json');
    final edata = await json.decode(response);
    print(edata.toString())  ;
    setState(() {
      _politicsData = edata["politics"];
    });
    print(_politicsData.length);
  }
  Future<void> readsocialJson() async {
    print('Reading social activities data, please wait...');
    _socialActData.clear();
    String response = await rootBundle.loadString('data/socialact.json');
    final edata = await json.decode(response);
    print(edata.toString())  ;
    setState(() {
      _socialActData = edata["socialacts"];
    });
    print(_socialActData.length);
  }

  Future<void> readTimelineJson() async {
    print('Reading Timeline data, please wait...');
    _timelineData.clear();
    String response = await rootBundle.loadString('data/timelinedata.json');
    final edata = await json.decode(response);
    print(edata.toString())  ;
    setState(() {
      _timelineData = edata["timeline"];
    });
    print(_timelineData.toString());
  }
  Future<void> readPostJson() async {
    print('Reading post data, please wait...');
    _postData.clear();
    String response = await rootBundle.loadString('data/postData.json');
    final edata = await json.decode(response);
    print(edata.toString())  ;
    setState(() {
      _postData = edata["post"];
    });
    print(_postData.toString());
    
    

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    readEducationJson();
    readpoliticJson();
    readsocialJson();
    readTimelineJson();
    readPostJson();

    print("initState() called"+_educationData.toString());

    
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  Scaffold(
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
            ) ,
            IconButton(
            icon: Icon(
            Icons.whatsapp,
            color: Colors.white,
            ),
            onPressed: () {
            // do something
              print('Click whatsapp') ;
              openWhatsapp("+8801717998754", "Hello Vi")   ;
            },
            ) ,
            IconButton(
            icon: Icon(
            Icons.wordpress_rounded,
            color: Colors.white,
            ),
            onPressed: () {
            // do something
              print('Click on open website') ;
              openWebsite();
            },
            )
            ],
          ),
          backgroundColor: Color(0xFF023020),
     body: SingleChildScrollView(
       physics: BouncingScrollPhysics(),
       child: Column(
         children: <Widget>[
           SizedBox(height: 40),
           name,
           profilTitle,
           BioDesc,
           Divider( indent: 50,endIndent: 50, thickness: 0.3,color: Colors.white,),
           Qoute(_postData,context),
           Divider( indent: 50,endIndent: 50, thickness: 0.3,color: Colors.white,),
           MissionVision,
           educationTitle,
           education(_educationData, context),
           formationTitle,
           politics(_politicsData,context),
           competenceTitle,
           SocialActvites(_socialActData,context),
    //formation,
           TimelineTitle,
           TimelineWidget(_timelineData, context),
           PhotoGalleryTitle,
           Container(
             width: MediaQuery.of(context).size.width*0.9 ,
             height: 150,
             color: Colors.white,
             child: Text('NO GALLERY IMAGE FOUND'),
           ),
           //langueTitle,
           //langue,
           contatcTitle,
           contact,
         ],
       ),
     ),
   );
  }

  void openFb() async {
    final Uri url = Uri.parse('https://facebook.com');
    if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
    }
  }
  void openWebsite() async {
    final Uri url = Uri.parse('https://yourwebsite.com');
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
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(
            message)}"; // new line
      }
      else {
        print('platform' + Platform.operatingSystem);
        Fluttertoast.showToast(
            msg: "Unable to open whatsapp , either Whatsapp missing or permission denied",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }catch(e){
            print('Unable to load whatsapp\t'+e.toString()) ;
    }
  }

}
Widget  MissionVision = Container(
  padding: EdgeInsets.only(top:15),
  //alignment: Alignment.centerLeft,
  alignment: Alignment.topLeft,
  child: Align(
    alignment: Alignment.centerLeft,
    child: Column(
      children: [
        Text('মিশন ও ভিশন', textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Text('Mission Text',textAlign: TextAlign.left, style: TextStyle(color: Colors.white,)),
        Divider( indent: 50,endIndent: 50, thickness: 0.5,color: Colors.amber,),
        Text('Vision Text',textAlign: TextAlign.left, style: TextStyle(color: Colors.white,)),
      ],
    ),
  ),
);
 Widget Qoute (_postData,context) {
  return _postData.isNotEmpty?
  Container(
    color: Colors.white,
    height: MediaQuery.of(context).size.height*0.13,
   width: MediaQuery.of(context).size.width*0.9 ,
   child:  ListView.builder(
     shrinkWrap: true,
     physics: BouncingScrollPhysics(),
     scrollDirection:Axis.horizontal,
     itemCount: _postData.length,
     itemBuilder: (context, index) {
       return Column(
         children: [
           Text(_postData[index]["postDesc"]),
           Text(_postData[index]["postDateTime"]),
         ],
       );
     },
   ),

 ):Container(
    child: Text ('NO POST FOUND!'),
  );
 }

Widget name = Container(
  child: Column(
    children: <Widget>[
      Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Image(
            image: AssetImage('images/profilepic.jpg'),
            height: 100,
            width: 100,
          ),
        ),
      ),
      Divider( indent: 50,endIndent: 50, thickness: 0.3,color: Colors.white,),
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

Widget BioDesc = Container(
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

Widget education (_educationData, context) {
 return _educationData.isNotEmpty?
 Container(
   width: MediaQuery.of(context).size.width,
   height: 200,
   child:
   ListView.builder(
     shrinkWrap: true,
     physics: BouncingScrollPhysics(),
     itemCount: _educationData.length,
     itemBuilder: (context, index) {
       return Card(
         color: Colors.black54,
         margin: const EdgeInsets.only(top: 5,left: 10, right: 10),
         child: ListTile(
           leading: Text(_educationData[index]["passingYear"], style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.amber)),
           title: Text(_educationData[index]["educationLevel"],style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.amber)),
           subtitle: Text(_educationData[index]["instituteName"],style:TextStyle(fontWeight: FontWeight.bold,fontSize: 10, color: Colors.white)),
         ),
       );
     },
   ),
 )
     :Container(
     width: MediaQuery.of(context).size.width,
     padding: EdgeInsets.all(20),
     margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(20),
       color: Color(0xFF16181D),
     ),

     child: Text('No Data found!',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.redAccent))); ;
}
Widget politics (_politicsData, context) {
  return _politicsData.isNotEmpty?
  Container(
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
          margin: const EdgeInsets.only(top: 5,left: 10, right: 10),
          child: ListTile(
          leading: Text(_politicsData[index]["fromyear"], style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.amber)),
          title: Text(_politicsData[index]["level"],style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.amber)),
          subtitle: Text(_politicsData[index]["party"],style:TextStyle(fontWeight: FontWeight.bold,fontSize: 10, color: Colors.white)),
            ),
        );
      },
    ),
  )
      :
  Container(
    width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF16181D),
      ),

      child: Text('No Data found!',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.redAccent)));
}
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

Widget SocialActvites (_socialActData,context){
  return _socialActData.isNotEmpty?Container(
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
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
       //     width: 300,
            height: 200,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFF16181D),
            ),
            child:  ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: _socialActData.length,
              itemBuilder: (context, index) {
                return Card(
                  color:Color(0xFF16181D),
                  child: Column (
                      children: <Widget>[
                       Stack(
                  alignment: Alignment.center,
                  children: <Widget>[

                  Image.network(_socialActData[index]["imagesoruce"].toString(),
                          fit: BoxFit.fill,
                          errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                            return Text('404 Not Found!');
                          },
                        ),

                        Positioned(
                        bottom:1,

                          child: Align(
                            alignment: Alignment.center,
                            child: Text(_socialActData[index]["timestamp"].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                        )
                        ,
                       ]
                       ),
                        Divider(thickness: 0.3, color:Colors.amber, height: 5,),
                        SizedBox(
                          width:200,
                          child: Text(_socialActData[index]["title"].toString() ,style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: Colors.white), textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            maxLines: 5,
                            softWrap: true,

                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child:  Text(_socialActData[index]["description"].toString() ,style: TextStyle(fontWeight: FontWeight.w200, fontSize: 8, color: Colors.white), textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            maxLines: 5,
                            softWrap: true,

                          ),
                        )

                      ]
                  )

                );
              },
            ),
          ),
        ],
      ),
    ),
  ): Container(
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
Widget TimelineWidget (_timelineData, context){
  return _timelineData.isNotEmpty?
  Container(
    width: MediaQuery.of(context).size.width*0.9,
    // height: 240,
     child:  //HorizontalTimeline()
         Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         TimelineTile(
           alignment: TimelineAlign.center,
           isFirst: true,
           indicatorStyle: IndicatorStyle(
             width: 40,
             color: Colors.purple,
             padding: const EdgeInsets.all(8),
             iconStyle: IconStyle(
               color: Colors.white,
               iconData: Icons.insert_emoticon,
             ),
           ),
           startChild: Container(
             constraints: const BoxConstraints(
               minHeight: 120,
             ),
             color: Colors.amberAccent,
           ),
         ),
         TimelineTile(
           alignment: TimelineAlign.center,
           isLast: true,
           indicatorStyle: IndicatorStyle(
             width: 30,
             color: Colors.red,
             indicatorXY: 0.7,
             iconStyle: IconStyle(
               color: Colors.white,
               iconData: Icons.thumb_up,
             ),
           ),
           endChild: Container(
             constraints: const BoxConstraints(
               minHeight: 80,
             ),
             color: Colors.lightGreenAccent,
           ),
         ),

       ],
     )


  ):Container(child: Text('NO DATA FOUND'),) ;
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

Widget contact = Container(
  width: 1000,
  padding: EdgeInsets.all(25),
  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
    ),
    color: Color(0xFF8AC185),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Adresse",
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(Globalinfo.address,
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    color: Color(0xFF4E634E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
             // margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Phone",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Globalinfo.phonenumber,
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      color: Color(0xFF4E634E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
            //  margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Email",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Globalinfo.email,
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      color: Color(0xFF4E634E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Container(
        width: 150,
        height: 150,
        child: Lottie.asset('anim/scanning.json'),
      ),
    ],
  ),
);
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
