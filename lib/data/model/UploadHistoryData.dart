class UploadHistoryData {

  int UploadHistoryId;
  String UploadedDateTime;
  String ActivitySerialId;
  String ServiceTechEmail;
  String UploadType;
  bool Status;

  // Default values for parameters in the constructor
  UploadHistoryData({this.UploadHistoryId= 0,
    this.UploadedDateTime = "",
    this.ActivitySerialId= "",
    this.ServiceTechEmail= "",
    this.UploadType= "",
    this.Status= false,
  });

  factory UploadHistoryData.fromJson(Map map) => UploadHistoryData(
      UploadHistoryId: map["UploadHistoryId"],
      UploadedDateTime: map["UploadedDateTime"],
    ActivitySerialId: map["ActivitySerialId"],
      ServiceTechEmail: map["ServiceTechEmail"],
    UploadType: map["UploadType"],
    Status: map["Status"],

  );

}