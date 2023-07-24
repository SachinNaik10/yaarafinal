// import 'dart:async';
import 'dart:collection';

import 'package:collection/collection.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:auth/src/features/authentication/screens/moodtracker/features/mood_records/data/mood_log/mood_record_repository.dart';
import 'package:auth/src/features/authentication/screens/moodtracker/features/mood_records/domain/mood_log/mood_record.dart';

import 'dart:collection';

import 'package:collection/collection.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:auth/src/features/authentication/screens/moodtracker/features/mood_records/data/mood_log/mood_record_repository.dart';
import 'package:auth/src/features/authentication/screens/moodtracker/features/mood_records/domain/mood_log/mood_record.dart';

// Step 1: Create a state class for the MoodRecordsScreenController
import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:auth/src/features/authentication/screens/moodtracker/features/mood_records/data/mood_log/mood_record_repository.dart';
import 'package:auth/src/features/authentication/screens/moodtracker/features/mood_records/domain/mood_log/mood_record.dart';

class MoodRecordsScreenController extends StateNotifier<MoodRecordRepository> {
  MoodRecordsScreenController(MoodRecordRepository repository) : super(repository);



  SplayTreeMap<String, List<MapEntry<dynamic, MoodRecord>>> groupMoodRecordsByDay(Map<dynamic, MoodRecord> boxMap) {
    final groups = groupBy(boxMap.entries, (record) => DateFormat("yyyy-MM-dd").format(record.value.date));
    return SplayTreeMap.from(
      groups,
          (key1, key2) => key2.compareTo(key1),
    );
  }
}

final moodRecordScreenControllerProvider = StateNotifierProvider<MoodRecordsScreenController, MoodRecordRepository>(
      (ref) => MoodRecordsScreenController(ref.read(moodRecordRepositoryProvider)),
);
