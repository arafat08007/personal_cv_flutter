class PoliticsData {
  List<Politic> politics;

  PoliticsData({
    this.politics,
  });

}

class Politic {
  String sl;
  String title;
  String description;
  String isActive;
  DateTime timestamp;

  Politic({
    this.sl,
    this.title,
    this.description,
    this.isActive,
    this.timestamp,
  });

}
