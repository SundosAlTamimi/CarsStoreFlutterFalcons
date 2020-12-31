class MyOrdersModule {
  String vOHNO;
  String vOHTYPE;
  String vOHDATE;
  String vOHTOTAL;
  String vOHSERIAL;
  String oRDERSTATE;
  String uSERNOSERIAL;

  MyOrdersModule(
      {this.vOHNO,
        this.vOHTYPE,
        this.vOHDATE,
        this.vOHTOTAL,
        this.vOHSERIAL,
        this.oRDERSTATE,
        this.uSERNOSERIAL});

  MyOrdersModule.fromJson(Map<String, dynamic> json) {
    vOHNO = json['VOH_NO'];
    vOHTYPE = json['VOH_TYPE'];
    vOHDATE = json['VOH_DATE'];
    vOHTOTAL = json['VOH_TOTAL'];
    vOHSERIAL = json['VOH_SERIAL'];
    oRDERSTATE = json['ORDER_STATE'];
    uSERNOSERIAL = json['USER_NO_SERIAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VOH_NO'] = this.vOHNO;
    data['VOH_TYPE'] = this.vOHTYPE;
    data['VOH_DATE'] = this.vOHDATE;
    data['VOH_TOTAL'] = this.vOHTOTAL;
    data['VOH_SERIAL'] = this.vOHSERIAL;
    data['ORDER_STATE'] = this.oRDERSTATE;
    data['USER_NO_SERIAL'] = this.uSERNOSERIAL;
    return data;
  }
}
