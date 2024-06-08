import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_end_user/src/my_app.dart';
import 'package:graduation_project_end_user/utils/bloc_opserver.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graduation_project_end_user/utils/cashe_helper.dart';
import 'package:graduation_project_end_user/utils/dio_helper.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
String boxName = 'user';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DioHelper.init();
  await CashHelper.init();
  await Hive.initFlutter();
 await Hive.openBox('localization');
 await Hive.openBox(boxName);
  var box = Hive.box(boxName);
  Bloc.observer = MyBlocObserver();
  runApp( MyApp());
}



