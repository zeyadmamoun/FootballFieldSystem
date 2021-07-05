import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:football_fields_system/services/Provider.dart';
import 'package:football_fields_system/widget&constants/constants.dart';
import 'package:football_fields_system/widget&constants/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import 'edit_bottom_sheet.dart';

class OwnerFieldsScreen extends StatefulWidget {

  @override
  _OwnerFieldsScreenState createState() => _OwnerFieldsScreenState();
}

class _OwnerFieldsScreenState extends State<OwnerFieldsScreen> {

  String lastPlaygroundId;
  List<String> ownerPlaygroundsList ;
  //////////////////first fun variables
  PlaygroundModel playgroundModel = PlaygroundModel();
  List <PlaygroundModel> playgroundsModels =[] ;

  Future<dynamic> setListOfPlaygrounds()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    lastPlaygroundId = preferences.getString('idString');
    ownerPlaygroundsList = preferences.getStringList('idList');
    var counter = 0 ;

    if(ownerPlaygroundsList == null && lastPlaygroundId == null){
      ownerPlaygroundsList = [];
    }else if(ownerPlaygroundsList == null && lastPlaygroundId != null){
      ownerPlaygroundsList = [];
      ownerPlaygroundsList.add(lastPlaygroundId);
    }else{
      for(int i = 0 ; i < ownerPlaygroundsList.length;++i){
        if(lastPlaygroundId == ownerPlaygroundsList[i]){
          break;
        }else{
          counter++;
        }
      }
      if(counter == ownerPlaygroundsList.length){
        ownerPlaygroundsList.add(lastPlaygroundId);
      }
    }
    preferences.setStringList('idList', ownerPlaygroundsList);
    var testList = preferences.getStringList('idList');
    print(testList.runtimeType);
    print(testList);
    return testList;
  }

  Future<dynamic>getPlaygroundsData(List<String> playgroundsIDList)async{
    for(int i = 0; i < playgroundsIDList.length; ++i ){
      var apiUrl = 'https://fbrs.herokuapp.com/fb/playgrounds/${playgroundsIDList[i]}';
      print(apiUrl);
      try{
        http.Response response = await http.get(Uri.parse(apiUrl));
        if(response.statusCode == 200){
          var body = jsonDecode(response.body);
          playgroundModel = PlaygroundModel.fromJson(body);
          playgroundsModels.add(playgroundModel);
        }
      }catch(e){
        print(e);
      }
    }
    return playgroundsModels;
  }

  @override
  void initState() {
    // TODO: implement initState
      super.initState();
      setListOfPlaygrounds().then((value) => getPlaygroundsData(value).then((value) {
        setState(() {
          playgroundsModels = value;
          print(playgroundsModels.length);
        });
      } ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tap on Playgrounds to update ',),
        flexibleSpace: appBarStyle,
      ),
      body: playgroundsModels.length == 0 ? Center(child: CircularProgressIndicator()) : ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: playgroundsModels.length,
        itemBuilder: (context, index) {
          return FieldCard(
            name: playgroundsModels[index].name,
            address: playgroundsModels[index].address,
            image: 'images/Soccerfield-at-Night.jpg',
            price: playgroundsModels[index].price.toString(),
            onTap: (){
              showBottomSheet(context: context, builder: (context)=>EditBottomSheet(id: playgroundsModels[index].id,));
            },
          );
        },
      )
    );
  }
}


