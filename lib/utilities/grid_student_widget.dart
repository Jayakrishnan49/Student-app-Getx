import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/controller/studentmanagment.dart';
import 'package:student_app_getx/utilities/customcolor.dart';
import 'package:student_app_getx/view/edit%20student%20detail%20screen/editstudentdetailscreen.dart';
import 'package:student_app_getx/view/student%20detail%20screen/studentdetailscreen.dart';

class GridStudentWidget extends StatelessWidget {
  const GridStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
        StudentmanagmentControler studentmanagmentControler=Get.put(StudentmanagmentControler());


return Obx(()
{
  final listItem=studentmanagmentControler.filteredItems();
      if(listItem.isEmpty){
         return Center(
            child: Text('No student found'),
          );
        }
      return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        ), 
        itemBuilder: (context,index){
          final item=listItem[index];
          return InkWell(
            onTap: () {
              Get.to(StudentDetailScreen(student: item, index: index));
            },
            child: Card(
              child: Column(
                children: [
                  
                  CircleAvatar(radius: 40,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: (item.imagePath.isNotEmpty)
                      ? FileImage(File(item.imagePath))
                      : null,
                  child: (item.imagePath.isEmpty)
                      ? Icon(Icons.person, color: Colors.grey)
                      : null,
                  ),
                  Text(item.name),
                  Text(item.age.toString()),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // IconButton(onPressed: (){
                      //   Get.to(EditStudentDetailScreen(student: item,index: index,));
                      // },
                      //  icon: Icon(Icons.edit,color: AppColor.primary,)
                      //  ),
                      IconButton(
                        onPressed: () {
                          final originalIndex = studentmanagmentControler.items.indexOf(item);
                          if (originalIndex != -1) {
                            Get.to(EditStudentDetailScreen(student: item, index: originalIndex));
                          }
                        },
                        icon: Icon(Icons.edit, color: AppColor.primary),
                      ),
                      IconButton(
                      //   onPressed: (){
                      //   Get.defaultDialog(
                      //     title: 'Delete Student',
                      //     middleText: 'Are you sure you want to delete this student?',
                      //     textConfirm: 'Yes',
                      //     textCancel: 'No',
                      //     confirmTextColor: Colors.white,
                      //     buttonColor: Colors.red,
                      //     onConfirm: () {
                      //       studentmanagmentControler.deleteUserRecords(index);
                      //       studentmanagmentControler.items.refresh();
                      //       Get.back(); 
                      //       Get.snackbar('Success', 'Student deleted successfully',
                      //         backgroundColor: Colors.red,
                      //         colorText: Colors.white,
                      //       );
                      //     },
                      //     onCancel: () {},
                      //   );
                 
                      // },
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'Delete Student',
                          middleText: 'Are you sure you want to delete this student?',
                          textConfirm: 'Yes',
                          textCancel: 'No',
                          confirmTextColor: Colors.white,
                          buttonColor: Colors.red,
                          onConfirm: () {
                            final originalIndex = studentmanagmentControler.items.indexOf(item);
                            if (originalIndex != -1) {
                              studentmanagmentControler.deleteUserRecords(originalIndex);
                              studentmanagmentControler.items.refresh();
                            }
                            Get.back();
                            Get.snackbar('Success', 'Student deleted successfully',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          },
                          onCancel: () {},
                        );
                      },
                       icon: Icon(Icons.delete,color: Colors.red,))
                    ],
                  )
                ],
              ),
            ),
          );
        },
        itemCount: listItem.length,
        );
});
  }
}