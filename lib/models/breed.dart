class Breed {
  final int id;
  final String name;
  String group;
  final String bredFor;
  final String height;
  final String weight;
  final String origin;
  final String lifeExpectancy;
  final String temperament;

  Breed(
      {this.origin,
      this.lifeExpectancy,
      this.temperament,
      this.bredFor,
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
        origin: json['origin'],
        lifeExpectancy: json['life_span'],
        temperament: json['temperament'],
        weight: json['weight']['metric'],
        height: json['height']['metric'],
      );
}
