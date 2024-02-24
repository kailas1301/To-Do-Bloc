import 'dart:convert';

import 'package:todo/model/models.dart';
import 'package:http/http.dart' as http;

const String todoApiBaseUrl = 'https://api.nstack.in/v1/todos';
final Uri todoApiUri = Uri.parse(todoApiBaseUrl);

class ToDoApiHelper {
  // Fetches a list of ToDoModel from the API.
  Future<List<ToDoModel>> fetchToDoList() async {
    List<ToDoModel> toDoList = [];

    try {
      final response = await http.Client().get(todoApiUri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List items = responseData['items'];

        for (int i = 0; i < items.length; i++) {
          ToDoModel toDo = ToDoModel.fromJson(items[i]);
          toDoList.add(toDo);
        }
      }

      return toDoList;
    } catch (e) {
      // Handle error during data loading.
      print('Error loading the data: $e');
      return [];
    }
  }

  // Adds a ToDoModel to the API.
  Future<bool> addToDoModel({required ToDoModel toDo}) async {
    try {
      final response = await http.Client().post(
        todoApiUri,
        body: jsonEncode(toDo),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      // Handle error during data loading.
      print('Error adding ToDoModel: $e');
      return false;
    }
  }

  Future<bool> updateToDoModel({required ToDoModel updatedToDo}) async {
    final client = http.Client(); // or inject the client

    try {
      final updateUrl = "$todoApiBaseUrl/${updatedToDo.id}";
      print(updateUrl);

      final response = await client.put(
        Uri.parse(updateUrl),
        body: jsonEncode(updatedToDo),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // Handle other status codes with appropriate messages
        throw Exception('API error updating ToDo: ${response.statusCode}');
      }
    } catch (error) {
      // Handle generic errors with a meaningful message
      throw Exception('Error updating ToDoModel: $error');
    } finally {
      client.close(); // Close the client if injected
    }
  }

  // Deletes a ToDoModel from the API by its ID.
  Future<bool> deleteToDoModel({required String toDoId}) async {
    try {
      final deleteUrl = '$todoApiBaseUrl/$toDoId';
      final uriForDeleting = Uri.parse(deleteUrl);

      final response = await http.Client().delete(uriForDeleting);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      // Handle error during data deletion.
      print('Error deleting ToDoModel: $e');
      return false;
    }
  }

  void dispose() {
    http.Client().close();
  }
}
