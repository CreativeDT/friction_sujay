
class ActivityRequestData {
String? estimatedWorkStartDate;
String? estimatedWorkEndDate;
String? actualWorkStartDate;
String? actualWorkEndDate;
bool? isAmended;
String? actualWorkStartLat;
String? actualWorkStartLong;
String? actualEndWorkLat;
String? actualWorkEndLong;
String? truckId;
String? mileageStart;
String? mileageEnd;
String? serviceTechId;
String? railUnitLocationId;
String? activityTypeId;
String? activityStatusId;
String? createdById;

ActivityRequestData(
{this.estimatedWorkStartDate,
this.estimatedWorkEndDate,
this.actualWorkStartDate="16/03/2024 11:03:10",
this.actualWorkEndDate= "16/03/2024 13:03:10",
this.isAmended = true,
this.actualWorkStartLat= "-88.34061",
this.actualWorkStartLong= "-88.34061",
this.actualEndWorkLat= "-88.34061",
this.actualWorkEndLong= "-88.34061",
this.truckId="1245",
this.mileageStart= "4521",
this.mileageEnd = "4521",
this.serviceTechId,
this.railUnitLocationId,
this.activityTypeId,
this.activityStatusId = "1",
this.createdById= "1"});

ActivityRequestData.fromJson(Map<String, dynamic> json) {
estimatedWorkStartDate = json['estimatedWorkStartDate'];
estimatedWorkEndDate = json['estimatedWorkEndDate'];
actualWorkStartDate = json['actualWorkStartDate'];
actualWorkEndDate = json['actualWorkEndDate'];
isAmended = json['isAmended'];
actualWorkStartLat = json['actualWorkStartLat'];
actualWorkStartLong = json['actualWorkStartLong'];
actualEndWorkLat = json['actualEndWorkLat'];
actualWorkEndLong = json['actualWorkEndLong'];
truckId = json['truckId'];
mileageStart = json['mileageStart'];
mileageEnd = json['mileageEnd'];
serviceTechId = json['serviceTechId'];
railUnitLocationId = json['railUnitLocationId'];
activityTypeId = json['activityTypeId'];
activityStatusId = json['activityStatusId'];
createdById = json['createdById'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['estimatedWorkStartDate'] = this.estimatedWorkStartDate;
data['estimatedWorkEndDate'] = this.estimatedWorkEndDate;
data['actualWorkStartDate'] = this.actualWorkStartDate;
data['actualWorkEndDate'] = this.actualWorkEndDate;
data['isAmended'] = this.isAmended;
data['actualWorkStartLat'] = this.actualWorkStartLat;
data['actualWorkStartLong'] = this.actualWorkStartLong;
data['actualEndWorkLat'] = this.actualEndWorkLat;
data['actualWorkEndLong'] = this.actualWorkEndLong;
data['truckId'] = this.truckId;
data['mileageStart'] = this.mileageStart;
data['mileageEnd'] = this.mileageEnd;
data['serviceTechId'] = this.serviceTechId;
data['railUnitLocationId'] = this.railUnitLocationId;
data['activityTypeId'] = this.activityTypeId;
data['activityStatusId'] = this.activityStatusId;
data['createdById'] = this.createdById;
return data;
}
}