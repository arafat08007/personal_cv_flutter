class ActivityData {
  List<Activity> activities;

  ActivityData({
    this.activities,
  });

}

class Activity {
  String sl;
  String title;
  String description;
  String image;
  String isActive;
  DateTime timestamp;

  Activity({
    this.sl,
    this.title,
    this.description,
    this.image,
    this.isActive,
    this.timestamp,
  });

}
