class PhotoData {
  List<Photo> photos;

  PhotoData({
    this.photos,
  });

}

class Photo {
  String sl;
  String title;
  String image;
  String isActive;
  DateTime timestamp;

  Photo({
    this.sl,
    this.title,
    this.image,
    this.isActive,
    this.timestamp,
  });

}
