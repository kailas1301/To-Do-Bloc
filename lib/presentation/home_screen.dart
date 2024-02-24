import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/bloc/to_do_bloc.dart';
import 'package:todo/core/constants.dart';
import 'package:todo/presentation/widgets/textbutton.dart';
import 'package:todo/presentation/widgets/textform_field_widget.dart';
import 'package:todo/presentation/widgets/to_do_list.dart';

import '../model/models.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ToDoBloc>().add(FetchInitialToDoListEvent());
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kVioletColor,
        centerTitle: true,
        title: Text(
          'To Do App',
          style:
              GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              context.read<ToDoBloc>().add(FetchInitialToDoListEvent());
            },
          ),
        ],
      ),
      body: BlocConsumer<ToDoBloc, ToDoState>(
        listener: (context, state) {
          if (state is ErrorToDoState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.errorMessage}'),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingToDoState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedToDoState) {
            return ToDoList(toDoList: state.toDoList);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddToDoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showAddToDoDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Add ToDo',
            style:
                GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          content: SizedBox(
            height: 300,
            child: Column(
              children: [
                TextFormFieldWidget(
                  titleController: titleController,
                  title: 'Title',
                ),
                kHeight10,
                TextFormFieldWidget(
                  titleController: descriptionController,
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
              onPressedName: 'Add',
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  context.read<ToDoBloc>().add(
                        AddToDoEvent(
                          toDo: ToDoModel(
                            title: titleController.text,
                            description: descriptionController.text,
                            isCompleted: false,
                          ),
                        ),
                      );
                  context.read<ToDoBloc>().add(FetchInitialToDoListEvent());
                  Navigator.pop(context);
                } else {
                  // Show a SnackBar if fields are not filled
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fill all fields'),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
