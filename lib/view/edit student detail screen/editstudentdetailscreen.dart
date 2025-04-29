// import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/controller/studentmanagment.dart';
import 'package:student_app_getx/model/student%20details%20db/studentdetailsdb.dart';
import 'package:student_app_getx/utilities/custombottomsheet.dart';
import 'package:student_app_getx/utilities/custombutton.dart';
import 'package:student_app_getx/utilities/customcolor.dart';
import 'package:student_app_getx/utilities/customtextformfield.dart';

class EditStudentDetailScreen extends StatelessWidget {
  final StudentModel student;
  final int index;

  const EditStudentDetailScreen({
    super.key,
    required this.student,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: student.name);
    final ageController = TextEditingController(text: student.age.toString());
    final phnoController = TextEditingController(text: student.phoneNumber);
    final formKey = GlobalKey<FormState>();

    final studentController = Get.find<StudentmanagmentControler>();
    studentController.selectedImagePath.value = student.imagePath;

    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.secondary),
        backgroundColor: AppColor.primary,
        title: Text(
          'Edit Student Details',
          style: TextStyle(
            color: AppColor.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() => Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: studentController.selectedImagePath.value.isNotEmpty
                      ? ClipRRect(
                          child: Image.file(
                            File(studentController.selectedImagePath.value),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(child: Text('No image added')),
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Change Image',
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return CustomBottomSheet(onImagePicked: (imagePath) {
                          studentController.selectedImagePath.value = imagePath;
                          // log(studentController.selectedImagePath.value);
                          // log(imagePath);
                        });
                      },
                    );
                  },
                ),
                SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Student name*'),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      controller: nameController,
                      width: 400,
                      borderRadius: 15,
                      hintText: 'Enter student name',
                    ),
                    SizedBox(height: 25),
                    Text('Age*'),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      controller: ageController,
                      width: 400,
                      borderRadius: 15,
                      hintText: 'Enter age',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 25),
                    Text('Phone number*'),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      controller: phnoController,
                      width: 400,
                      borderRadius: 15,
                      hintText: 'Enter phone number',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                SizedBox(height: 70),
                CustomButton(
                  text: 'Update Details',
                  width: 400,
                  borderRadius: 10,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      final updatedStudent = StudentModel(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        phoneNumber: phnoController.text,
                        imagePath: studentController.selectedImagePath.value,
                      );

                      studentController.editUserRecords(updatedStudent, index);

                      Get.back();
                          Get.snackbar(
                            'Success', 
                            'Student details updated successfully!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppColor.success,
                            colorText: Colors.white,
                            margin: EdgeInsets.all(10),
                            borderRadius: 10,
                          );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
