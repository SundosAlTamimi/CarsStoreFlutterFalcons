class ListItemCode {
  List<ItemCode> uSERSTORES;

  ListItemCode({this.uSERSTORES});

  ListItemCode.fromJson(Map<String, dynamic> json) {
    if (json['ADD_VOUCHER'] != null) {
      uSERSTORES = new List<ItemCode>();
      json['ADD_VOUCHER'].forEach((v) {
        uSERSTORES.add(new ItemCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uSERSTORES != null) {
      data['ADD_VOUCHER'] = this.uSERSTORES.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ItemCode {
  String itemOCode;
  String itemNameA;
  String itemNameE;
  String itemG;
  String salePrice;
  String qTY;
  String iTEMTOTAL;
  String vOHTYPE;
  String vOHTOTAL;
  String uSERNO;
  String uSERNOSERIAL;

  ItemCode(
      {this.itemOCode,
        this.itemNameA,
        this.itemNameE,
        this.itemG,
        this.salePrice,
        this.qTY,
        this.iTEMTOTAL,
        this.vOHTYPE,
        this.vOHTOTAL,
        this.uSERNO,
        this.uSERNOSERIAL});

  ItemCode.fromJson(Map<String, dynamic> json) {
    itemOCode = json['ItemOCode'];
    itemNameA = json['ItemNameA'];
    itemNameE = json['ItemNameE'];
    itemG = json['ItemG'];
    salePrice = json['SalePrice'];
    qTY = json['QTY'];
    iTEMTOTAL = json['ITEM_TOTAL'];
    vOHTYPE = json['VOH_TYPE'];
    vOHTOTAL = json['VOH_TOTAL'];
    uSERNO = json['USER_NO'];
    uSERNOSERIAL = json['USER_NO_SERIAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemOCode'] = this.itemOCode;
    data['ItemNameA'] = this.itemNameA;
    data['ItemNameE'] = this.itemNameE;
    data['ItemG'] = this.itemG;
    data['SalePrice'] = this.salePrice;
    data['QTY'] = this.qTY;
    data['ITEM_TOTAL'] = this.iTEMTOTAL;
    data['VOH_TYPE'] = this.vOHTYPE;
    data['VOH_TOTAL'] = this.vOHTOTAL;
    data['USER_NO'] = this.uSERNO;
    data['USER_NO_SERIAL'] = this.uSERNOSERIAL;
    return data;
  }
}
