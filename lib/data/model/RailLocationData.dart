class RailLocationData {

  int Id;
  int RailUnitLocationId;
  String Division;
  String SubDivision;
  String MilePost;
  String RailRoad;
  String StateCode;
  String State;
  String Country;
  String UnitTypeCode;
  String UnitTypeName;
  String Manufacturer;
  String SingleDual;
  int Priority;
  String Latitude;
  String Longitude;
  String? Notes;
  bool Hyrail;
  bool SightDistance;
  bool RMU;
  int SerialNumber;
  String? PossibleStairsGateAccess;

  // Default values for parameters in the constructor
  RailLocationData({this.Id = 0,
    this.RailUnitLocationId = 0,
    this.Division = '',
    this.SubDivision = '',
    this.MilePost = "",
    this.RailRoad = "",
    this.StateCode = '',
    this.State = "",
    this.Country = "",
    this.UnitTypeCode = "",
    this.UnitTypeName = "",
    this.Manufacturer = "",
    this.SingleDual = "",
    this.Priority = 0,
    this.Latitude = "",
    this.Longitude = "",
    this.Notes = null,
    this.Hyrail = false,
    this.SightDistance = false,
    this.RMU = false,
    this.SerialNumber = 0,
    this.PossibleStairsGateAccess = null
  });

  factory RailLocationData.fromJson(Map map) =>
      RailLocationData(
          Id: map["Id"],
          RailUnitLocationId: map["RailUnitLocationId"],
          Division: map["Division"],
          SubDivision: map["SubDivision"],
          MilePost: map["MilePost"],
          RailRoad: map["RailRoad"],
          StateCode: map["StateCode"],
          State: map["State"],
          Country: map["Country"],
          UnitTypeCode: map["UnitTypeCode"],
          UnitTypeName: map["UnitTypeName"],
          Manufacturer: map["Manufacturer"],
          SingleDual: map["SingleDual"],
          Priority: map["Priority"],
          Latitude: map["Latitude"],
          Longitude: map["Longitude"],
          Notes: map["Notes"],
          Hyrail: map["Hyrail"],
          SightDistance: map["SightDistance"],
          RMU: map["RMU"],
          SerialNumber: map["SerialNumber"],
          PossibleStairsGateAccess: map["PossibleStairsGateAccess"]
      );

  @override
  String toString() {
    return 'RailLocationData{ id: $Id, '
        'RailUnitLocationId: $RailUnitLocationId,'
        'Division: $Division,'
        'SubDivision: $SubDivision,'
        'MilePost: $MilePost,'
        'RailRoad: $RailRoad,'
        'StateCode: $StateCode,'
        'State: $State,'
        'Country: $Country,'
        'UnitTypeCode: $UnitTypeCode,'
        'UnitTypeName: $UnitTypeName,'
        'Manufacturer: $Manufacturer'
        '}';
  }
}