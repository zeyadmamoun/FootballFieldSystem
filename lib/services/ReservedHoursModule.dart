class ReservedHours {
  int id;
  String name;
  Null photo;
  int price;
  String description;
  String address;
  int owner;
  String ownerName;
  List<ReservedHour> reservedHour;

  ReservedHours(
      {this.id,
        this.name,
        this.photo,
        this.price,
        this.description,
        this.address,
        this.owner,
        this.ownerName,
        this.reservedHour});

  ReservedHours.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    price = json['price'];
    description = json['description'];
    address = json['address'];
    owner = json['owner'];
    ownerName = json['owner_name'];
    if (json['reserved_hour'] != null) {
      reservedHour = new List<ReservedHour>();
      json['reserved_hour'].forEach((v) {
        reservedHour.add(new ReservedHour.fromJson(v));
      });
    }
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
    data['owner_name'] = this.ownerName;
    if (this.reservedHour != null) {
      data['reserved_hour'] = this.reservedHour.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReservedHour {
  int id;
  String reservedHour;
  int playgroundId;
  int player;

  ReservedHour({this.id, this.reservedHour, this.playgroundId, this.player});

  ReservedHour.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reservedHour = json['reserved_hour'];
    playgroundId = json['playground_id'];
    player = json['player'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reserved_hour'] = this.reservedHour;
    data['playground_id'] = this.playgroundId;
    data['player'] = this.player;
    return data;
  }
}