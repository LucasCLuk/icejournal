import 'package:flutter/material.dart';
import 'package:icejournal/blocs/journels_bloc.dart';
import 'package:icejournal/models/journal.dart';

class AddJournalView extends StatefulWidget {
  AddJournalView({Key key, this.bloc, this.journal = null}) : super(key: key);
  final JournalBloc bloc;
  final Journal journal;

  @override
  _AddJournalViewState createState() => _AddJournalViewState();
}

class _AddJournalViewState extends State<AddJournalView> {
  final Journal _journal = Journal();

  void save() {
    if (widget.journal == null) {
      widget.bloc.addEntry(_journal);
    }
  }

  String validateTitle(String data) {
    if (data.isEmpty) {
      return "Title Cannot be Empty";
    }
    return '';
  }

  String validateContent(String data) {
    if (data.isEmpty) {
      return "Content Cannot be Empty";
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal Entry"),
      ),
      body: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "Title"),
                  initialValue: _journal.title,
                  onChanged: (String value) => _journal.title = value,
                  validator: validateTitle,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Content"),
                  initialValue: _journal.content,
                  onChanged: (String value) => _journal.content = value,
                  validator: validateContent,
                  maxLines: 10,
                ),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: save,
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.save),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Save"),
              )
            ],
          )),
    );
  }
}
