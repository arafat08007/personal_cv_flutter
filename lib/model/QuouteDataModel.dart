class QuouteData {
  List<Quote> quotes;

  QuouteData({
    this.quotes,
  });

}

class Quote {
  String sl;
  String title;
  String description;
  String isActive;
  DateTime timestamp;

  Quote({
    this.sl,
    this.title,
    this.description,
    this.isActive,
    this.timestamp,
  });

}
