import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/GalleryImage.dart';
class PhotGallery extends StatefulWidget {
  const PhotGallery({Key key}) : super(key: key);

  @override
  State<PhotGallery> createState() => _PhotGalleryState();
}

class _PhotGalleryState extends State<PhotGallery> {
  static List<ImageItem> myGallery = [
    ImageItem(
        "Demo image", "July, 2023","Image description", "https://images.unsplash.com/photo-1593439147804-c6c7656530ae?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzUzfHxwaXhlbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
    ) ,
    ImageItem("Apple", "Aug, 2023"," Amarseba IOS app already launched! Take your ones", "https://images.unsplash.com/photo-1563642421748-5047b6585a4a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTY2fHxwaXhlbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
  
  ];
  bool isClick = false;
  print(myGallery) ;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
       height: MediaQuery.of(context).size.height*0.5,
       child: GridView.count(
          childAspectRatio: 1,
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: myGallery.map((data) {
            return InkWell(
              onTap: (){
                setState(() {
                  isClick = true;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isClick ? Text(data.imageDesc,) : null,
                  Image.asset(data.imageUrl, width: !isClick ? 100 : double.infinity,), //I'll not use Expanded
                  SizedBox(height: MediaQuery.of(context).size.height*0.2,) ,
                  isClick ? Text(data.imageName,) : null, //if null unexpected use dummy SizedBox or Container.
                ],
              ),
            );

          }).toList(),
        )

    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
