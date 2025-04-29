import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/controller/studentmanagment.dart';
import 'package:student_app_getx/utilities/customcolor.dart';
import 'package:student_app_getx/view/edit%20student%20detail%20screen/editstudentdetailscreen.dart';
import 'package:student_app_getx/view/student%20detail%20screen/studentdetailscreen.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    StudentmanagmentControler studentmanagmentControler=Get.put(StudentmanagmentControler());
    
    return SizedBox(
      child: Obx(() {
        final listItems=studentmanagmentControler.filteredItems();
        return ListView.builder(
          itemCount: listItems.length,
          itemBuilder: (context, index) {
            final item = listItems[index];

            return InkWell(
              onTap: () {
                Get.to(StudentDetailScreen(student: item, index: index));
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  backgroundImage: (item.imagePath.isNotEmpty)
                      ? FileImage(File(item.imagePath))
                      : null,
                  child: (item.imagePath.isEmpty)
                      ? Icon(Icons.person, color: Colors.grey)
                      : null,
                ),
                title: Text(item.name),
                subtitle: Text(item.age.toString()),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(EditStudentDetailScreen(student: item, index: index));
                        },
                        icon: Icon(Icons.edit, color: AppColor.primary),
                      ),
                   IconButton(
  onPressed: () {
    Get.defaultDialog(
      title: 'Delete Student',
      middleText: 'Are you sure you want to delete this student?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        studentmanagmentControler.deleteUserRecords(index);
        studentmanagmentControler.items.refresh();
        Get.back(); // close dialog
        Get.snackbar('Success', 'Student deleted successfully',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
      onCancel: () {},
    );
  },
  icon: Icon(Icons.delete, color: Colors.red),
)
,
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}


// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:student_app_getx/controller/studentmanagment.dart';
// import 'package:student_app_getx/utilities/customcolor.dart';
// import 'package:student_app_getx/view/edit%20student%20detail%20screen/editstudentdetailscreen.dart';
// import 'package:student_app_getx/view/student%20detail%20screen/studentdetailscreen.dart';

// class ListStudentWidget extends StatelessWidget {
//   const ListStudentWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     StudentmanagmentControler studentmanagmentControler=Get.put(StudentmanagmentControler());
// return SizedBox(
//   child: Obx((){
// final listItem=studentmanagmentControler.items.toList();
//     return ListView.builder(itemBuilder: (context,index){
// final item=listItem[index];
//       return InkWell(
//         onTap: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentDetailScreen()));
//         },
//         child: ListTile(
//           leading: CircleAvatar(
//         // child: Text(item.imagePath),
//         // child:Image.file(File(item.imagePath))
//         backgroundImage: item.imagePath.isNotEmpty
//         ?FileImage(File(item.imagePath))
//         :null
//           ),
//           title: Text(item.name),
//           subtitle: Text(item.age.toString()),
//           trailing: SizedBox(
//             width: 100,
//             child: Row(
//               children: [
//                 IconButton(onPressed: (){
//                    Get.to(EditStudentDetailScreen(item: item,index: index,));
//                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditStudentDetailScreen()));
//                 }, icon: Icon(Icons.edit,color: AppColor.primary,)),
//                 IconButton(onPressed: (){
//                                             studentmanagmentControler.deleteUserRecords(index);

//                   // Navigator.push(context, (context)=>EditScreen());
//                 }, icon: Icon(Icons.delete,color: Colors.red,))
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//     itemCount:listItem .length,
//     );
//   }),
// );
//   }
// }


