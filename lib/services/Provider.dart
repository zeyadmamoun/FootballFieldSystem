import 'package:flutter/cupertino.dart';

class Indicator extends ChangeNotifier{

  int indicator;
  bool isOwner;
  bool isPlayer;

  void setOwnerFlag(int indicator){   //this function determines if it is owner or not from the indicator if it = 1 then it is player
    if(indicator== 1){
      isOwner = false;
      isPlayer = !isOwner;
    }else{
      isOwner = true;
      isPlayer = !isOwner;
    }
    print(isPlayer);
    print(isOwner);
    notifyListeners();
  }

  void changeIndicator(newValue){
    indicator=newValue;
    notifyListeners();
  }
}    //provider to reach for account type

/////////////////////////////////////////////////////////////////////

class UserModel {                                     //class to receive the data of user from requests
  int id;
  String password;
  String username;
  String email;
  String profilePic;
  String phone;
  bool isOwner;
  bool isPlayer;

  UserModel(
      {this.id,
        this.password,
        this.username,
        this.email,
        this.profilePic,
        this.phone,
        this.isOwner,
        this.isPlayer,
    });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    username = json['username'];
    email = json['email'];
    profilePic = json['profile_pic'];
    phone = json['phone'];
    isOwner = json['is_owner'];
    isPlayer = json['is_player'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    data['username'] = this.username;
    data['email'] = this.email;
    data['profile_pic'] = this.profilePic;
    data['phone'] = this.phone;
    data['is_owner'] = this.isOwner;
    data['is_player'] = this.isPlayer;

    return data;
  }
}        //registration response format

class UserModelUsed extends ChangeNotifier{       //to change some local data in the app like profile screens
  UserModel usedUserModel;
  String savedPassword;
  void setUserData(UserModel userModel){
    usedUserModel = userModel;
    notifyListeners();
  }
  void saveUserPassword(wannaSavePassword){
    savedPassword = wannaSavePassword;
    notifyListeners();
  }
}  //registration response provider to send everywhere in the project


////////////////////////////////////////////////////////////////////////class to receive the data of playground from requests
class PlaygroundModel {
  int id;
  String name;
  String photo;
  int price;
  String description;
  String address;
  int owner;

  PlaygroundModel(
      {this.id,
        this.name,
        this.photo,
        this.price,
        this.description,
        this.address,
        this.owner});

  PlaygroundModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    price = json['price'];
    description = json['description'];
    address = json['address'];
    owner = json['owner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['price'] = this.price;
    data['description'] = this.description;
    data['address'] = this.address;
    data['owner'] = this.owner;
    return data;
  }
}