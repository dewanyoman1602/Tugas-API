import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_crud_api_sample_app/src/api/api_service.dart';
import 'package:flutter_crud_api_sample_app/src/model/profile.dart';
import 'package:flutter_crud_api_sample_app/src/ui/formadd/form_add_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext context;
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getProfiles(),
        builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Profile> profiles = snapshot.data;
            return _buildListView(profiles);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Profile> profiles) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Profile profile = profiles[index];

          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              color: Colors.greenAccent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.only(
                        right: 18,
                        top: 10.0,
                        left: 12,
                        bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          border: Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Umur :",
                          style: TextStyle(
                            color: Colors.white70,fontSize: 12.0,
                            fontFamily: 'Varela',
                          ),),
                          Text(profile.age.toString()),
                        ],
                      )
                    ),//UNTUK UMURNYA

                    Container(
                        padding: EdgeInsets.only(
                            right: 18,
                            top: 10.0,
                            left: 12,
                            bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          border: Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Nama : ",
                              style: TextStyle(
                                color: Colors.white70,fontSize: 12.0,
                                fontFamily: 'Varela',
                              ),),
                            Text(profile.name,),
                          ],
                        )
                    ),//UNTUK NAMANYA

                    Container(
                        padding: EdgeInsets.only(
                            right: 18,
                            top: 10.0,
                            left: 12,
                            bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          border: Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Email : ",
                              style: TextStyle(
                                color: Colors.white70,fontSize: 12.0,
                                fontFamily: 'Varela',
                              ),),
                            Text(profile.email,),
                          ],
                        )
                    ),//UNTUK EMAILNYA




                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Warning !!"),
                                    content: Text(
                                        "Apa anda yakin ingin menghapus profil data ${profile.name}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          apiService
                                              .deleteProfile(profile.id)
                                              .then((isSuccess) {
                                            if (isSuccess) {
                                              setState(() {});
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Pengahapusan data berhasil !")));
                                            } else {
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Penghapusan data gagal")));
                                            }
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.block,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FormAddScreen(profile: profile);
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.border_color,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: profiles.length,
      ),
    );
  }
}
