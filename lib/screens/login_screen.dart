import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_fields_system/screens/account_type_screen.dart';
import 'package:football_fields_system/services/Authentication.dart';
import 'package:football_fields_system/services/Provider.dart';
import 'package:football_fields_system/widget&constants/constants.dart';
import 'package:football_fields_system/widget&constants/widgets.dart';
import 'package:provider/provider.dart';
import 'navigation_center.dart';

String username;
String password;
UserModel userModel = UserModel();
AuthMethods authMethods = AuthMethods();

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height/20,),
              Image.asset('images/Wavy_Spt-05_Single-01-[Converted].png'),
              Text('Welcome Back',
                style: ktextStyle1,
              ),
              SizedBox(height: 20.0,),
              AuthTextField(
                hintText: "Username",
                icon: Icon(Icons.email),
                obscure: false,
                onChanged: (value){username = value;},
              ),
              SizedBox(height: 20.0,),
              AuthTextField(
                hintText: "Password",
                icon: Icon(Icons.lock),
                obscure: true,
                onChanged: (value){password = value.toString();},
              ),
              SizedBox(height: 20.0,),
              AuthButton(
                text: 'Login',
                onPressed: ()async{
                  userModel =  await authMethods.loginMethod(username, password);
                  if(userModel != null){
                    print(userModel.isOwner);
                    Provider.of<Indicator>(context,listen: false).isOwner = userModel.isOwner;
                    Provider.of<UserModelUsed>(context,listen: false).setUserData(userModel);
                    Provider.of<UserModelUsed>(context,listen: false).saveUserPassword(password);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationCenter()));
                  }
                },
              ),
              SizedBox(height: 50.0,),
              Row(
                children: [
                  SizedBox(width: 75.0,),
                  Text("Don't Have an account?"),
                  TextButton(onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountTypeScreen()));
                  }, child: Text('Sign up',style: TextStyle(color: Colors.teal),))
                ],
              ),
            ],
          )
        ),
      )
    );
  }
}
