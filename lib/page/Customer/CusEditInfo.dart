import 'dart:io';
import 'dart:ui';
import 'package:doan_cuahangbansach/data/model/customer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Assume CusModel is defined somewhere in your project
// import 'package:book_selling_app/page/Model/Customer/CusModel.dart';

class CusEditInfo extends StatefulWidget {
  const CusEditInfo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CusEditInfoState createState() => _CusEditInfoState();
}

class _CusEditInfoState extends State<CusEditInfo> {
  File? _backgroundImage;
  File? _avatarImage;

  // Example CusModel
  Customer cusModel = Customer(
    idCus: 1,
    fullNameCus: 'Dogbee',
    addressCus: '828 Sư Vạn Hạnh',
    emailCus: 'dogbee@gmail.com',
    phoneNumCus: '(+84) 9xx xxx xxx',
    genderCus: 'Nam',
  );

  Future<void> _pickBackgroundImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _backgroundImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickAvatarImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin người dùng"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickBackgroundImage,
              child: Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(80),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  image: _backgroundImage != null && _backgroundImage is File
                    ? DecorationImage(
                        image: FileImage(_backgroundImage as File),
                        fit: BoxFit.cover,
                      )
                    : _backgroundImage != null && _backgroundImage is String
                        ? DecorationImage(
                            image: AssetImage(_backgroundImage as String),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage('assets/images/background.jpeg'),
                            fit: BoxFit.cover,
                          ),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(80),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey.shade400,
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black),
                          onPressed: _pickBackgroundImage,
                        ),
                      ),
                    ),
                    Center(
                      child: Positioned(
                        child: GestureDetector(
                          onTap: _pickAvatarImage,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: _avatarImage != null
                                ? FileImage(_avatarImage!)
                                : const NetworkImage(
                                    'https://www.dog-on-it-parks.com/blog/wp-content/uploads/2018/06/Sting-300x225.jpg',
                                  ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey.shade400,
                                child: IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.black),
                                  onPressed: _pickAvatarImage,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildInfoForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Tên đầy đủ',
            initialValue: cusModel.fullNameCus!,
            onChanged: (value) {
              setState(() {
                cusModel.fullNameCus = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Địa chỉ',
            initialValue: cusModel.addressCus!,
            onChanged: (value) {
              setState(() {
                cusModel.addressCus = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Email',
            initialValue: cusModel.emailCus!,
            onChanged: (value) {
              setState(() {
                cusModel.emailCus = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Số điện thoại',
            initialValue: cusModel.phoneNumCus.toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                cusModel.phoneNumCus = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Giới tính',
            initialValue: cusModel.genderCus!,
            onChanged: (value) {
              setState(() {
                cusModel.genderCus = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _showSaveConfirmationDialog();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Lưu thông tin'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
      controller: TextEditingController(text: initialValue),
      keyboardType: keyboardType,
    );
  }

  void _showSaveConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Thông tin đã được lưu',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Go back to previous screen (CusInfo)
                  },
                  child: const Text('Đồng ý'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
