class DogDetailsArgs {
  final int id;
  final Function onEdited;
  final bool isMyDog;

  DogDetailsArgs(this.id, {this.onEdited, this.isMyDog = false});
}
