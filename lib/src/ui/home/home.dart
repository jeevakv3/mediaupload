import '../../../allpackages.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.put(ProductListController());

  @override
  void initState() {
    controller.fetchproductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Product listing',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),

      body: GetBuilder<ProductListController>(
          id: 'productList',
          builder: (_) {
            return controller.loading.value == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    itemCount: controller.productListResponse.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0),
                    itemBuilder: (BuildContext context, int index) {
                      var data = controller.productListResponse[index];
                      return InkWell(
                        onTap: () {
                          Get.to(ProductDetailScreen(data));
                        },
                        child: SizedBox(
                          height: 300,
                          child: Card(
                            elevation: 3.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(data.images![0]))),
                                  ),
                                  Text(
                                    data.title! ?? '-',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Price:${data.price.toString()}' ?? '-',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          }),

      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              decoration: BoxDecoration(
                color: Colors.black,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text(
                  "ProPlus Logics Solutions Pvt Ltd",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                accountEmail: Text(
                  "www.propluslogics.com",
                  style: TextStyle(color: Colors.white),
                ),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    "P",
                    style: TextStyle(fontSize: 30.0, color: Colors.black),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Product Listing'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Post product'),
              onTap: () {
                Get.to(PostProduct());
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                SharePreference().clearToken();
                Get.offAll(Login());
              },
            ),
          ],
        ),
      ), //Drawer
    );
  }
}
