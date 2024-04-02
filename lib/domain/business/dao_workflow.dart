import 'package:hyrule/domain/model/entry.dart';

abstract class DaoWorkflow {
  Future<List<Entry>> getSavedEntries();

  Future<void> saveEntry({required Entry entry});

  Future<void> deleteEntry({required Entry entry});
}