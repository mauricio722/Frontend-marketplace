import 'package:easybuy_frontend/src/providers/profileProvider.dart';

class ProfilePageController {
  ProfilePageProvider profileProvider;

  ProfilePageController() {
    profileProvider = ProfilePageProvider();
  }

  Future<Map> updateUser(idUser, data) async {
    return await profileProvider.updateUser(idUser, data);
  }

   Future<Map> getUserInformation(email)async{
    return await profileProvider.getUserInformation(email);
  }
}
