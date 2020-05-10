import 'package:flutter/material.dart';
import 'package:flutter_crud_api_sample_app/src/ui/formadd/form_add_screen.dart';
import 'package:flutter_crud_api_sample_app/src/ui/home/home_screen.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.greenAccent,
        accentColor: Colors.greenAccent,

      ),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text(
            "Daftar Identitas Pendaftar",
            style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          flexibleSpace: Container (
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.greenAccent,
                ]
              ),
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  _scaffoldState.currentContext,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return FormAddScreen();
                  }),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add_circle,
                  color: Colors.white,


                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {},
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(Icons.add_circle,color: Colors.white)

        ),

        body:
        HomeScreen(),
      ),
    );
  }
}
