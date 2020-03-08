class Breed {
  final int id;
  final String name;
  String group;
  final String bredFor;
  final String height;
  final String weight;

  Breed(
      {this.bredFor,
      this.group,
      this.id,
      this.name,
      this.height,
      this.weight}) {
    if (group == null || group.isEmpty) {
      this.group = "Other";
    }
  }

  factory Breed.fromJson(Map<String, dynamic> json) => Breed(
      bredFor: json['bred_for'],
      id: json['id'],
      name: json['name'],
      group: json['breed_group'],
      weight: json['weight']['metric'],
      height: json['height']['metric']);
}
