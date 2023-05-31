import '../../data/shared_prefs/sharedpref_helper.dart';
import '../models/profile.dart';
import 'localdb/profile_datasource.dart';

class Repository {
  final SharedPreferenceHelper _sharedPreferenceHelper;
  final ProfileDataSource _profileDataSource;

  Repository(
    this._sharedPreferenceHelper,
    this._profileDataSource,
  );

  //Introduction screen functions

  bool? get checkIfIntroductionIsDone {
    return _sharedPreferenceHelper.checkIfIntroductionIsDone;
  }

  Future<bool> setIntroductionIsDone() {
    return _sharedPreferenceHelper.setIntroductionIsDone();
  }

  //Theme screen functions

  bool get isDarkMode {
    return _sharedPreferenceHelper.isDarkMode;
  }

  Future<void> changeThemeMode(bool value) {
    return _sharedPreferenceHelper.changeThemeMode(value);
  }

  //Language store

  String? get getCurrentLanguage {
    return _sharedPreferenceHelper.getCurrentLanguage;
  }

  Future<void> changeCurrentLanguage(String language) {
    return _sharedPreferenceHelper.changeLanguage(language);
  }

  //Profile Store
  //Profile Store
  bool? get getProfileInputDone {
    return _sharedPreferenceHelper.getProfileInputDone();
  }

  Future<bool> setProfileInputDone(bool value) {
    return _sharedPreferenceHelper.setProfileInputDone(value);
  }

  Future<ProfileModel?> getProfileData() {
    return _profileDataSource.getProfileData();
  }

  Future<dynamic> setProfileData(ProfileModel profileModel) {
    return _profileDataSource.setProfileData(profileModel);
  }
}
