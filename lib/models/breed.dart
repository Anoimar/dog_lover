class Breed {
  final int id;
  final String name;
  String group;

  Breed({this.group, this.id, this.name}) {
    if (group == null || group.isEmpty) {
      this.group = "Other";
    }
  }
}
