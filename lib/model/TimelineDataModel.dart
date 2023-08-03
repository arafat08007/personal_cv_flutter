class TimelineData {
  List<Timeline> timelines;

  TimelineData({
    this.timelines,
  });

}

class Timeline {
  String sl;
  String year;
  String title;
  String description;
  String icon;
  String iconLabel;
  String isActive;
  DateTime timestamp;

  Timeline({
    this.sl,
    this.year,
    this.title,
    this.description,
    this.icon,
    this.iconLabel,
    this.isActive,
    this.timestamp,
  });

}
