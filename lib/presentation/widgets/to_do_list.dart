import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/bloc/to_do_bloc.dart';
import 'package:todo/core/constants.dart';
import 'package:todo/model/models.dart';
import 'package:todo/presentation/widgets/textbutton.dart';
import 'package:todo/presentation/widgets/textform_field_widget.dart';

class ToDoList extends StatelessWidget {
  final List<ToDoModel> toDoList;

  const ToDoList({Key? key, required this.toDoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return toDoList.isEmpty
        ? const Center(
            child: Text('No Task Found.'),
          )
        : ListView.builder(
            itemCount: toDoList.length,
            itemBuilder: (context, index) {
              ToDoModel toDo = toDoList[index];
              TextEditingController titleEditingController =
                  TextEditingController(text: toDo.title);
              TextEditingController descriptionEditingController =
                  TextEditingController(text: toDo.description);

              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 225, 214, 242)),
                  child: ListTile(
                    title: Text(
                      toDo.title,
                      style: GoogleFonts.openSans(
                          fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      toDo.description,
                      style: GoogleFonts.openSans(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    'Edit ToDo',
                                    style: GoogleFonts.openSans(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  content: SizedBox(
                                    height: 300,
                                    child: Column(
                                      children: [
                                        TextFormFieldWidget(
                                          titleController:
                                              titleEditingController,
                                          title: 'Title',
                                        ),
                                        kHeight10,
                                        TextFormFieldWidget(
                                          titleController:
                                              descriptionEditingController,
                                          title: 'Description',
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButtonWidget(
                                      onPressedName: 'Cancel',
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButtonWidget(
                                      onPressedName: 'Save',
                                      onPressed: () {
                                        context.read<ToDoBloc>().add(
                                              UpdateToDoEvent(
                                                updatedToDo: ToDoModel(
                                                    id: toDo.id,
                                                    title:
                                                        titleEditingController
                                                            .text,
                                                    description:
                                                        descriptionEditingController
                                                            .text,
                                                    isCompleted: false),
                                              ),
                                            );
                                        context
                                            .read<ToDoBloc>()
                                            .add(FetchInitialToDoListEvent());

                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: const Text(
                                      'Are you sure you want to delete this task?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the confirmation dialog
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Delete the task and close the confirmation dialog
                                        context.read<ToDoBloc>().add(
                                            DeleteToDoEvent(toDoId: toDo.id!));
                                        context
                                            .read<ToDoBloc>()
                                            .add(FetchInitialToDoListEvent());
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        Checkbox(
                          // Checkbox for completion status
                          value: toDo.isCompleted,
                          onChanged: (value) {
                            // Toggle completion status
                            context.read<ToDoBloc>().add(
                                  UpdateToDoEvent(
                                    updatedToDo: ToDoModel(
                                      id: toDo.id,
                                      title: toDo.title,
                                      description: toDo.description,
                                      isCompleted: value!,
                                    ),
                                  ),
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
