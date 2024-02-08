class UserProfile {
  int? UserId;
  String? Email;
  String? FirstName;
  String? LastName;
  String? UserSource;
  String? Gender;
  String? Mobile;
  String? PhotoURL;
  bool? IsManager;
  bool? IsActive;
  String? ServiceTechId;
  // Default values for parameters in the constructor
  UserProfile({this.UserId,
    this.Email = "",
    this.FirstName= "",
    this.LastName= "",
    this.UserSource= "",
    this.Gender= "",
    this.Mobile= "",
    this.PhotoURL= "",
    this.IsManager,
    this.IsActive,
    this.ServiceTechId,
  });

  factory UserProfile.fromJson(Map map) => UserProfile(
      UserId: map["UserId"],
      Email: map["Email"],
      FirstName: map["FirstName"] ?? "",
      LastName: map["LastName"],
      UserSource: map["UserSource"],
      Gender: map["Gender"],
      Mobile: map["Mobile"],
      PhotoURL: map["PhotoURL"],
      IsManager: map["IsManager"],
      IsActive: map["IsActive"],
      ServiceTechId: map["ServiceTechId"]
  );

  @override
  String toString() {
    return 'ActivityData{ Email: $Email, '
        'FirstName: $FirstName,'
        '}';
  }
}