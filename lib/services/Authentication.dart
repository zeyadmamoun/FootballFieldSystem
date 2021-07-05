import 'dart:convert';
import 'Provider.dart';
import 'package:http/http.dart'as http;

class AuthMethods{
  ///////////////Registration function///////////////////////////////
  // ignore: missing_return
  Future<UserModel> createUser(String username,String email,String password,String phone,var isOwner,var isPlayer)async{
    final String apiUrl = 'https://fbrs.herokuapp.com/fb/register';
    final body = {
      "username": username,
      "password": password,
      "email": email,
      "is_owner": isOwner.toString(),
      "is_player":isPlayer.toString(),
      "phone": phone
    };
    try{
      http.Response response = await http.post(Uri.parse(apiUrl),body: body);
      if(response.statusCode == 200 ){
        print(response.body);
        if(response.body != '409'){
          return UserModel.fromJson(jsonDecode(response.body));
        }else{
          return null;
        }
      }
    }catch(e){
      print(e);
    }
  }
  ////////////////////////////////////////Login Function////////////////////////////////////////////


  Future <dynamic> loginMethod(String username,String password)async{
    final String apiUrl = 'https://fbrs.herokuapp.com/fb/member/login';
    final body ={
      "username": username,
      "password": password.toString()
    };
    try{
      http.Response response = await http.post(Uri.parse(apiUrl),body: body);
      if(response.statusCode==200){
        print(response.body);
        if(response.body!='404'){
          return UserModel.fromJson(jsonDecode(response.body));
        }else{
          return null;
        }
      }
    }catch(e){
      print(e);
    }
  }
}