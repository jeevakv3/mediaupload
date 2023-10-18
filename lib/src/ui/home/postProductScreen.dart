import 'dart:convert';
import 'dart:io';

import '../../../allpackages.dart';

class PostProduct extends StatefulWidget {
  const PostProduct({Key? key}) : super(key: key);

  @override
  State<PostProduct> createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
  TextEditingController productCodeController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  late VideoPlayerController _controller;
  late XFile? _videoFile;

  File? _imageFile;

  var postProductController = Get.put(PostProductController());

  @override
  void initState() {
    super.initState();
    postProductController.postProductListData();
    _controller = VideoPlayerController.file(File(''));
  }

  Future<void> pickAndEncodeFile(bool isImage) async {
    final picker = ImagePicker();
    final source = isImage ? ImageSource.gallery : ImageSource.camera;

    final pickerFile = isImage
        ? await picker.pickImage(source: source)
        : await picker.pickVideo(source: source);
    if (pickerFile != null) {
      if (isImage) {
        final file = File(pickerFile.path);
        setState(() {
          _imageFile = File(pickerFile.path);
        });
        final bytes = await file.readAsBytes();
        final encodedString = base64Encode(bytes);
        print('image----- $encodedString');
      } else {
        _videoFile = pickerFile;
        _controller = VideoPlayerController.file(File(pickerFile.path))
          ..initialize().then((value) {
            setState(() {});
          });
        VideoPlayerController videoPlayerController =
            VideoPlayerController.file(File(pickerFile.path));
        await videoPlayerController.initialize();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 17,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Post Product',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your Details',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey)),
                child: TextField(
                  controller: productCodeController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      border: InputBorder.none,
                      fillColor: Colors.grey,
                      labelText: "Product Code",
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
                  controller: productNameController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      border: InputBorder.none,
                      fillColor: Colors.grey,
                      labelText: "Product Name",
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
                  controller: productPriceController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      border: InputBorder.none,
                      fillColor: Colors.grey,
                      labelText: "Price",
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey)),
                child: TextField(
                  controller: productDescriptionController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      border: InputBorder.none,
                      fillColor: Colors.grey,
                      labelText: "  Description",
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {
                    pickAndEncodeFile(true);
                  },
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.red)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          _imageFile != null ? Icons.refresh : Icons.upload,
                          color: Colors.red,
                        ),
                        Text(
                          _imageFile != null
                              ? 'reupload'
                              : 'Upload product image/video',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _imageFile != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(_imageFile!),
                      ),
                    )
                  : Container(),
              _controller.value.isInitialized
                  ? Container(
                      height: 400,
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    )
                  : Container(),
              InkWell(
                onTap: () {
                  if (productCodeController.text.isEmpty ||
                      productNameController.text.isEmpty ||
                      productPriceController.text.isEmpty ||
                      productDescriptionController.text.isEmpty) {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Please enter all filed'),
                      duration: Duration(
                          seconds:
                              5), // Set the duration for how long the SnackBar is displayed
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (_imageFile == null) {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Pick Image/ Video'),
                      duration: Duration(
                          seconds:
                              5), // Set the duration for how long the SnackBar is displayed
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                          'Post Api Not working I Check PostMan also Please verfiy'),
                      duration: Duration(
                          seconds:
                              5), // Set the duration for how long the SnackBar is displayed
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Post',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.send_time_extension,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
