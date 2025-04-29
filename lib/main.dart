import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_app_getx/model/student%20details%20db/studentdetailsdb.dart';
import 'package:student_app_getx/utilities/customcolor.dart';
import 'package:student_app_getx/view/homescreen/homescreen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(StudentModelAdapter());
  await Hive.openBox<StudentModel>('studentBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.secondary),
      ),
      home: const HomeScreen(),
    );
  }
}
