class Journal {
  String title, content;
  DateTime created, lastEdited;
  String mood;

  String get subTitle =>
      content?.substring(0, content.length > 20 ? 20 : content.length) ?? "";

  @override
  // TODO: implement hashCode
  int get hashCode => this.title.hashCode;
}
