import 'package:flutter/material.dart';
import 'package:icejournal/models/journal.dart';

class JournalTile extends StatelessWidget {
  final Journal journal;

  const JournalTile({Key key, this.journal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(journal.title ?? ""),
      subtitle: Text(journal.subTitle),
      onTap: () =>
          Navigator.of(context).pushNamed("/journalentry", arguments: journal),
    );
  }
}
