import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/controller/studentmanagment.dart';
import 'package:student_app_getx/model/student%20details%20db/studentdetailsdb.dart';
import 'package:student_app_getx/utilities/custombottomsheet.dart';
import 'package:student_app_getx/utilities/custombutton.dart';
import 'package:student_app_getx/utilities/customcolor.dart';
import 'package:student_app_getx/utilities/customtextformfield.dart';

class AddStudentDetailScreen extends StatelessWidget {
  const AddStudentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController=TextEditingController();
    TextEditingController ageController=TextEditingController();
    TextEditingController phnoController=TextEditingController();
    final formKey=GlobalKey<FormState>();
    StudentmanagmentControler studentcontroller=Get.find();

    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.secondary),
        backgroundColor: AppColor.primary,
        title: Text('Add student details',
        style: TextStyle(
          color: AppColor.secondary,
          fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(()=>
        Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  
                    Container(
                      height: 320,
                      decoration: BoxDecoration(
                        color:Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: studentcontroller.selectedImagePath.value.isNotEmpty?
                      ClipRRect(
                        child: Image.file(File(studentcontroller.selectedImagePath.value)),
                      ):
                      Center(child: Text('No image added'),)
        
                    ),
                  
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: 'Add Image',
                    onTap: () {
                      ///// upload image
                      showModalBottomSheet(
              context: context,
              builder: (context) {
                return CustomBottomSheet(onImagePicked: (imagePath) {
                  studentcontroller.selectedImagePath.value=imagePath;
                  // log(studentcontroller.selectedImagePath.value);
                  // log(imagePath);
                });
              },
            );
                    },
                    ),
            
                    SizedBox(height: 50,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Student name*'),
                        SizedBox(height: 15,),
                        CustomTextFormField(
                          controller: nameController,
                          width: 400,
                          borderRadius: 15,
                          hintText: 'add student name',
                           validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'enter student name';
                      }
                      return null;
                      
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 25,),
                        Text('Age*'),
                        SizedBox(height: 15,),
                        CustomTextFormField(
                          controller: ageController,
                          width: 400,
                          borderRadius: 15,
                          hintText: 'add age',
                          keyboardType: TextInputType.number,
                           validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'enter student age';
                      }
                      return null;
                      
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 25,),
                        Text('Phone number*'),
                        SizedBox(height: 15,),
                        CustomTextFormField(
                          controller: phnoController, 
                          width: 400,
                          borderRadius: 15,
                          hintText: 'add phone number',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'enter the phone  Number';
                      }
                      return null;
                      
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ],
                    ),
                    SizedBox(height: 70,),
                    CustomButton(
                      text: 'Save Details',
                      width: 400,
                      borderRadius: 10,
                      onTap: () {
          
            if (formKey.currentState!.validate() ) {
              final value = StudentModel(
                name: nameController.text,
                age: int.parse(ageController.text),
                phoneNumber: phnoController.text,
                imagePath:  studentcontroller.selectedImagePath.value,
              );
            Get.back();
            studentcontroller.addUserRecords(value);
            Get.snackbar(
              'Success', 
              'Student details added successfully!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColor.success,
              colorText: Colors.white,
              margin: EdgeInsets.all(10),
              borderRadius: 10,
            );           
            }
            }                 
                )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    
  }
}