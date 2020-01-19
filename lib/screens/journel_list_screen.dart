import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:icejournal/blocs/journels_bloc.dart';
import 'package:icejournal/models/journal.dart';
import 'package:icejournal/screens/journal_detail_screen.dart';
import 'package:icejournal/widgets/journal_widget.dart';

import '../journal_search.dart';

class JournalListView extends StatefulWidget {
  JournalListView({Key key, this.bloc}) : super(key: key);
  final JournalBloc bloc;

  @override
  _JournalListViewState createState() => _JournalListViewState();
}

class _JournalListViewState extends State<JournalListView> {
  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Journal>>(
      stream: widget.bloc.onJournalsChanged,
      builder: (BuildContext context, AsyncSnapshot<List<Journal>> journals) {
        final int entryCount = journals.data?.length ?? 0;
        return Scaffold(
          appBar: AppBar(
            title: Text("Entries"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () =>
                      showSearch(context: context, delegate: JournalSearch()))
            ],
          ),
          body: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                Journal journal = journals.data[index];
                return Dismissible(
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) =>
                        widget.bloc.removeEntry(journal),
                    background: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.delete),
                    ),
                    key: Key(journal.title),
                    child: JournalTile(journal: journal));
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: entryCount),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => JournalDetailScreen(
                        bloc: widget.bloc,
                      )))),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BubbleBottomBar(
            opacity: .2,
            currentIndex: currentIndex,
            onTap: changePage,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            elevation: 8,
            fabLocation: BubbleBottomBarFabLocation.end,
            //new
            hasNotch: true,
            //new
            hasInk: true,
            //new, gives a cute ink effect
            inkColor: Colors.black12,
            //optional, uses theme color if not specified
            items: <BubbleBottomBarItem>[
              BubbleBottomBarItem(
                  backgroundColor: Colors.red,
                  icon: Icon(
                    Icons.dashboard,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.dashboard,
                    color: Colors.red,
                  ),
                  title: Text("Home")),
              BubbleBottomBarItem(
                  backgroundColor: Colors.deepPurple,
                  icon: Icon(
                    Icons.book,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.book,
                    color: Colors.deepPurple,
                  ),
                  title: Text("Journals")),
              BubbleBottomBarItem(
                  backgroundColor: Colors.indigo,
                  icon: Icon(
                    Icons.photo_size_select_actual,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.photo_size_select_actual,
                    color: Colors.indigo,
                  ),
                  title: Text("Gallery")),
              BubbleBottomBarItem(
                  backgroundColor: Colors.green,
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.account_circle,
                    color: Colors.green,
                  ),
                  title: Text("Profile"))
            ],
          ),
        );
      },
    );
  }
}
