import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:udemy_flutter/shared/componenet/component.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';

import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {
  late Database database;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  bool isBottomSheetOpened = false;
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppSates>(
        listener: (BuildContext listenerContext, state) {},
        builder: (BuildContext builderContext, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
                title: Text(
              AppCubit.get(builderContext).titles[AppCubit.get(builderContext).currentIndex],
            )),
            body: AppCubit.get(builderContext).screens[AppCubit.get(builderContext).currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (isBottomSheetOpened) {
                  if (formKey.currentState?.validate() == true) {
                    insertToDatabase(
                            date: dateController.text,
                            time: timeController.text,
                            title: titleController.text)
                        .then((value) {
                      Navigator.pop(context);
                      // setState(() {
                      //   isBottomSheetOpened = !isBottomSheetOpened;
                      // });
                    });
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        elevation: 20,
                        (context) => Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  label: 'Task Title',
                                  validatorErrorMessage:
                                      'title must be not empty',
                                  prefixIcon: Icons.title,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                  controller: timeController,
                                  type: TextInputType.text,
                                  label: 'Task time',
                                  validatorErrorMessage:
                                      'time must be not empty',
                                  prefixIcon: Icons.lock_clock,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value?.format(context).toString() ??
                                              '';
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                  controller: dateController,
                                  type: TextInputType.text,
                                  label: 'Task date',
                                  validatorErrorMessage:
                                      'date must be not empty',
                                  prefixIcon: Icons.date_range,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2023-09-06'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMMd().format(value!);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    // setState(() {
                    //   isBottomSheetOpened = !isBottomSheetOpened;
                    // });
                  });
                  // setState(() {
                  //   isBottomSheetOpened = !isBottomSheetOpened;
                  // });
                }
              },
              child: Icon(
                isBottomSheetOpened ? Icons.add : Icons.edit,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: AppCubit.get(builderContext).currentIndex,
              onTap: (index) {
                AppCubit.get(builderContext).changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'Tasks',
                  icon: Icon(
                    Icons.menu,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Done',
                  icon: Icon(
                    Icons.check,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Archived',
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks ( id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error when creating table ${error.toString}');
        });
      },
      onOpen: (db) {
        getDataFromDatabase(db).then((value) {
          // setState(() {
          //   tasks = value;
          // });
        });
        print('database opened');
      },
    );
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print('${value} inserted successfully');
      }).catchError((error) {
        print('error when insert to table ${error.toString}');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM tasks');
  }
}
