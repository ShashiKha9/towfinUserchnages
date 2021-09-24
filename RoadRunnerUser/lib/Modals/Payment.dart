class Payment{
  int id;
  int request_id;
  int promocode_id;
  int payment_id;
  int fixed;
  int distance;
  double commision;
  int discount;
  double tax;
  int wallet;
  double total;
  double payable;
  double provider_commission;
  double provider_pay;
Payment(
{this.id,
this.request_id,
this.promocode_id,
this.payment_id,
this.fixed,
this.distance,
this.commision,
this.discount,
this.tax,
this.wallet,
this.total,
this.payable,
this.provider_commission,
this.provider_pay,
});

Payment.fromJson(Map<String, dynamic> json) {
id = json['id'];
request_id = json['request_id'];
promocode_id = json['promocode_id'];
payment_id = json['payment_id'];
fixed = json['fixed'];
distance = json['distance'];
commision = double.parse(json['commision'].toString());
discount = json['discount'];
tax = json['tax'];
wallet = json['wallet'];
total = json['total'];
payable = json['payable'];
provider_commission = double.parse(json['provider_commission'].toString());
provider_pay = double.parse(json['provider_pay'].toString());

}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
data['request_id'] = this.request_id;
data['promocode_id'] = this.promocode_id;
data['payment_id'] = this.payment_id;
data['fixed'] = this.fixed;
data['distance'] = this.distance;
data['commision'] = this.commision;
data['discount'] = this.discount;
data['tax'] = this.tax;
data['wallet'] = this.wallet;
data['total'] = this.total;
data['payable'] = this.payable;
data['provider_commission'] = this.provider_commission;
data['provider_pay'] = this.provider_pay;
return data;
}
}
