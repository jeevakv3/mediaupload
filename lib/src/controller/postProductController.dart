import 'package:mediaupload/src/apiService/apiService.dart';

import '../../allpackages.dart';

class PostProductController extends GetxController {
  Future<void> postProductListData() async {
    var queryParameter = {
      'ProductCode': '1',
      'ProductName': 'efwefe',
      'MRP': '23131',
      'PurchaseRate': '2',
      'SalesRate': '324',
      'ProductImage': ''
    };

    var data = await ApiService()
        .postData('products/create', queryParameter: queryParameter);
  }
}
