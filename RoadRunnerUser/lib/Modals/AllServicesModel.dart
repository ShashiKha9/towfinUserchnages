class AllServicesModel{
  int id;
  String name;
  String providerName;
  String image;
  int capacity;
  int fixed;
  int price;
  int minute;
  int distance;
  String calculator;
  String description;
  int status;


  AllServicesModel(
      {this.id,
        this.name,
        this.providerName,
        this.image,
        this.capacity,
        this.fixed,
        this.price,
        this.minute,
        this.distance,
        this.calculator,
        this.description,
        this.status});

  AllServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    providerName = json['provider_name'];
    image = json['image'];
    capacity = int.parse(json['capacity'].toString());
    fixed = int.parse(json['fixed'].toString());
    price = int.parse(json['price'].toString());
    minute = int.parse(json['minute'].toString());
    distance = int.parse(json['distance'].toString());
    calculator = json['calculator'];
    description = json['description'];
    status = int.parse(json['status'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['provider_name'] = this.providerName;
    data['image'] = this.image;
    data['capacity'] = this.capacity;
    data['fixed'] = this.fixed;
    data['price'] = this.price;
    data['minute'] = this.minute;
    data['distance'] = this.distance;
    data['calculator'] = this.calculator;
    data['description'] = this.description;
    data['status'] = this.status;
    return data;
  }
}