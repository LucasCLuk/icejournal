import 'package:flutter/material.dart';
import 'package:icejournal/blocs/journels_bloc.dart';
import 'package:icejournal/models/journal.dart';
import 'package:icejournal/screens/add_entry_screen.dart';

class JournalListView extends StatefulWidget {
  JournalListView({Key key, this.bloc}) : super(key: key);
  final JournalBloc bloc;

  @override
  _JournalListViewState createState() => _JournalListViewState();
}

class _JournalListViewState extends State<JournalListView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Journal>>(
      stream: widget.bloc.onJournalsChanged,
      builder: (BuildContext context, AsyncSnapshot<List<Journal>> journals) {
        final int entryCount = journals.data?.length ?? 0;
        return Scaffold(
          body: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                Journal journal = journals.data[index];
                return ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddJournalView(
                            bloc: widget.bloc,
                            journal: journal,
                          ))),
                  title: Text(journal.title),
                  subtitle: Text(journal.subTitle),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: entryCount),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddJournalView(
                        bloc: widget.bloc,
                      )))),
        );
      },
    );
  }
}
