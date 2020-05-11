class Dog {
  final String id;
  final String name;
  final String breed;
  final String sex;
  final String picUrl;
  final String owner;

  Dog(this.name, this.id,
      {this.breed = '', this.sex = '', this.picUrl = '', this.owner = ''});

  factory Dog.fromJson(Map<String, dynamic> json) =>
      Dog(json['name'], json['id'],
          owner: json['owner'],
          breed: json['breed'],
          sex: json['sex'],
          picUrl: json['picUrl']);
}
