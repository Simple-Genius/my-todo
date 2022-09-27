import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:todo_app/components/categoryCard.dart';
import 'package:todo_app/components/taskCard.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:todo_app/components/drawer.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final taskController = TextEditingController();
  final categoryController = TextEditingController();
  final advancedDrawerController = AdvancedDrawerController();

  void _onDrawerButtonPressed() {
    advancedDrawerController.showDrawer();
  }

  final _ref = FirebaseDatabase.instance.ref('Olivia');

  @override
  void dispose() {
    // TODO: implement dispose
    categoryController.dispose();
    advancedDrawerController.dispose();
    taskController.dispose();
    super.dispose();
  }

  final List _selectedTask = [];
  void _onTaskSelected(bool? _selected, var key) {
    if (_selected == true) {
      _selectedTask.add(key);
    } else {
      _selectedTask.remove(key);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AdvancedDrawer(
        controller: advancedDrawerController,
        backdropColor: const Color(0xFF031A55),
        drawer: myDrawer(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFF344fa1),
          ),
          padding: const EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    splashColor: Colors.white,
                    onPressed: _onDrawerButtonPressed,
                    icon: const Icon(
                      Icons.drag_handle_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: _CustomSearchDelegate());
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      log('go');
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  "What's Up Olivia!",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      decoration: TextDecoration.none),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Text(
                  'CATEGORIES',
                  style: TextStyle(
                      color: Color(0xff697bad),
                      decoration: TextDecoration.none,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder(
                  stream: _ref.child('Categories').onValue,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    final categoryList = <CategoryCard>[];
                    if (snapshot.hasData &&
                        !snapshot.hasError &&
                        snapshot.data.snapshot.value != null) {
                      final myCategories = Map<dynamic, String>.from(
                          snapshot.data.snapshot.value);
                      myCategories.forEach((key, value) {
                        categoryList.add(CategoryCard(
                          categoryName: value,
                          numberOfTasks: 2,
                          onPressed: () {
                            _ref.child('Categories').child(key).remove();
                          },
                          onEditButtonPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Update Category'),
                                    content: TextFormField(
                                      controller: categoryController,
                                      decoration: const InputDecoration(
                                        icon: Icon(FontAwesome5.edit),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          categoryController.clear();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        child: const Text('Update'),
                                        onPressed: () {
                                          _ref.child('Categories').update(
                                              {key: categoryController.text});
                                          categoryController.clear();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ));
                      });
                    }
                    return Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: categoryList,
                      ),
                    );
                  }),
              const Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
                child: Text(
                  "TODAY'S TASKS",
                  style: TextStyle(
                      color: Color(0xff697bad),
                      decoration: TextDecoration.none,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 400,
                child: Stack(
                  children: [
                    StreamBuilder(
                      stream: _ref.child('tasks').orderByValue().onValue,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        final tasklist = <TaskCard>[];
                        if (snapshot.hasData &&
                            !snapshot.hasError &&
                            snapshot.data.snapshot.value != null) {
                          final myTasks = Map<dynamic, String>.from(
                              (snapshot.data!).snapshot.value);
                          myTasks.forEach((key, value) {
                            tasklist.add(TaskCard(
                              newValue: _selectedTask.contains(value),
                              taskName: value,
                              onDeleteButtonPressed: () {
                                _ref.child('tasks').child(key).remove();
                              },
                              onTap: (bool? selected) {
                                setState(() {
                                  _onTaskSelected(selected, value);
                                });
                              },
                              onEditButtonPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Update Task'),
                                        content: TextFormField(
                                          controller: taskController,
                                          decoration: const InputDecoration(
                                            icon: Icon(FontAwesome5.edit),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              taskController.clear();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            child: const Text('Update'),
                                            onPressed: () {
                                              _ref.child('tasks').update(
                                                  {key: taskController.text});
                                              taskController.clear();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ));
                          });
                        }
                        return Expanded(
                          child: ListView(
                            children: tasklist,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 40,
                      right: 10,
                      child: FloatingActionButton(
                        backgroundColor: const Color(0xffeb06fe),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('New Task'),
                                content: TextFormField(
                                  controller: taskController,
                                  decoration: const InputDecoration(
                                    labelText: 'Enter name of task',
                                    icon: Icon(FontAwesome5.tasks),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      taskController.clear();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    child: const Text('Add task'),
                                    onPressed: () {
                                      const String a = 'Categories';
                                      const String b = 'tasks';
                                      _ref
                                          .child(b)
                                          .push()
                                          .set(taskController.text);
                                      taskController.clear();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
