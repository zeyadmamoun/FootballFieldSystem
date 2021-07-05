import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;
import 'Provider.dart';

class DatabaseMethods {

  Future<dynamic> addNewField(BuildContext context,String playgroundName,String description,String playgroundAddress,int price)async{

    final String apiUrl = 'https://fbrs.herokuapp.com/fb/playgrounds';
    final username = Provider.of<UserModelUsed>(context,listen: false).usedUserModel.username;
    var password =  Provider.of<UserModelUsed>(context,listen: false).savedPassword;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var body = jsonEncode({
      "name": playgroundName,
      "price": price,
      "description": description,
      "address": playgroundAddress
    });
    try{
      http.Response response = await http.post(Uri.parse(apiUrl),
        headers: {
          "content-type":"application/json",
          "authorization": basicAuth
        },
        body: body,
      );
      print(response.body);
      if(response.statusCode == 201){
        return PlaygroundModel.fromJson(jsonDecode(response.body));
      }else{
        return null;
      }
    }catch(e){
      print(e);
    }
  }
///////////////////////////// update data function /////////////////////////////////////////////////////////

  Future<dynamic> updatePlaygroundData(BuildContext context ,String name,String description,String address,int price,int id)async{
    final username = Provider.of<UserModelUsed>(context,listen: false).usedUserModel.username;
    var password =  Provider.of<UserModelUsed>(context,listen: false).savedPassword;
    final String apiUrl = 'https://fbrs.herokuapp.com/fb/playgrounds/$id';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var body = jsonEncode({
      "name":name,
      "description":description,
      "address":address,
      "price":price
    });
    try{
      http.Response response = await http.put(Uri.parse(apiUrl),
          headers: {
            "content-type":"application/json",
            "authorization": basicAuth
          },
          body: body
      );
      print(response.statusCode);
      if(response.statusCode == 204){
        Navigator.pop(context);
      }
    }catch(e){
      print(e);
    }
  }
  /////////////////////////////////////function to return list of playgrounds///////////////////////////////////////////

  Future<dynamic> getPlaygroundsList(PlaygroundModel playgroundModel,List <PlaygroundModel>playgrounds )async{
    final String apiUrl = 'https://fbrs.herokuapp.com/fb/playgrounds';
    try{
      http.Response response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200){
        List<dynamic> jsonData = jsonDecode(response.body);
        for(var playground in jsonData){
          playgroundModel = PlaygroundModel.fromJson(playground);
          playgrounds.add(playgroundModel);
        }
      }
    }catch(e){
      print(e);
    }
    return playgrounds ;
  }

///////////////////////////////////function to post (reserve) an hour////////////////////////////////////////////

  Future <dynamic> reserveHour (BuildContext context ,DateTime reservationData,int playgroundID) async {
    final apiUrl = "https://fbrs.herokuapp.com/fb/reserve_h/$playgroundID";
    final username = Provider.of<UserModelUsed>(context,listen: false).usedUserModel.username;
    var password =  Provider.of<UserModelUsed>(context,listen: false).savedPassword;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var body = jsonEncode({
      "reserved_hour":'${reservationData.month} ${reservationData.day} ${reservationData.year} ${reservationData.hour}'
    });

    try{
      http.Response response = await http.post(Uri.parse(apiUrl),
        headers: {
          "content-type":"application/json",
          "authorization": basicAuth
        },
        body: body,
      );
      if(response.statusCode == 201){
        return response.body;
      }
    }catch(e){
      print(e);
    }
  }
}


