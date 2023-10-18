import '../../../allpackages.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var controller = Get.put(LoginController());

  // @override
  // void initState() {
  //   super.initState();
  //   if (SharePreference().getToken() != null) {
  //     Get.offAll(Home());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<LoginController>(
          id: 'login',
          builder: (_) {
            return controller.loading.value == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 90,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey)),
                          child: TextField(
                            controller: userNameController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8.0),
                                border: InputBorder.none,
                                fillColor: Colors.grey,
                                labelText: "   UserName",
                                labelStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey)),
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8.0),
                                border: InputBorder.none,
                                fillColor: Colors.grey,
                                labelText: "  Password",
                                labelStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () {
                            if (userNameController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Please enter field'),
                                duration: Duration(
                                    seconds:
                                        5), // Set the duration for how long the SnackBar is displayed
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              controller.loginRequest(userNameController.text,
                                  passwordController.text);
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
          }),
    );
  }
}
