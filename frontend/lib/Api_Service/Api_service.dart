import 'dart:convert';
import 'dart:io';

import 'package:dqc/Model/Object.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String _baseURL = "https://06e0-1-55-41-26.ngrok-free.app";

  // static Future<List<Object>?> getObj() async {
  //   var client = http.Client();
  //   var uri = Uri.parse(_baseURL + "/1");
  //   var response = await client.get(uri);
  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body) as List ;     // as List

  //     return json.map((ObjectToJson) => Object.fromJson(ObjectToJson)).toList();
  //   }
  //   return [];
  // }

// static Future<List<Object>?> getObj() async {
//     var client = http.Client();
//     var uri = Uri.parse(_baseURL + "/1");
//     var response = await client.get(uri);
//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body) as List ;     // as List

//       return json.map((ObjectToJson) => new Object.fromJson(ObjectToJson)).toList();
//     }
//     return [];
//   }

  static Future<List<Object>?> getObj() async {
    var client = http.Client();
    var uri = Uri.parse(_baseURL + "/1");
    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey('image') &&
            jsonResponse.containsKey('object')) {
          Object object = Object.fromJson(jsonResponse);

          return [object];
        }
      }
    } catch (e) {
      // Handle exceptions or errors
      print('Error: $e');
    } finally {
      client.close();
    }
  }

  static Future<List<Object>?> detectImg3(File img) async {
    var client = http.Client();
    var uri = Uri.parse(_baseURL + "/2");

    try {
      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('file', img.path));

      var response = await client.send(request);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            jsonDecode(await response.stream.bytesToString());

        if (jsonResponse.containsKey('image') &&
            jsonResponse.containsKey('object')) {
          Object object = Object.fromJson(jsonResponse);
          return [object];
        }

        // Handle other response scenarios if needed
        return null;
      } else {
        // Handle non-200 status codes if needed
        print('Failed to upload image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle exceptions more explicitly
      print('Error uploading image: $e');
      return null;
    } finally {
      client.close();
    }
  }

  static Future<bool?> fetchAPICheck(bool check) async {
    var client = http.Client();
    var uri = Uri.parse(_baseURL + "/");
    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    } finally {
      client.close();
    }
  }
}

 



  // static Future<List<Note>?> getAll() async {
  //   var client = http.Client();
  //   var uri = Uri.parse(_baseURL + "/notes/list");
  //   var response = await client.get(uri);
  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body) as List ;
  //     return json.map((notesJson) => Note.fromJson(notesJson)).toList();
  //   }
  //   return [];
  // }

//  static Future<List<Note>?> getBy(String uID) async {
//     var client = http.Client();
//     var uri = Uri.parse(_baseURL + "/notes/listBy");
//     var response = await client.post(uri, body: {"userid": uID});
//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body) as List ;
//       return json.map((notesJson) => Note.fromJson(notesJson)).toList();
//     }
//     return [];
//   }

//   static Future<void> addNote(Note notes) async {
//     var client = http.Client();
//     var uri = Uri.parse(
//       _baseURL + "/notes/add",
//     );
//     var response = await client.post(uri, body: notes.toJson());

//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
//     }

//   }

//   static Future<void> deleteNote(Note notes) async{
//      var client = http.Client();
//     var uri = Uri.parse(
//       _baseURL + "/notes/delete",
//     );
//     var response = await client.post(uri, body: notes.toJson());

//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
//     }
// }
