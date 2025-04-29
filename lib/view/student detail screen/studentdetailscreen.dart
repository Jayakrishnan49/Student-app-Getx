import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_app_getx/model/student%20details%20db/studentdetailsdb.dart';
import 'package:student_app_getx/utilities/customcolor.dart';

class StudentDetailScreen extends StatelessWidget {
  final StudentModel student;
  final int index;
  const StudentDetailScreen({super.key, required this.student, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.secondary),
        backgroundColor: AppColor.primary,
        title: Text(
          'About',
          style: TextStyle(
            color: AppColor.secondary,
            fontWeight:FontWeight.bold
            ),
            ),
            ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: SizedBox(
            width: 350,
            height: 600,
            child: Card(
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  CircleAvatar(
                    backgroundImage:FileImage(File(student.imagePath)),
                    radius: 150,
                  ),
                  SizedBox(height: 30,),
                  // Text('Name'),
                  Text('Name: ${student.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  SizedBox(height: 10,),
                  Text('Age: ${student.age}'.toString(),style: TextStyle(fontSize: 20),),
                  SizedBox(height: 10,),
                  Text('Ph no: ${student.phoneNumber}',style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}