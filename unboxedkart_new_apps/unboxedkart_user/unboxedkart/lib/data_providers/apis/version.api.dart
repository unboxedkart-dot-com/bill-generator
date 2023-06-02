import 'package:unboxedkart/data_providers/apis/api_calls.dart';
import 'package:unboxedkart/models/app_version.model.dart';

class VersionApi {
  ApiCalls apiCalls = ApiCalls();

  checkLatestVersion() async {
    final response =
        await apiCalls.get(url: "https://server.unboxedkart.com/app-version");
     
    final AppVersionModel appVersion = AppVersionModel.fromDoc(response);
    return appVersion;
  }
}
