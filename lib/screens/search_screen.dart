import 'package:flutter/material.dart';
import 'package:football_fields_system/services/Provider.dart';
import 'package:football_fields_system/services/database_methods.dart';
import 'package:football_fields_system/widget&constants/constants.dart';

import 'Field_description.dart';

// ignore: non_constant_identifier_names
List <PlaygroundModel> playgroundsData = [] ;

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  PlaygroundModel playgroundModel = PlaygroundModel();
  List<PlaygroundModel> playgrounds = [] ;

  @override
  void initState() {
    super.initState();
    databaseMethods.getPlaygroundsList(playgroundModel, playgrounds).then((value)  {
      playgroundsData= [] ;
      playgroundsData = value;
    });
    print(playgroundsData.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Search',),
        flexibleSpace: appBarStyle,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/5,),
            Image.asset('images/Search.png'),
            SizedBox(height: 10,),
            Text('Search for Playground',
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black38,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String>{

  @override
  List<Widget> buildActions(BuildContext context) {
    return[
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query = "";
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    var suggestions = playgroundsData ;
    var playgroundNames = [];
    var suggestion = playgroundNames.where((element) => element.startsWith(query));

    for(var p in playgroundsData){
      playgroundNames.add(p.name);
    }

    return ListView.builder(
      itemCount: suggestions.length,
        itemBuilder: (context,index){
      return ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> FieldScreen(playgroundModel: suggestions[index],)));
        },
        leading: Icon(Icons.location_on_outlined),
        title: Text(suggestions[index].name),
      );
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
  
}

