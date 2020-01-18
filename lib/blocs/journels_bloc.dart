import 'package:icejournal/models/journal.dart';
import 'package:rxdart/rxdart.dart';

class JournalBloc {
  List<Journal> journals = List();
  final BehaviorSubject<List<Journal>> _journalSubject = BehaviorSubject();

  ValueObservable<List<Journal>> get onJournalsChanged =>
      _journalSubject.stream;

  void addEntry(Journal entry) {
    journals.add(entry);
    _journalSubject.add(journals);
  }

  void removeEntry(Journal entry) {
    journals.remove(entry);
    _journalSubject.add(journals);
  }

  void dispose() {
    _journalSubject.close();
  }
}
