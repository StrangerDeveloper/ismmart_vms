class Stock {

  String? locationName;
  String? locationAddress;
  String? country;
  String? city;
  int? unavailable;
  int? onHand;
  int? available;
  int? committed;
  int? incoming;

  Stock({
    this.country,
    this.city,
    this.locationName,
    this.locationAddress,
    this.available,
    this.committed,
    this.incoming,
    this.onHand,
    this.unavailable
  });

  Stock.fromJson(Map<String,dynamic> json) {
    locationName = json['locationName'];
    locationAddress = json['locationAddress'];
    country = json['country'];
    city = json['city'];
    available = json['available'];
    unavailable = json['unavailable'];
    committed = json['committed'];
    onHand = json['onHand'];
    incoming = json['incoming'];
  }

  Map<String,dynamic> toJson() {
    final Map<String,dynamic> data = <String,dynamic>{};
    data['locationName'] = locationName;
    data['locationAddress'] = locationAddress;
    data['country'] = country;
    data['city'] = city;
    data['available'] = available;
    data['unavailable'] = unavailable;
    data['committed'] = committed;
    data['onHand'] = onHand;
    data['incoming'] = incoming;
    return data;
  }
}