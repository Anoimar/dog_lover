import 'package:doglover/models/dog.dart';

class EditDogArgs {
  final int id;
  final Function onEdited;
  final String imageUrl;
  final String title;
  final String description;
  final String breed;

  EditDogArgs(this.id, this.onEdited, this.imageUrl, this.title,
      this.description, this.breed);

  factory EditDogArgs.create(Function onEdited, Dog dog) => EditDogArgs(
      dog.id, onEdited, dog.picUrl, dog.name, dog.description, dog.breed);
}
