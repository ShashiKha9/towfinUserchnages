class OptionsData {
  List<CarDataContentList> carDataContentList;
  String color;
  String locationType;
  String make;
  String modal;
  String modalYear;
  String serviceTypeId;
  String subServiceName;
  int subServiceId;
  String vechileNo;
  String vinNumber;

  OptionsData(
      {this.carDataContentList,
        this.color,
        this.locationType,
        this.make,
        this.modal,
        this.modalYear,
        this.serviceTypeId,
        this.subServiceName,
        this.subServiceId,
        this.vechileNo,
        this.vinNumber});

  OptionsData.fromJson(Map<String, dynamic> json) {
    if (json['carDataContentList'] != null) {
      carDataContentList = new List<CarDataContentList>();
      json['carDataContentList'].forEach((v) {
        carDataContentList.add(new CarDataContentList.fromJson(v));
      });
    }
    color = json['color'];
    locationType = json['location_type'];
    make = json['make'];
    modal = json['modal'];
    modalYear = json['modal_year'];
    serviceTypeId = json['service_type_id'];
    subServiceName = json['subServiceName'];
    subServiceId = int.parse(json['subService_id'].toString());
    vechileNo = json['vechile_no'];
    vinNumber = json['vin_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carDataContentList != null) {
      data['carDataContentList'] =
          this.carDataContentList.map((v) => v.toJson()).toList();
    }
    data['color'] = this.color;
    data['location_type'] = this.locationType;
    data['make'] = this.make;
    data['modal'] = this.modal;
    data['modal_year'] = this.modalYear;
    data['service_type_id'] = this.serviceTypeId;
    data['subServiceName'] = this.subServiceName;
    data['subService_id'] = this.subServiceId;
    data['vechile_no'] = this.vechileNo;
    data['vin_number'] = this.vinNumber;
    return data;
  }
}

class CarDataContentList {
  String spairParts;
  bool tyreFourSelected;
  bool tyreOneSelected;
  bool tyreThreeSelected;
  bool tyreTwoSelected;

  CarDataContentList(
      {this.spairParts,
        this.tyreFourSelected,
        this.tyreOneSelected,
        this.tyreThreeSelected,
        this.tyreTwoSelected});

  CarDataContentList.fromJson(Map<String, dynamic> json) {
    spairParts = json['spair_parts'];
    tyreFourSelected = json['tyre_four_selected'];
    tyreOneSelected = json['tyre_one_selected'];
    tyreThreeSelected = json['tyre_three_selected'];
    tyreTwoSelected = json['tyre_two_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spair_parts'] = this.spairParts;
    data['tyre_four_selected'] = this.tyreFourSelected;
    data['tyre_one_selected'] = this.tyreOneSelected;
    data['tyre_three_selected'] = this.tyreThreeSelected;
    data['tyre_two_selected'] = this.tyreTwoSelected;
    return data;
  }
}