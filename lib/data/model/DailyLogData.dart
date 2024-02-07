class DailyLogData {
  int? dailyLogId;
  String? uploadedDateTime;
  int? isSuccess;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  int? activityId;
  String? serviceTechEmail;
  String? activityTypeSerialId;
  String? estimatedWorkStartDate;
  String? estimatedWorkEndDate;
  String? actualWorkStartDate;
  String? actualWorkEndDate;
  int? isAmended;
  String? actualWorkStartLat;
  String? actualWorkStartLong;
  String? actualWorkEndLat;
  String? actualWorkEndLong;
  int? truckId;
  String? mileageStart;
  String? mileageEnd;
  int? serviceTechId;
  int? railUnitLocationId;
  int? activityTypeId;
  int? activityStatusId;
  int? createdBy;
  int? id;
  String? division;
  String? subDivision;
  String? milePost;
  String? railRoad;
  String? stateCode;
  String? state;
  String? country;
  String? unitTypeCode;
  String? unitTypeName;
  String? manufacturer;
  String? singleDual;
  int? priority;
  String? latitude;
  String? longitude;
  String? notes;
  int? hyrail;
  int? sightDistance;
  int? rMU;
  int? serialNumber;
  String? possibleStairsGateAccess;

  DailyLogData(
      {this.dailyLogId,
        this.uploadedDateTime,
        this.isSuccess,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.activityId,
        this.serviceTechEmail,
        this.activityTypeSerialId,
        this.estimatedWorkStartDate,
        this.estimatedWorkEndDate,
        this.actualWorkStartDate,
        this.actualWorkEndDate,
        this.isAmended,
        this.actualWorkStartLat,
        this.actualWorkStartLong,
        this.actualWorkEndLat,
        this.actualWorkEndLong,
        this.truckId,
        this.mileageStart,
        this.mileageEnd,
        this.serviceTechId,
        this.railUnitLocationId,
        this.activityTypeId,
        this.activityStatusId,
        this.createdBy,
        this.id,
        this.division,
        this.subDivision,
        this.milePost,
        this.railRoad,
        this.stateCode,
        this.state,
        this.country,
        this.unitTypeCode,
        this.unitTypeName,
        this.manufacturer,
        this.singleDual,
        this.priority,
        this.latitude,
        this.longitude,
        this.notes,
        this.hyrail,
        this.sightDistance,
        this.rMU,
        this.serialNumber,
        this.possibleStairsGateAccess});

  DailyLogData.fromJson(Map<String, dynamic> json) {
    dailyLogId = json['DailyLogId'];
    uploadedDateTime = json['UploadedDateTime'];
    isSuccess = json['IsSuccess'];
    isActive = json['IsActive'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    activityId = json['ActivityId'];
    serviceTechEmail = json['ServiceTechEmail'];
    activityTypeSerialId = json['ActivityTypeSerialId'];
    estimatedWorkStartDate = json['EstimatedWorkStartDate'];
    estimatedWorkEndDate = json['EstimatedWorkEndDate'];
    actualWorkStartDate = json['ActualWorkStartDate'];
    actualWorkEndDate = json['ActualWorkEndDate'];
    isAmended = json['IsAmended'];
    actualWorkStartLat = json['ActualWorkStartLat'];
    actualWorkStartLong = json['ActualWorkStartLong'];
    actualWorkEndLat = json['ActualWorkEndLat'];
    actualWorkEndLong = json['ActualWorkEndLong'];
    truckId = json['TruckId'];
    mileageStart = json['MileageStart'];
    mileageEnd = json['MileageEnd'];
    serviceTechId = json['ServiceTechId'];
    railUnitLocationId = json['RailUnitLocationId'];
    activityTypeId = json['ActivityTypeId'];
    activityStatusId = json['ActivityStatusId'];
    createdBy = json['CreatedBy'];
    id = json['Id'];
    division = json['Division'];
    subDivision = json['SubDivision'];
    milePost = json['MilePost'];
    railRoad = json['RailRoad'];
    stateCode = json['StateCode'];
    state = json['State'];
    country = json['Country'];
    unitTypeCode = json['UnitTypeCode'];
    unitTypeName = json['UnitTypeName'];
    manufacturer = json['Manufacturer'];
    singleDual = json['SingleDual'];
    priority = json['Priority'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    notes = json['Notes'];
    hyrail = json['Hyrail'];
    sightDistance = json['SightDistance'];
    rMU = json['RMU'];
    serialNumber = json['SerialNumber'];
    possibleStairsGateAccess = json['PossibleStairsGateAccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DailyLogId'] = this.dailyLogId;
    data['UploadedDateTime'] = this.uploadedDateTime;
    data['IsSuccess'] = this.isSuccess;
    data['IsActive'] = this.isActive;
    data['CreatedAt'] = this.createdAt;
    data['UpdatedAt'] = this.updatedAt;
    data['ActivityId'] = this.activityId;
    data['ServiceTechEmail'] = this.serviceTechEmail;
    data['ActivityTypeSerialId'] = this.activityTypeSerialId;
    data['EstimatedWorkStartDate'] = this.estimatedWorkStartDate;
    data['EstimatedWorkEndDate'] = this.estimatedWorkEndDate;
    data['ActualWorkStartDate'] = this.actualWorkStartDate;
    data['ActualWorkEndDate'] = this.actualWorkEndDate;
    data['IsAmended'] = this.isAmended;
    data['ActualWorkStartLat'] = this.actualWorkStartLat;
    data['ActualWorkStartLong'] = this.actualWorkStartLong;
    data['ActualWorkEndLat'] = this.actualWorkEndLat;
    data['ActualWorkEndLong'] = this.actualWorkEndLong;
    data['TruckId'] = this.truckId;
    data['MileageStart'] = this.mileageStart;
    data['MileageEnd'] = this.mileageEnd;
    data['ServiceTechId'] = this.serviceTechId;
    data['RailUnitLocationId'] = this.railUnitLocationId;
    data['ActivityTypeId'] = this.activityTypeId;
    data['ActivityStatusId'] = this.activityStatusId;
    data['CreatedBy'] = this.createdBy;
    data['Id'] = this.id;
    data['Division'] = this.division;
    data['SubDivision'] = this.subDivision;
    data['MilePost'] = this.milePost;
    data['RailRoad'] = this.railRoad;
    data['StateCode'] = this.stateCode;
    data['State'] = this.state;
    data['Country'] = this.country;
    data['UnitTypeCode'] = this.unitTypeCode;
    data['UnitTypeName'] = this.unitTypeName;
    data['Manufacturer'] = this.manufacturer;
    data['SingleDual'] = this.singleDual;
    data['Priority'] = this.priority;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['Notes'] = this.notes;
    data['Hyrail'] = this.hyrail;
    data['SightDistance'] = this.sightDistance;
    data['RMU'] = this.rMU;
    data['SerialNumber'] = this.serialNumber;
    data['PossibleStairsGateAccess'] = this.possibleStairsGateAccess;
    return data;
  }
}
