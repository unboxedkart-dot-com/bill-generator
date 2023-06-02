import 'package:version/version.dart';

class AppVersionModel {
  var version;
  var minAppVersion;
  final String description;

  AppVersionModel({this.version, this.minAppVersion, this.description});

  factory AppVersionModel.fromDoc(doc) {
    return (AppVersionModel(
      description: doc['description'],
      minAppVersion: Version.parse(doc['minAppVersion']),
      version: Version.parse(doc['version']),
    ));
  }
}
