//
  // List<Asset> imagesList = <Asset>[];
  // List<Asset> resultList = <Asset>[];
  // Future<void> loadAssets(context) async {
  //   String error = 'No Error Detected';
  //
  //   try {
  //     resultList = await MultiImagePicker.pickImages(
  //       maxImages: 5,
  //       enableCamera: false,
  //       selectedAssets: imagesList,
  //       cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
  //       materialOptions: const MaterialOptions(
  //         actionBarColor: "#009E82",
  //         actionBarTitle: "Brain Tumor Detection",
  //         allViewTitle: "All Photos",
  //         useDetailsView: false,
  //         selectCircleStrokeColor: "#009E82",
  //       ),
  //     );
  //     resultList.forEach((imageAsset) async {
  //       final filePath =
  //           await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
  //
  //       File tempFile = File(filePath);
  //
  //       if (tempFile.existsSync()) {
  //         ImageFile.add(tempFile);
  //       }
  //       print("elbta3a ahy $ImageFile");
  //
  //     });
  //     imagesList = resultList;
  //     navigateTo(context, AfterUpload());
  //     print(resultList);
  //   } on Exception catch (e) {
  //     error = e.toString();
  //     print(e);
  //   }
  // }
  // List<XFile> imageFileList = [];
  // Future<void> getIamges() async {
  //   final List<XFile>? pickedFile = await picker.pickMultiImage();
  //   if (pickedFile!.isNotEmpty) {
  //     imageFileList.addAll(pickedFile);
  //   } else {
  //     print('No image selected.');
  //   }
  //   imageFileList.forEach((element) async {
  //     final filePath =
  //         await FlutterAbsolutePath.getAbsolutePath(element.path);
  //
  //     File tempFile = File(filePath);
  //
  //     if (tempFile.existsSync()) {
  //       ImageFile.add(tempFile);
  //       print(ImageFile);
  //       print(ImageFile[0].path);
  //     }
  //   });
  //
  // }
  //  Future uploadImageToServer(BuildContext context, {required name}) async {
  //   var uri = Uri.parse(
  //       "https://427c-156-196-7-89.eu.ngrok.io/upload?patientName='$name'");
  //   http.MultipartRequest request = http.MultipartRequest('POST', uri);
  //   List<http.MultipartFile> newList = <http.MultipartFile>[];
  //   for (int i = 0; i < imagesList.length; i++) {
  //     var path =
  //         await FlutterAbsolutePath.getAbsolutePath(imagesList[i].identifier);
  //     File imageFile = File(path);
  //
  //     var stream = http.ByteStream(imageFile.openRead());
  //     var length = await imageFile.length();
  //
  //     var multipartFile = http.MultipartFile("pictures", stream, length,
  //         filename: (imageFile.path));
  //     newList.add(multipartFile);
  //   }
  //
  //   request.files.addAll(newList);
  //   var response = await request.send();
  //   print(response.toString());
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     print("el value  ${value}");
  //   });
  //   if (response.statusCode == 200) {
  //     print('uploaded');
  //   } else {
  //     print('failed');
  //   }
  // }