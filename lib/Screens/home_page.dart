// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_seminario/Screens/home_users.dart';
import 'package:flutter_seminario/Screens/home_reviews.dart';
import 'package:flutter_seminario/Resources/pallete.dart';
import 'package:flutter_seminario/Screens/register_screen.dart';
import 'package:flutter_seminario/Screens/login_screen.dart';
import 'package:flutter_seminario/Services/UserService.dart';
import 'package:flutter_seminario/Models/UserModel.dart';
import 'package:flutter_seminario/Widgets/post copy.dart';


import 'package:flutter_svg/flutter_svg.dart';


import 'package:get/get.dart';
late UserService userService;

class HomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomePage({super.key});

  @override
  State<HomePage> createState() => _nameState();
}

// ignore: camel_case_types
class _nameState extends State<HomePage> {
  late List<User> lista_users ;

  bool isLoading = true; // Nuevo estado para indicar si se están cargando los datos

  @override
  void initState() {
    super.initState();
    userService = UserService();
    getData();
  }
  int _selectedIndex = 0;
void getData() async {
    try {
      lista_users = await userService.getUsers();
      setState(() {
        isLoading = false; // Cambiar el estado de carga cuando los datos están disponibles
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
 /*  void navigationBar(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  final List<Widget> _pages = [
    UserListPage(),
  ]; */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        // ignore: prefer_const_constructors
        title: Center(child: Text('DEMO FLUTTER',),),
        elevation: 0,
        leading: Builder(
          builder: (context) =>IconButton(
            icon: Icon(
            Icons.menu,
            color: Pallete.salmonColor,
            ),
            onPressed: (){
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        //backgroundColor: Pallete.greyColor,
        child: Column(
          children: [
            DrawerHeader(
              child: SvgPicture.asset(
                'assets/logo.svg',
                
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(
                color:Pallete.backgroundColor,
              ),
            ),
            Padding(
              
              //onPressed:NavigationDestination(icon: icon, label: label),
              padding: EdgeInsets.only(left:25.0),
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                  ),
                onTap: () {
                  Get.to(() => HomePage());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:25.0),
              child: ListTile(
                leading: Icon(
                  Icons.book,
                  color: Colors.white,

                ),
                title: Text(
                'Post',
                style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to(() => ReviewListPage());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:25.0),
              child: ListTile(
                leading: Icon(
                  Icons.flood_outlined,
                  color: Colors.white,

                ),
                title: Text(
                'Places',
                style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to(() => UserListPage());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:25.0),
              child: ListTile(
                leading: Icon(
                  Icons.book,
                  color: Colors.white,

                ),
                title: Text(
                  'Log In',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to(() =>LoginScreen());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:25.0),
              child: ListTile(
                leading: Icon(
                  Icons.ad_units,
                  color: Colors.white,

                ),
                title: Text(
                'Register',
                style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to(() =>RegisterScreen());
                },
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child:
                UserWidget(user: lista_users[index]),
            );
          },
          itemCount: lista_users.length,
        ),
    );
  }
}