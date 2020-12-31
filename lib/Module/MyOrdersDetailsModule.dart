class MyOrdersDetailsModule {
  String iTEMOCODE;
  String iTEMNAMEA;
  String iTEMNAMEE;
  String iTEMG;
  String sALESPRICE;
  String qTY;
  String vOHNO;
  String iTEMTOTAL;
  String vOHTYPE;
  String vOHDATE;
  String vOHTOTAL;
  String uSERNO;
  String uSERNOSERIAL;
  String vOHSERIAL;
  String oRDERSTATE;

  MyOrdersDetailsModule(
      {this.iTEMOCODE,
        this.iTEMNAMEA,
        this.iTEMNAMEE,
        this.iTEMG,
        this.sALESPRICE,
        this.qTY,
        this.vOHNO,
        this.iTEMTOTAL,
        this.vOHTYPE,
        this.vOHDATE,
        this.vOHTOTAL,
        this.uSERNO,
        this.uSERNOSERIAL,
        this.vOHSERIAL,
        this.oRDERSTATE});

  MyOrdersDetailsModule.fromJson(Map<String, dynamic> json) {
    iTEMOCODE = json['ITEMOCODE'];
    iTEMNAMEA = json['ITEMNAMEA'];
    iTEMNAMEE = json['ITEMNAMEE'];
    iTEMG = json['ITEMG'];
    sALESPRICE = json['SALES_PRICE'];
    qTY = json['QTY'];
    vOHNO = json['VOH_NO'];
    iTEMTOTAL = json['ITEM_TOTAL'];
    vOHTYPE = json['VOH_TYPE'];
    vOHDATE = json['VOH_DATE'];
    vOHTOTAL = json['VOH_TOTAL'];
    uSERNO = json['USER_NO'];
    uSERNOSERIAL = json['USER_NO_SERIAL'];
    vOHSERIAL = json['VOH_SERIAL'];
    oRDERSTATE = json['ORDER_STATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ITEMOCODE'] = this.iTEMOCODE;
    data['ITEMNAMEA'] = this.iTEMNAMEA;
    data['ITEMNAMEE'] = this.iTEMNAMEE;
    data['ITEMG'] = this.iTEMG;
    data['SALES_PRICE'] = this.sALESPRICE;
    data['QTY'] = this.qTY;
    data['VOH_NO'] = this.vOHNO;
    data['ITEM_TOTAL'] = this.iTEMTOTAL;
    data['VOH_TYPE'] = this.vOHTYPE;
    data['VOH_DATE'] = this.vOHDATE;
    data['VOH_TOTAL'] = this.vOHTOTAL;
    data['USER_NO'] = this.uSERNO;
    data['USER_NO_SERIAL'] = this.uSERNOSERIAL;
    data['VOH_SERIAL'] = this.vOHSERIAL;
    data['ORDER_STATE'] = this.oRDERSTATE;
    return data;
  }
}
