class InvestmentData {
  int id;
  List<Folios> folios;

  InvestmentData({this.id, this.folios});

  InvestmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    folios = <Folios>[];
    if (json['folios'] != null) {
      json['folios'].forEach((v) {
        folios.add(new Folios.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['folios'] = this.folios.map((v) => v.toJson()).toList();
    return data;
  }
}

class Folios {
  String folioNumber;
  List<Schemes> schemes;

  Folios({this.folioNumber, this.schemes});

  Folios.fromJson(Map<String, dynamic> json) {
    folioNumber = json['folio_number'];
    schemes = <Schemes>[];
    if (json['schemes'] != null) {
      json['schemes'].forEach((v) {
        schemes.add(new Schemes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['folio_number'] = this.folioNumber;
    data['schemes'] = this.schemes.map((v) => v.toJson()).toList();
    return data;
  }
}

class Schemes {
  String isin;
  String name;
  String type;
  Holdings holdings;
  MarketValue marketValue;
  InvestedValue investedValue;
  Payout payout;
  Nav nav;

  Schemes({
    this.isin,
    this.name,
    this.type,
    this.holdings,
    this.marketValue,
    this.investedValue,
    this.payout,
    this.nav,
  });

  Schemes.fromJson(Map<String, dynamic> json) {
    isin = json['isin'];
    name = json['name'];
    type = json['type'];
    holdings = Holdings.fromJson(json['holdings']);
    marketValue = MarketValue.fromJson(json['market_value']);
    investedValue = InvestedValue.fromJson(json['invested_value']);
    payout = Payout.fromJson(json['payout']);
    nav = Nav.fromJson(json['nav']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isin'] = this.isin;
    data['name'] = this.name;
    data['type'] = this.type;
    data['holdings'] = this.holdings.toJson();
    // data['market_value'] = this.marketValue.toJson();
    data['invested_value'] = this.investedValue.toJson();
    data['payout'] = this.payout.toJson();
    data['nav'] = this.nav.toJson();
    return data;
  }
}

class Holdings {
  String asOn;
  double units;
  double redeemableUnits;

  Holdings({
    this.asOn,
    this.units,
    this.redeemableUnits,
  });

  Holdings.fromJson(Map<String, dynamic> json) {
    asOn = json['as_on'];
    units = json['units'];
    redeemableUnits = json['redeemable_units'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['as_on'] = this.asOn;
    data['units'] = this.units;
    data['redeemable_units'] = this.redeemableUnits;
    return data;
  }
}

class MarketValue {
  String asOn;
  double amount;
  num redeemableAmount;

  MarketValue({
    this.asOn,
    this.amount,
    this.redeemableAmount,
  });

  MarketValue.fromJson(Map<String, dynamic> json) {
    asOn = json['as_on'];
    amount = json['amount'];
    redeemableAmount = json['redeemable_amount'];
  }

  // Map<String, dynamic> toJson()
}

class InvestedValue {
  String asOn;
  double amount;

  InvestedValue({this.asOn, this.amount});

  InvestedValue.fromJson(Map<String, dynamic> json) {
    asOn = json['as_on'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['as_on'] = this.asOn;
    data['amount'] = this.amount;
    return data;
  }
}

class Payout {
  String asOn;
  double amount;

  Payout({this.asOn, this.amount});

  Payout.fromJson(Map<String, dynamic> json) {
    asOn = json['as_on'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['as_on'] = this.asOn;
    data['amount'] = this.amount;
    return data;
  }
}

class Nav {
  String asOn;
  double value;

  Nav({this.asOn, this.value});

  Nav.fromJson(Map<String, dynamic> json) {
    asOn = json['as_on'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['as_on'] = this.asOn;
    data['value'] = this.value;
    return data;
  }
}
