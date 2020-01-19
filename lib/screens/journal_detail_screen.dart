import 'package:flutter/material.dart';
import 'package:icejournal/blocs/journels_bloc.dart';
import 'package:icejournal/models/journal.dart';

class JournalDetailScreen extends StatefulWidget {
  JournalDetailScreen({Key key, this.bloc, this.journal = null})
      : super(key: key);
  final JournalBloc bloc;
  final Journal journal;

  @override
  _JournalDetailScreenState createState() => _JournalDetailScreenState();
}

class _JournalDetailScreenState extends State<JournalDetailScreen> {
  Journal _journal;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _journal = widget.journal ?? Journal();
  }

  void save(BuildContext context) {
    if (widget.journal == null && _formKey.currentState.validate()) {
      widget.bloc.addEntry(_journal);
      Navigator.of(context).pop();
    } else if (!_formKey.currentState.validate()) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Form is not valid")));
    } else {
      Navigator.of(context).pop();
    }
  }

  String validateTitle(String data) {
    if (data.isEmpty) {
      return "Title Cannot be Empty";
    }
    return null;
  }

  String validateContent(String data) {
    if (data.isEmpty) {
      return "Content Cannot be Empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal Entry"),
      ),
      body: Form(
          key: _formKey,
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
      floatingActionButton: Builder(
          builder: (context) => FloatingActionButton.extended(
              onPressed: () => save(context),
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(Icons.save),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Save"),
                  )
                ],
              ))),
    );
  }
}
