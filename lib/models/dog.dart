class Dog {
  final String id;
  final String name;
  final String breed;
  final String story;
  final String picUrl;
  final String owner;

  Dog(this.name, this.id,
      {this.breed = '', this.story = '', this.picUrl = '', this.owner = ''});
}
