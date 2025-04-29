import 'dart:developer';

import 'package:get/state_manager.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app_getx/model/student%20details%20db/studentdetailsdb.dart';

class StudentmanagmentControler extends GetxController {
  var items = <StudentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final userRecordData = Hive.box<StudentModel>('studentBox');
    items.addAll(userRecordData.values.toList());
  }

  void addUserRecords(StudentModel value) {
    final userRecordData = Hive.box<StudentModel>('studentBox');
    userRecordData.add(value);
    items.add(value); 
 for (final item in items) {
      log("Added Item: ${item.name}, Age: ${item.age}, Image Path: ${item.imagePath}");
    } 
    items.refresh();
  }

  void editUserRecords(StudentModel value, int index) {
    final userRecordData = Hive.box<StudentModel>('studentBox');
    userRecordData.putAt(index, value);
    items[index] = value;
    items.refresh(); 
  }
void deleteUserRecords(int index){
//  final userRecordData = Hive.box<StudentModel>('studentBox');

//  items[index].delete();
//   userRecordData.delete(index);
//  items.refresh();
  // final userRecordData = Hive.box<StudentModel>('studentBox');
  items[index].delete(); 
  items.removeAt(index); 
  items.refresh();
}
/////////////
var searchitems = ''.obs;

// Search function: just update search text
void searchStudents(String value) {
  searchitems.value = value;
}

// Filter function: based on current search text
List<StudentModel> filteredItems() {
  List<StudentModel> result = [];

  if (searchitems.isEmpty) {
    return items;
  } else {
    for (var student in items) {
      if (student.name.toLowerCase().contains(searchitems.value.toLowerCase())) {
        result.add(student);
      }
    }
    return result;
  }
}


// searchStudents(String value){
//  return searchitems.value=value;
// }

  var selectedImagePath = ''.obs;
  Future<void> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

  Future<void> pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

}
