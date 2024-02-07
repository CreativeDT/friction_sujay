//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:friction/componants/ActivityData.dart';
import 'package:friction/data/model/DailyLogData.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class DownloadCenter{

  Future<void> activityDownload(List<ActivityData> data,) async {

    List<List<dynamic>> data1 = [
      ['ActivityTypeSerialId',
        'ServiceTechEmail',
        'EstimatedWorkStartDate',
        'EstimatedWorkEndDate',
        'ActualWorkStartDate',
        'ActualWorkEndDate',
        'ActualWorkStartLat',
        'ActualWorkStartLong',
        'ActualWorkEndLat',
        'ActualWorkEndLong',
        'MileageStart',
        'MileageEnd',
        'RailLocation',
        'ActivityType',
        'ActivityStatus',
        'CreatedBy'



      ],
    ];
    for( var i = 0; i<= data.length-1; i++ ){
      List<dynamic> item = [
        data[i].ActivityTypeSerialId,
        data[i].ServiceTechEmail,
        data[i].EstimatedWorkStartDate,
        data[i].EstimatedWorkEndDate,
        data[i].ActualWorkStartDate,
        data[i].ActualWorkEndDate,
        data[i].ActualWorkStartLat,
        data[i].ActualWorkStartLong,
        data[i].ActualWorkEndLat,
        data[i].ActualWorkEndLong,
        data[i].MileageStart,
        data[i].MileageEnd,
        data[i].RailLocation,
        data[i].ActivityType,
        data[i].ActivityStatus,
        data[i].CreatedBy

      ] ;
      data1.add(item);
    }
    if (data.toString() == "[]"){
      print("data empty");
    }else {
      print(data.toString());
      print("${data[0]}");
      print("${data[1]}");
    }

    String csv = const ListToCsvConverter().convert(data1);

    final Directory? directory = await getExternalStorageDirectory();
    final String path = directory!.path;

    const String fileName = 'ActivityData.csv';
    final String filePath = '$path/$fileName';

    File file = File(filePath);
    await file.writeAsString(csv);

    print("data download started at path: $filePath");


  }

  Future<void> logsDownload(List<DailyLogData> data,) async {

    List<List<dynamic>> data1 = [
      [ 'dailyLogId',
        'uploadedDateTime',
        'isSuccess',
        'isActive',
        'createdAt',
        'updatedAt',
        'activityId',
        'serviceTechEmail',
        'activityTypeSerialId',
        'estimatedWorkStartDate',
        'estimatedWorkEndDate',
        'actualWorkStartDate',
        'actualWorkEndDate',
        'isAmended',
        'actualWorkStartLat',
        'actualWorkStartLong',
        'actualWorkEndLat',
        'actualWorkEndLong',
        'truckId',
        'mileageStart',
        'mileageEnd',
        'serviceTechId',
        'railUnitLocationId',
        'activityTypeId',
        'activityStatusId',
        'createdBy',
        'id',
        'division',
        'subDivision',
        'milePost',
        'railRoad',
        'stateCode',
        'state',
        'country',
        'unitTypeCode',
        'unitTypeName',
        'manufacturer',
        'singleDual',
        'priority',
        'latitude',
        'longitude',
        'notes',
        'hyrail',
        'sightDistance',
        'rMU',
        'serialNumber',
        'possibleStairsGateAccess'

      ],
    ];
    for( var i = 0; i<= data.length-1; i++ ){
      List<dynamic> item = [
        data[i].dailyLogId,
        data[i].uploadedDateTime,
        data[i].isSuccess,
        data[i].isActive,
        data[i].createdAt,
        data[i].updatedAt,
        data[i].activityId,
        data[i].serviceTechEmail,
        data[i].activityTypeSerialId,
        data[i].estimatedWorkStartDate,
        data[i].estimatedWorkEndDate,
        data[i].actualWorkStartDate,
        data[i].actualWorkEndDate,
        data[i].isAmended,
        data[i].actualWorkStartLat,
        data[i].actualWorkStartLong,
        data[i].actualWorkEndLat,
        data[i].actualWorkEndLong,
        data[i].truckId,
        data[i].mileageStart,
        data[i].mileageEnd,
        data[i].serviceTechId,
        data[i].railUnitLocationId,
        data[i].activityTypeId,
        data[i].activityStatusId,
        data[i].createdBy,
        data[i].id,
        data[i].division,
        data[i].subDivision,
        data[i].milePost,
        data[i].railRoad,
        data[i].stateCode,
        data[i].state,
        data[i].country,
        data[i].unitTypeCode,
        data[i].unitTypeName,
        data[i].manufacturer,
        data[i].singleDual,
        data[i].priority,
        data[i].latitude,
        data[i].longitude,
        data[i].notes,
        data[i].hyrail,
        data[i].sightDistance,
        data[i].rMU,
        data[i].serialNumber,
        data[i].possibleStairsGateAccess
      ] ;
      data1.add(item);
    }
    if (data.toString() == "[]"){
      print("data empty");
    }else {
      print(data.toString());
      print("${data[0]}");
      print("${data[1]}");
    }

    String csv = const ListToCsvConverter().convert(data1);

    final Directory? directory = await getExternalStorageDirectory();
    final String path = directory!.path;

    const String fileName = 'DailyLogsData.csv';
    final String filePath = '$path/$fileName';

    File file = File(filePath);
    await file.writeAsString(csv);

    print("data download started at path: $filePath");


  }

}