class Journal {
  String title, content;
  DateTime created, lastEdited;
  String mood;

  String get subTitle => content.substring(0, 25);

  @override
  // TODO: implement hashCode
  int get hashCode => this.title.hashCode;
}
