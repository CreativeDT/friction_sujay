class ApiStrings {
  static const String baseUrl = 'http://172.16.116.137:8005/api/v1';
  //static const String baseUrl = 'http://172.16.116.65:8001/api/v1';
  static const String endpiont_login = '/user/user-login';
  static const String endpoint_create_activity = '/activity/add-activity';
  static const String endpoint_update_activity = '/activity/update-activity';
  static const String endpoint_get_all_activity = '/activity/get-all-activities';



  //create Activity field
static const String endpoint_get_all_service_techs = '/service-tech/get-all-service-techs';
  static const String endpoint_get_all_helpers = '/helper/get-all-helpers';
  static const String endpoint_get_all_activity_types = '/activity-type/get-all-activity-types';
  static const String endpoint_get_all_activity_status = '/activity-status/get-all-activity-status';
  // static const String endpoint_get_all_ = '';
  // static const String endpoint_get_all_ = '';

//User Profile
  static const String endpoint_get_user_profile = '/user/get-user-profile';
//Upload History
  static const String endpoint_get_upload_histories = '/upload-history/get-all-upload-history';


  //RailLocation Unit
static const String endpoint_get_all_rail_locations = '/rail-location/get-all-rail-locations';

// Daily Logs
static const String endpoint_get_daily_logs = '/daily-log/get-activity-daily-log';

// Service Techs
static const String endpoint_get_service_tech = '/service-tech/get-all-service-techs';
}