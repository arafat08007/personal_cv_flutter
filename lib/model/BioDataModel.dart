class BioData {
  List<Bio> bios;

  BioData({
    this.bios,
  });
}

class Bio {
  String sl;
  String title;
  String description;
  String isActive;
  DateTime timestamp;

  Bio({
    this.sl,
    this.title,
    this.description,
    this.isActive,
    this.timestamp,
  });
}
