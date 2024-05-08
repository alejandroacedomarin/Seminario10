// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_seminario/Models/PostModel.dart';
import 'package:flutter_seminario/Screens/home_page.dart';
import 'package:flutter_seminario/Screens/detalles_user.dart';
import 'package:flutter_seminario/Widgets/review.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_seminario/Services/UserService.dart';
import 'package:dio/dio.dart';

late UserService userService;

class ReviewListPage extends StatefulWidget {
  ReviewListPage({Key? key}) : super(key: key);

  @override
  _ReviewListPage createState() => _ReviewListPage();
}

class _ReviewListPage extends State<ReviewListPage> {
  late List<Review> lista_reviews;
  late TextEditingController authorController; // Controlador para el campo de búsqueda
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    userService = UserService();
    authorController = TextEditingController(); // Inicializar el controlador
    getData();
  }

  void getData() async {
    try {
      // Obtener las revisiones del autor especificado
      lista_reviews = await userService.getReviews(authorController.text);
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      Get.snackbar(
        'Error',
        'No se han podido obtener los datos.',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error al comunicarse con el backend: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Reviews List')),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.turn_left,
              color: Colors.black,
            ),
            onPressed: () {
              Get.to(HomePage());
            },
          ),
        ),
        actions: [
          // Agregar un botón de búsqueda que llame a getData al hacer clic
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              getData();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Agregar un campo de entrada de texto para ingresar el autor
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: authorController,
              decoration: InputDecoration(
                labelText: 'Buscar por autor',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // Agregar un botón de búsqueda
          ElevatedButton(
            onPressed: () {
              getData();
            },
            child: Text('Buscar'),
          ),
          // Agregar un indicador de carga si los datos todavía se están cargando
          if (isLoading)
            CircularProgressIndicator()
          else
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ReviewWidget(place: lista_reviews[index]),
                  );
                },
                itemCount: lista_reviews.length,
              ),
            ),
        ],
      ),
    );
  }
}