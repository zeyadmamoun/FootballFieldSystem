import 'package:flutter/material.dart';
import 'package:football_fields_system/services/database_methods.dart';
import 'package:football_fields_system/widget&constants/constants.dart';
import 'package:football_fields_system/widget&constants/widgets.dart';

// ignore: must_be_immutable
class EditBottomSheet extends StatelessWidget {

  int id ;
  EditBottomSheet({this.id});

  String playgroundName;
  String description;
  String playgroundAddress;
  int price;

  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20.0),
        child: ListView(
          children: [
            Text('Edit Playground Data',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                foreground: Paint()..shader = klinearGradient,
              ),
            ),
            SizedBox(height: 20.0,),
            AuthTextField(
              hintText: ' Name',
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
              text: 'Edit Info',
              onPressed: ()async{
                databaseMethods.updatePlaygroundData(context,playgroundName,description,playgroundAddress,price,id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
