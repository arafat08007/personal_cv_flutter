class MissionData {
    List<Mission> missions;

    MissionData({
        this.missions,
    });

}

class Mission {
    String sl;
    String title;
    String description;
    String isActive;
    DateTime timestamp;

    Mission({
        this.sl,
        this.title,
        this.description,
        this.isActive,
        this.timestamp,
    });

}
