class EducationData {
  List<Education> educations;

  EducationData({
    this.educations,
  });

}

class Education {
  String sl;
  String title;
  String description;
  String isActive;
  DateTime timestamp;

  Education({
    this.sl,
    this.title,
    this.description,
    this.isActive,
    this.timestamp,
  });

}
