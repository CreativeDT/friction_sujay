class ServiceTechData {

  int ServiceTechId;
  String? ServiceTechEmail= "";

  // Default values for parameters in the constructor
  ServiceTechData({this.ServiceTechId= 0,
    this.ServiceTechEmail = "",

  });

  factory ServiceTechData.fromJson(Map map) => ServiceTechData(
    ServiceTechId: map["ServiceTechId"],
    ServiceTechEmail: map["ServiceTechEmail"],

  );

  @override
  String toString() {
    return 'ServiceTechData{ ServiceTechId: $ServiceTechId, '
        'ServiceTechEmail: $ServiceTechEmail'

        '}';
  }
}