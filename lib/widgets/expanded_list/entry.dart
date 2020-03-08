class Entry {
  Entry(this.title, [this.id = 0, this.children = const <Entry>[]]);

  final String title;
  final int id;
  final List<Entry> children;
}
