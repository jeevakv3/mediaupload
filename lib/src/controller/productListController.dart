import 'package:mediaupload/src/apiService/apiService.dart';

import '../../allpackages.dart';

class ProductListController extends GetxController {
  List<ProdcutListResponse> productListResponse = <ProdcutListResponse>[].obs;
  var loading = false.obs;

  Future<void> fetchproductList() async {
    loadingbar(true, 'productList');
    var data = await ApiService().getData();
    if (data != null && data is List) {
      productListResponse =
          data.map((e) => ProdcutListResponse.fromJson(e)).toList();
      loadingbar(false, 'productList');
    }
    update(['productList']);
  }

  void loadingbar(value, type) {
    loading.value = value;
    print(loading.value);
    update([type]);
  }
}
