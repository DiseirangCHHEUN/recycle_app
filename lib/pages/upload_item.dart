import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:recycle_app/services/database.dart';
import 'package:recycle_app/services/shared_pref.dart';
import 'package:recycle_app/styles/app_text_style.dart';
import 'package:recycle_app/core/utils/material_button.dart';

import '../core/utils/app_bar.dart';

class UploadItem extends StatefulWidget {
  const UploadItem({super.key});

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  TextEditingController addressController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  // Initialize ImagePicker
  final ImagePicker picker = ImagePicker();
  File? selectedImage; // Placeholder for image selection

  String? userId, username;
  getInfoFromSharedPref() async {
    // Implement your logic to get user info from shared preferences

    final id = await SharedPreferencesHelper().getUserId();
    final name = await SharedPreferencesHelper().getUserName();
    setState(() {
      userId = id;
      username = name;
    });
  }

  @override
  initState() {
    getInfoFromSharedPref();

    super.initState();
  }

  // Function to select an image
  Future<void> selectImage() async {
    try {
      var image = await picker.pickImage(source: ImageSource.gallery);
      selectedImage = File(image!.path);
      setState(() {
        // Update the UI with the selected image
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error selecting image: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // final categories = args?['categories'] ?? '';
    // final userId = args?['userId'] ?? '';

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyAppBar(appBarTitle: 'Upload Item'),
            const SizedBox(height: 10.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE9E9F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Text(
                      'Upload an image of the item you want to recycle',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          selectImage();
                        },
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child:
                                selectedImage != null
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.file(
                                        selectedImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                    : const Icon(
                                      Icons.add_a_photo,
                                      size: 50.0,
                                      color: Colors.black54,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Enter your address you want the item to be picked up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    buildUploadTextField(
                      icon: Icons.location_on,
                      controller: addressController,
                      hintText: 'Enter your address',
                      keyboardType: TextInputType.streetAddress,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    buildUploadTextField(
                      icon: Icons.inventory,
                      controller: quantityController,
                      hintText: 'Enter item quantity',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 30.0),
                    MyMaterialButton(
                      'Upload',
                      onTap: () {
                        // Handle button tap
                        try {
                          if (selectedImage != null &&
                              addressController.text.isNotEmpty &&
                              quantityController.text.isNotEmpty) {
                            String itemId = randomAlphaNumeric(10);

                            // Reference firebaseStorageRef = FirebaseStorage
                            //     .instance
                            //     .ref()
                            //     .child('blog_images')
                            //     .child('$itemId.jpg');

                            // // Upload the image to Firebase Storage
                            // final UploadTask task = firebaseStorageRef.putFile(
                            //   selectedImage!,
                            // );
                            // var downloadUrl =
                            //     await (await task).ref.getDownloadURL();

                            Map<String, dynamic> addItemInfo = {
                              'imageUrl': "",
                              'address': addressController.text.trim(),
                              'quantity': int.parse(
                                quantityController.text.trim(),
                              ),
                              'username': username,
                              'userId': userId,
                              'status': 'pending',
                            };

                            DatabaseMethods().addUserUploadItem(
                              addItemInfo,
                              userId!,
                              itemId,
                            );

                            DatabaseMethods().addAdminItem(addItemInfo, itemId);

                            // Clear the text fields
                            addressController.clear();
                            quantityController.clear();
                            selectedImage = null; // Reset the selected image
                            setState(() {}); // Update the UI
                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Image uploaded successfully!',
                                  style: AppTextStyle.whiteTextStyle(14),
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else if (selectedImage == null) {
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please select an image.'),
                              ),
                            );
                          } else if (addressController.text.isEmpty ||
                              quantityController.text.isEmpty) {
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill all fields.'),
                              ),
                            );
                          } else {
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please fill all fields and select an image.',
                                ),
                              ),
                            );
                          }
                        } catch (e) {
                          // Handle error if needed
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildUploadTextField({
    required IconData icon,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
