import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:football_fields_system/services/Provider.dart';
import 'package:football_fields_system/services/database_methods.dart';
import 'package:football_fields_system/widget&constants/constants.dart';
import 'package:football_fields_system/widget&constants/widgets.dart';

String playgroundName;
String description;
String playgroundAddress;
int price;

DatabaseMethods databaseMethods = DatabaseMethods();
PlaygroundModel playgroundModel = PlaygroundModel();

class AddFieldScreen extends StatelessWidget {

  setData(String playgroundID)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('idString', playgroundID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20.0),
        child: ListView(
          children: [
            Text('Add your Playground Data',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                foreground: Paint()..shader = klinearGradient,
              ),
            ),
            SizedBox(height: 20.0,),
            AuthTextField(
              hintText: 'Playground Name',
              icon: Icon(Icons.title),
              obscure: false,
              onChanged: (value){playgroundName=value;},
            ),
            SizedBox(height: 15.0,),
            AuthTextField(
              hintText: 'Description',
              icon: Icon(Icons.description),
              obscure: false,
              onChanged: (value){description = value;},
            ),
            SizedBox(height: 15.0,),
            AuthTextField(
              hintText: 'Address',
              icon: Icon(Icons.pin_drop_outlined),
              obscure: false,
              onChanged: (value){playgroundAddress = value;},
            ),
            SizedBox(height: 15.0,),
            AuthTextField(
              hintText: 'Price',
              icon: Icon(Icons.monetization_on),
              obscure: false,
              onChanged: (value){price = int.parse(value);},
            ),
            SizedBox(height: 20.0,),
            AuthButton(
              text: 'Add Playground',
              onPressed: ()async{
                print(Provider.of<UserModelUsed>(context,listen: false).usedUserModel.username); // using provider to get the data (username)
                print(Provider.of<UserModelUsed>(context,listen: false).savedPassword);// using provider to get the data (username)
                playgroundModel = await databaseMethods.addNewField(context,playgroundName, description, playgroundAddress, price); // here we call the function that send data of playground to data base
                setData(playgroundModel.id.toString());                  //here we take the id of the playground to save in our shared preferences
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
