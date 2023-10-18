import 'package:mediaupload/src/apiService/apiService.dart';

import '../../allpackages.dart';

class LoginController extends GetxController {
  var loading = false.obs;

  Future<void> loginRequest(String userName, String password) async {
    loadingbar(true, 'login');
    var input = {'email': userName, 'password': password};
    var data = await ApiService().postData('login', queryParameter: input);
    print('token---');
    print(data['data']['token']);
    if (data['status'] == true) {
      String token = data['data']['token'].toString();
      await SharePreference().saveToken(token);
      Get.to(const Home());
      loadingbar(false, 'login');
    }
    update(['login']);
  }

  void loadingbar(value, type) {
    loading.value = value;
    print(loading.value);
    update([type]);
  }
}
