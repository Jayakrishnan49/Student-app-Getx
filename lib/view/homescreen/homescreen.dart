import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/controller/studentmanagment.dart';
import 'package:student_app_getx/utilities/customcolor.dart';
import 'package:student_app_getx/utilities/grid_student_widget.dart';
import 'package:student_app_getx/utilities/list_student_widget.dart';
import 'package:student_app_getx/view/add%20student%20detail%20screen/addstudentdetailscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentManagementController=Get.put(StudentmanagmentControler());

    TextEditingController searchController=TextEditingController();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            centerTitle: true,
            backgroundColor: AppColor.primary,
            title: Text('Student Details',style: TextStyle(color: AppColor.secondary,fontWeight:FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    studentManagementController.searchStudents(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'search',
                    border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColor.subTitle),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColor.primary, width: 2.0),
          ),
                    suffixIcon: Icon(Icons.search)
                  ),
                ),
              ),
              TabBar(tabs: [
                Tab(icon: Icon(Icons.list,color: AppColor.primary),),
                Tab(icon: Icon(Icons.grid_3x3_rounded,color:AppColor.primary,),)
              ]),
              Expanded(
                child: TabBarView(children: [
                  ListStudentWidget(),
                  GridStudentWidget(),
                ]),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColor.primary,
          onPressed: (){
          Get.to(AddStudentDetailScreen());
        },
        label: Icon(Icons.add,color: AppColor.secondary,),
        ),
      ),
    );
  }
}