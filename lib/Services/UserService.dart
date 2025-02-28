import 'dart:convert';
import 'package:flutter_seminario/Models/PlaceModel.dart';
import 'package:flutter_seminario/Models/PostModel.dart';

import 'package:flutter_seminario/Screens/home_users.dart';
import 'package:flutter_seminario/main.dart';
import 'package:flutter_seminario/Models/UserModel.dart';
import 'package:dio/dio.dart'; // Usa un prefijo 'Dio' para importar la clase Response desde Dio
import 'package:get_storage/get_storage.dart';
import 'package:flutter_seminario/Models/UserModel.dart';


class UserService {
  final String baseUrl = "http://127.0.0.1:3000"; // URL de tu backend
  final Dio dio = Dio(); // Usa el prefijo 'Dio' para referenciar la clase Dio
  var statusCode;
  var data;

  void saveToken(String token){
    final box = GetStorage();
    box.write('token', token);
  }

  String? getToken(){
    final box = GetStorage();
    return box.read('token');
  }
  //Función createUser
  Future<int> createUser(User newUser)async{
    print('createUser');
    print('try');
    //Aquí llamamos a la función request
    print('request');
    // Utilizar Dio para enviar la solicitud POST a http://127.0.0.1:3000/users
    Response response = await dio.post('$baseUrl/users', data: newUser.toJson());
    //En response guardamos lo que recibimos como respuesta
    //Printeamos los datos recibidos

    data = response.data.toString();
    print('Data: $data');
    //Printeamos el status code recibido por el backend

    statusCode = response.statusCode;
    print('Status code: $statusCode');

    if (statusCode == 201) {
      // Si el usuario se crea correctamente, retornamos el código 201
      print('201');
      return 201;
    } else if (statusCode == 400) {
      // Si hay campos faltantes, retornamos el código 400
      print('400');

      return 400;
    } else if (statusCode == 500) {
      // Si hay un error interno del servidor, retornamos el código 500
      print('500');

      return 500;
    } else {
      // Otro caso no manejado
      print('-1');

      return -1;
    }
  }

  Future<List<Place>> getData() async {
  print('getData');
  // Interceptor para agregar el token a la cabecera 'x-access-token'
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // Obtener el token guardado
      final token = getToken();

      print(token);
      
      // Si el token está disponible, agregarlo a la cabecera 'x-access-token'
      if (token != null) {
        options.headers['x-access-token'] = token;
      }
      return handler.next(options);
    },
  ));
  
  try {
    var res = await dio.get('$baseUrl/place');
    List<dynamic> responseData = res.data; // Obtener los datos de la respuesta
  
    // Convertir los datos en una lista de objetos Place
    List<Place> places = responseData.map((data) => Place.fromJson(data)).toList();
  
    return places; // Devolver la lista de lugares
  } catch (e) {
    // Manejar cualquier error que pueda ocurrir durante la solicitud
    print('Error fetching data: $e');
    throw e; // Relanzar el error para que el llamador pueda manejarlo
  }
}
Future<List<Review>> getReviews(id) async {
  print('getData');
  // Interceptor para agregar el token a la cabecera 'x-access-token'
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // Obtener el token guardado
      final token = getToken();

      print(token);
      
      // Si el token está disponible, agregarlo a la cabecera 'x-access-token'
      if (token != null) {
        options.headers['x-access-token'] = token;
      }
      return handler.next(options);
    },
  ));
  
  try {
    var res = await dio.get('$baseUrl/review/byAuthor/$id');
    List<dynamic> responseData = res.data; // Obtener los datos de la respuesta
  
    // Convertir los datos en una lista de objetos Place
    List<Review> reviews = responseData.map((data) => Review.fromJson(data)).toList();
  
    return reviews; // Devolver la lista de lugares
  } catch (e) {
    // Manejar cualquier error que pueda ocurrir durante la solicitud
    print('Error fetching data: $e');
    throw e; // Relanzar el error para que el llamador pueda manejarlo
  }
}
Future<Review> putReviews(id,review) async {
  print('getData');
  // Interceptor para agregar el token a la cabecera 'x-access-token'
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // Obtener el token guardado
      final token = getToken();

      print(token);
      
      // Si el token está disponible, agregarlo a la cabecera 'x-access-token'
      if (token != null) {
        options.headers['x-access-token'] = token;
      }
      return handler.next(options);
    },
  ));
  Map<String, dynamic> revToJson(review) {
    return {
      '_id': review.id,
      'title': review.title,
      'content': review.content,
      'stars': review.stars,
      'author': review.author,
      
     
      
      'review_deactivated': review.review_deactivated,
      'creation_date': review.creation_date,
      'modified_date': review.modified_date,
    };
  }
  try {
    var res = await dio.put('$baseUrl/review/$id', data: revToJson(review));
    print(res.data);
    print('akiiiiiiiiiiiiiiiii');
    Review responseData = res.data; // Obtener los datos de la respuesta
  
    // Convertir los datos en una lista de objetos Place
    //List<Review> reviews = responseData.map((data) => Review.fromJson(data)).toList();
  
    return responseData; // Devolver la lista de lugares
  } catch (e) {
    // Manejar cualquier error que pueda ocurrir durante la solicitud
    print('Error fetching data: $e');
    throw e; // Relanzar el error para que el llamador pueda manejarlo
  }
  
}
Future<List<User>> getUsers() async {
  print('getData');
  // Interceptor para agregar el token a la cabecera 'x-access-token'
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // Obtener el token guardado
      final token = getToken();

      print(token);
      
      // Si el token está disponible, agregarlo a la cabecera 'x-access-token'
      if (token != null) {
        options.headers['x-access-token'] = token;
      }
      return handler.next(options);
    },
  ));
  
  try {
    var res = await dio.get('$baseUrl/users');
    List<dynamic> responseData = res.data; // Obtener los datos de la respuesta
  
    // Convertir los datos en una lista de objetos Place
    List<User> users = responseData.map((data) => User.fromJson(data)).toList();
  
    return users; // Devolver la lista de lugares
  } catch (e) {
    // Manejar cualquier error que pueda ocurrir durante la solicitud
    print('Error fetching data: $e');
    throw e; // Relanzar el error para que el llamador pueda manejarlo
  }
}


  Future<int> logIn(logIn)async{
    print('LogIn');
    print('try');
    //Aquí llamamos a la función request
    print('request');
    
    Response response = await dio.post('$baseUrl/login', data: logInToJson(logIn));
    //En response guardamos lo que recibimos como respuesta
    //Printeamos los datos recibidos

    data = response.data.toString();
    print('Data: $data');
    //Printeamos el status code recibido por el backend

    statusCode = response.statusCode;
    print('Status code: $statusCode');

    if (statusCode == 200) {
      // Si el usuario se crea correctamente, retornamos el código 201
      saveToken(data);
      print('200');
      return 201;
    } else if (statusCode == 400) {
      // Si hay campos faltantes, retornamos el código 400
      print('400');

      return 400;
    } else if (statusCode == 500) {
      // Si hay un error interno del servidor, retornamos el código 500
      print('500');

      return 500;
    } else {
      // Otro caso no manejado
      print('-1');

      return -1;
    }
  }

  Map<String, dynamic> logInToJson(logIn) {
    return {
      'email': logIn.email,
      'password': logIn.password
    };
  }
}