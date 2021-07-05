import 'package:flutter/material.dart';
import 'package:football_fields_system/services/Provider.dart';
import 'package:football_fields_system/services/database_methods.dart';
import 'package:football_fields_system/widget&constants/widgets.dart';
import 'Field_description.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DatabaseMethods databaseMethods =DatabaseMethods();  //here the function contain get request
  PlaygroundModel playgroundModel =PlaygroundModel();  // variable sent to the above function
  List <PlaygroundModel>playgrounds = [];     // variable sent to the above function

  @override
  void initState() {
    super.initState();
    databaseMethods.getPlaygroundsList(playgroundModel,playgrounds).then((value) {
      setState(() {
        playgrounds = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: playgrounds.length == 0 ? Center(child: CircularProgressIndicator()):Padding(
        padding: const EdgeInsets.only(top: 70,left: 15.0, right: 15,bottom: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Nearby Fields in Your City',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black87,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 30.0,),
              AuthTextField(
                hintText: 'Search for nearby fields',
                icon: Icon(Icons.search),
                obscure: false,
                onChanged: (value){},
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(bottom: 0),
                height: MediaQuery.of(context).size.height*(2/3),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 0,bottom: 0),
                  itemCount: playgrounds.length,
                  itemBuilder: (context, index) {
                    return FieldCard(
                      name: playgrounds[index].name,
                      address: playgrounds[index].address,
                      image: 'images/Soccerfield-at-Night.jpg',
                      price: playgrounds[index].price.toString(),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FieldScreen(playgroundModel: playgrounds[index],)));
                      },
                    );
                  },
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}


