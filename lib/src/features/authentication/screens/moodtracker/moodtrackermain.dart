import 'package:auth/main.dart';
import 'package:auth/src/features/authentication/screens/moodtracker/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:auth/src/features/authentication/screens/moodtracker/features/activities/model/activity.dart';
import 'package:auth/src/features/authentication/screens/moodtracker/features/mood_records/data/mood_log/mood_record_repository.dart';
import 'package:auth/src/features/authentication/screens/moodtracker/features/mood_records/domain/mood_log/mood_record.dart';

import '../../../../../firebase_options.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../chatbot/providers/models_provider.dart';

void mainfun() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(MoodRecordAdapter());
  Hive.registerAdapter(ActivityAdapter());

  final moodRecordsRepository = await MoodRecordRepository.createRepository();

  runApp(
    ProviderScope(
      overrides: [moodRecordRepositoryProvider.overrideWithValue(moodRecordsRepository)],
      child: const MyApp(),
    ),
  );
}

class DummyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(); // You can return any other simple widget here.
  }
}
