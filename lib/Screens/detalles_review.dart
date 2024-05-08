import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_seminario/Models/PostModel.dart';
import 'package:flutter_seminario/Screens/home_page.dart';
import 'package:flutter_seminario/Services/UserService.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart' ;
import 'dart:io';
class ReviewDetailsPage extends StatefulWidget {
  final Review place;

  const ReviewDetailsPage({Key? key, required this.place}) : super(key: key);

  @override
  _ReviewDetailsPageState createState() => _ReviewDetailsPageState(place: place);
}

class _ReviewDetailsPageState extends State<ReviewDetailsPage> {
  late Review _place;
  bool isEditing = false;
  late TextEditingController titleController;
  late TextEditingController contentController;
  late TextEditingController starsController;
  late DateTime now;

  _ReviewDetailsPageState({required Review place}) : _place = place;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: _place.title);
    contentController = TextEditingController(text: _place.content);
    starsController = TextEditingController(text: _place.stars);
    now = DateTime.now();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    starsController.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      isEditing = true;
    });
  }

  Future<void> _saveChanges() async {
    final updatedPlace = Review(
      id: _place.id,
      title: titleController.text,
      content: contentController.text,
      author: _place.author,
      stars: starsController.text,
      review_deactivated: _place.review_deactivated,
      creation_date: _place.creation_date,
      modified_date: now.toString(),
    );

    setState(() {
      _place = updatedPlace;
      isEditing = false;
    });

    try {
      await userService.putReviews(_place.id, updatedPlace);
    } catch (error) {
      print('Error al comunicarse con el backend: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Details'),
        actions: [
          if (!isEditing)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: _startEditing,
            ),
          if (isEditing)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveChanges,
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: isEditing
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: _place.title,
                    ),
                  ),
                  TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      labelText: 'Content',
                      hintText: _place.content,
                    ),
                    maxLines: null,
                  ),
                  TextField(
                    controller: starsController,
                    decoration: InputDecoration(
                      labelText: 'Stars',
                      hintText: _place.stars,
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${_place.title}'),
                  Text('Content: ${_place.content}'),
                  Text('Author: ${_place.author}'),
                  Text('Stars: ${_place.stars}'),
                  Text('Content: ${_place.review_deactivated}'),
                  Text('Author: ${_place.creation_date}'),
                ],
              ),
      ),
    );
  }
}