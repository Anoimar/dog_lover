class Dog {
  final int id;
  final String name;
  final String breed;
  final String sex;
  final String picUrl;
  final String owner;
  final bool verified;
  final String description;

  //const
  static const String keyName = "name";
  static const String keyId = "dogId";
  static const String keyOwner = "owner";
  static const String keyBreed = "breed";
  static const String keySex = "sex";
  static const String keyDescription = "description";
  static const String keyPicUrl = "picUrl";
  static const String keyVerified = "verified";

  Dog(this.name, this.id,
      {this.breed = '',
      this.sex = '',
      this.picUrl = '',
      this.owner = '',
      this.description = '',
      this.verified = false});

  factory Dog.preparePicData(String name, String breed, String description) =>
      Dog(name, -1, breed: breed, description: description);

  factory Dog.fromJson(Map<String, dynamic> json) =>
      Dog(json[keyName], json[keyId],
          owner: json[keyOwner],
          breed: json[keyBreed],
          sex: json[keySex],
          description: json[keyDescription],
          verified: json[keyVerified],
          picUrl: json[keyPicUrl]);
}
