class HistoryData {

  int UploadHistoryId;
  String? UploadedDateTime= "";
  int ActivityId;
  int UploadTypeId;

  // Default values for parameters in the constructor
  HistoryData({this.UploadHistoryId= 0,
    this.UploadedDateTime = "",
    this.ActivityId= 0,
    this.UploadTypeId= 0,
  });

  factory HistoryData.fromJson(Map map) => HistoryData(
      UploadHistoryId: map["UploadHistoryId"],
      UploadedDateTime: map["UploadedDateTime"],
      ActivityId: map["ActivityId"],
      UploadTypeId: map["UploadTypeId"],

  );

  @override
  String toString() {
    return 'HistoryData{ UploadHistoryId: $UploadHistoryId, '
        'UploadedDateTime: $UploadedDateTime,'
        'ActivityId: $ActivityId, '
        'UploadTypeId: $UploadTypeId'
        '}';
  }
}