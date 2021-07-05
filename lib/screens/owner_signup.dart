import 'dart:io';
import 'package:football_fields_system/services/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:football_fields_system/screens/navigation_center.dart';
import 'package:football_fields_system/services/Provider.dart';
import 'package:football_fields_system/widget&constants/constants.dart';
import 'package:football_fields_system/widget&constants/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class OwnerSignupScreen extends StatefulWidget {

  @override
  _OwnerSignupScreenState createState() => _OwnerSignupScreenState();
}

class _OwnerSignupScreenState extends State<OwnerSignupScreen> {

  String username;
  String email;
  String password;
  String phone;
  bool isPlayer;
  bool isOwner;
  //bool accepted;
//////////////////////////////////////
  File _image;
  final picker = ImagePicker();
//////////////////////////////////////
  UserModel userModel = UserModel();
  AuthMethods authMethods = AuthMethods();
/////////////////////////////////////
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/11,),
                Text("Get Started",
                  style: ktextStyle1,
                ),
                Text("Owner account",
                  style: TextStyle(
                    color: Color(0xff6c6e7b),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/15,),
                AuthTextField(
                  hintText: 'Username',
                  icon: Icon(Icons.person,),
                  obscure: false,
                  onChanged: (value){username=value;},
                ),
                SizedBox(height: 20.0,),
                AuthTextField(
                  hintText: 'Email',
                  icon: Icon(Icons.email),
                  obscure: false,
                  onChanged: (value){email=value;},
                ),
                SizedBox(height: 20.0,),
                AuthTextField(
                  hintText: 'Password',
                  icon: Icon(Icons.lock),
                  obscure: true,
                  onChanged: (value){password=value;},
                ),
                SizedBox(height: 20.0,),
                AuthTextField(
                  hintText: 'Phone',
                  icon: Icon(Icons.phone),
                  obscure: false,
                  onChanged: (value){phone=value;},
                ),
                SizedBox(height: 30.0,),
                Container(
                  padding: const EdgeInsets.only(right: 30.0,left: 20),
                  child: Row(
                    children: [
                      Container(
                        padding:EdgeInsets.only(left: 20),
                        color: Colors.black12,
                        width: MediaQuery.of(context).size.width/3.5,
                        height:MediaQuery.of(context).size.height/5,
                        child: _image == null
                            ? Center(child: Text('No image selected.'))
                            : Image.file(_image,fit: BoxFit.cover,),
                      ),
                      Spacer(),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Text('Pick Image',style: TextStyle(color: Colors.white),),
                        color: Colors.teal,
                        onPressed: (){
                          getImage();
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    SizedBox(height: 10.0,),

                  ],
                ),
                AuthButton(text: 'Sign up',onPressed: ()async{
                  userModel = await authMethods.createUser(username, email, password, phone, Provider.of<Indicator>(context,listen: false).isOwner,Provider.of<Indicator>(context,listen: false).isPlayer);
                  Provider.of<UserModelUsed>(context,listen: false).setUserData(userModel);
                   Provider.of<UserModelUsed>(context,listen: false).saveUserPassword(password);
                  if(userModel != null){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationCenter()));
                  }
                },),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
