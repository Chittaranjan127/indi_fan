// Package imports:
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:streamskit_mobile/core/app/constant/storage_keys.dart';
import 'package:streamskit_mobile/core/util/SharedPreferencesUtil.dart';

abstract class AuthLocalDataSource {
  String? getAccessToken() ;
  void saveAccessToken(String accessToken);
  void clearAccessToken();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  @override
  void clearAccessToken() {
    SharedPreferencesUtil.remove(StorageKeys.accessToken);
  }

  @override
  String getAccessToken() {
    return SharedPreferencesUtil.getString(StorageKeys.accessToken).toString();
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    SharedPreferencesUtil.saveString(StorageKeys.accessToken, accessToken);
  }
}
