import 'package:flutter/material.dart';
import 'package:flutter_seminario/Models/PostModel.dart';
import 'package:flutter_seminario/Screens/detalles_review.dart';
import 'package:flutter_seminario/Screens/register_screen.dart';
import 'package:flutter_seminario/Screens/detalles_user.dart';

import 'package:flutter_seminario/Resources/pallete.dart';
import 'package:get/get.dart';


class ReviewWidget extends StatelessWidget {
  final Review place;

  const ReviewWidget({Key? key, required this.place}) : super(key: key);

  @override 
  Widget build(BuildContext context){
    return Card(
      child: ListTile(
        title: Text(place.title?? ''),
        subtitle: Text(place.content?? ''),
        trailing: Text('Author: ${place.author}'),
        onTap: () {
          Get.to(() => ReviewDetailsPage(place: place,));
        },
      ),
    );
  }
}
