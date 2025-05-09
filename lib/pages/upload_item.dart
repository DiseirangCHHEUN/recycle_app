import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recycle_app/widgets/material_button.dart';

class UploadItem extends StatefulWidget {
  const UploadItem({super.key});

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // Initialize ImagePicker
  final ImagePicker picker = ImagePicker();
  File? selectedImage; // Placeholder for image selection

  // Function to select an image
  Future<void> selectImage() async {
    try {
      var image = await picker.pickImage(source: ImageSource.gallery);
      selectedImage = File(image!.path);
      setState(() {
        // Update the UI with the selected image
      });
    } catch (e) {
      // Handle error if needed
      print('Error selecting image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final categories = args?['categories'] ?? '';
    // final id = args?['id'] ?? '';

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15.0),
          buildUploadAppBar(context, categories),
          const SizedBox(height: 10.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFFE9E9F9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: ListView(
                children: [
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Material(
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 5.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.green),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: TextField(
                              controller: addressController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your address',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Material(
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 5.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person_rounded, color: Colors.green),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter item name',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Quantity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Material(
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 5.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.inventory_rounded, color: Colors.green),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: TextField(
                              controller: quantityController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter item quantity',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Material(
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 5.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Icon(
                              Icons.edit_rounded,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.start,
                              controller: descriptionController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter item description',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  MButton(
                    'Upload',
                    onTap: () {
                      // Handle button tap
                      print('Upload Item button tapped');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildUploadAppBar(BuildContext context, String categories) {
    return SizedBox(
      height: 50.0,
      child: Row(
        children: [
          const SizedBox(width: 20.0),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(100.0),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Text(
            'Upload $categories image',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
