import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urbanridertest/Constants/constants.dart';
import 'package:urbanridertest/CustomWidget/my_text_field.dart';
import 'package:urbanridertest/Services/database_service.dart';

class EditProfileScreen extends StatefulWidget {


  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String name = '',
      handle_name = '',
      ride_name = '',
      rider_name = '',
      fav_qoute = '',
      image_URL;

  TextEditingController nameController = TextEditingController();
  TextEditingController handle_nameController = TextEditingController();
  TextEditingController ride_nameController = TextEditingController();
  TextEditingController rider_nameController = TextEditingController();
  TextEditingController fav_qouteController = TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    DatabaseService databaseService = new DatabaseService();
    var userData = await databaseService.getUserData();

    name = userData["name"];
    ride_name = userData['ride_name'];
    rider_name = userData['rider_name'];
    fav_qoute = userData['fav_quote'];
    image_URL = userData['image_URL'];
    handle_name = userData["handle_name"];

    setState(() {
      nameController.text = name;
      handle_nameController.text = handle_name;
      ride_nameController.text = ride_name;
      rider_nameController.text = rider_name;
      fav_qouteController.text = fav_qoute;
    });
  }

  void saveData()async{
    DatabaseService databaseService = DatabaseService();
    var res = await databaseService.updateProfile(name, handle_name, ride_name, rider_name, fav_qoute);
  }

  void saveImage()async{
    DatabaseService databaseService = DatabaseService();
    String res = await databaseService.saveImage();
    setState(() {
      image_URL = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KMainThemeColors,
        title: Text('Edit profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              Stack(
                children: <Widget>[
                  image_URL==null?CircleAvatar(
                    radius: 50.0,
                    child: Icon(Icons.person,size: 70.0,color: KMainThemeColors,),
                    backgroundColor: Colors.blueGrey.shade50,
                  ):Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              offset: Offset(3, 3)),
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              offset: Offset(-1, -1)),
                        ],
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                image_URL))),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: CircleAvatar(
                      backgroundColor: KMainThemeColors,
                      child: GestureDetector(
                          onTap: (){
                            saveImage();
                          },
                          child: Icon(Icons.edit,color:Colors.white,size: 20.0,)),
                    ),
                  )
                ],
              ),

              Container(
                height: 1.0,
                color: Colors.blueGrey,
                margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
              ),
              MyTextField(
                labelText: 'Name',
                type: TextInputType.text,
                onChange: (val) {
                  name = val;
                },
                controller: nameController,
              ),
              MyTextField(
                labelText: 'Handle name',
                type: TextInputType.text,
                onChange: (val) {
                  handle_name = val;
                },
                controller: handle_nameController,
              ),
              MyTextField(
                labelText: 'Ride name',
                type: TextInputType.text,
                onChange: (val) {
                  ride_name = val;
                },
                controller: ride_nameController,
              ),
              MyTextField(
                labelText: 'Rider name',
                type: TextInputType.text,
                onChange: (val) {
                  rider_name = val;
                },
                controller: rider_nameController,
              ),
              MyTextField(
                labelText: 'Fav qoute',
                type: TextInputType.text,
                onChange: (val) {
                  fav_qoute = val;
                },
                controller: fav_qouteController,
              ),
              SizedBox(height: 30.0,),
              RaisedButton(
                child: Container(
                  child: Text('Save',style: TextStyle(color:Colors.white),),
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: KMainThemeColors,
                onPressed: (){
                  print(name);
                    if(name == '' || handle_name ==''){

                    }else{
                      saveData();
                    }
                },
              ),
              SizedBox(height: 30.0,),
            ],
          ),
        ),
      ),
    );
  }
}
