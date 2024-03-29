class ActivityData {

  int ActivityId= 1;
  String? ActivityTypeSerialId= "10000";
  String? EstimatedWorkStartDate= "12/03/2023 11:03:10";
  String? EstimatedWorkEndDate= "13/03/2023 13:03:10";
  String? ActualWorkStartDate= "12/03/2023 11:03:10";
  String? ActualWorkEndDate= "13/03/2023 13:03:10";
  String? ActualWorkStartLat= "41.74585";
  String? ActualWorkStartLong= "-88.34061";
  String? ActualWorkEndLat= "-88.34061";
  String? ActualWorkEndLong= "-88.34061";
  String? MileageStart= "4321";
  String? MileageEnd= "4521";
  String? ServiceTechEmail= "1232@testing.com";
  String? RailLocation= "Burlington Northern";
  String? Division = "CHICAGO";
  String? SubDivision = "AURORA";
  String? MilePost = "39.1";
  String? Helper = null;
  String? ActivityType= "Audit Survey";
  String? ActivityStatus= "Not Started";
  String? CreatedBy= "sandeep.kiran@global-csg.com";
  // Default values for parameters in the constructor
  ActivityData({this.ActivityTypeSerialId = '96589',
                  this.ServiceTechEmail = 'james.j.gantzer@loram.com',
                  this.ActivityId = 1,
                  this.EstimatedWorkStartDate = "",
                  this.EstimatedWorkEndDate = "",
                  this.ActualWorkStartDate = "",
                  this.ActualWorkEndDate = "",
                  this.ActualWorkStartLat = "",
                  this.ActualWorkStartLong ="",
    this.RailLocation = "",
    this.Division = "",
    this.SubDivision = "",
    this.MilePost = "",
  });

  factory ActivityData.fromJson(Map map) => ActivityData(
      ActivityId: map["ActivityId"],
      ActivityTypeSerialId: map["ActivityTypeSerialId"],
      ServiceTechEmail: map["ServiceTechEmail"],
      EstimatedWorkStartDate: map["EstimatedWorkStartDate"],
      EstimatedWorkEndDate: map["EstimatedWorkEndDate"],
      ActualWorkStartDate: map["ActualWorkStartDate"],
      ActualWorkEndDate: map["ActualWorkEndDate"],
      ActualWorkStartLat: map["ActualWorkStartLat"],
      ActualWorkStartLong: map["ActualWorkStartLong"],
      RailLocation: map["RailRoad"],
    Division: map["Division"],
    SubDivision: map["SubDivision"],
    MilePost: map["MilePost"]

  );

  @override
  String toString() {
    return 'ActivityData{ ServiceTechEmail: $ServiceTechEmail, ActivityTypeSerialId: $ActivityTypeSerialId}';
  }
}