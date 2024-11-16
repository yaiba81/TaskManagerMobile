import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateTaskForm extends StatefulWidget {
  final Function updateTask;

  const UpdateTaskForm(this.updateTask, {super.key});

  @override
  State<UpdateTaskForm> createState() => _UpdateTaskFormState();
}

class _UpdateTaskFormState extends State<UpdateTaskForm> {
  final _remarksController = TextEditingController();

  String _status = "Done";
  File? _selectedImage;

  void _takePictureFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  void _submitData() {
    final remarks = _remarksController.text;

    List<int> imageBytes = _selectedImage!.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    widget.updateTask(_status, remarks, base64Image, DateTime.now());
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _status = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                'Update Task',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            DropdownButton(items: const [
              DropdownMenuItem(
                  value: "In Progress", child: Text("In Progress")),
              DropdownMenuItem(value: "Done", child: Text("Done")),
            ], isExpanded: true, value: _status, onChanged: dropdownCallback),
            TextField(
              decoration: const InputDecoration(labelText: 'Remarks'),
              controller: _remarksController,
              onSubmitted: (_) => _submitData(),
            ),
            _status == "Done"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: _takePicture,
                        icon: const Icon(Icons.camera),
                        label: const Text('Camera'),
                      ),
                      TextButton.icon(
                        onPressed: _takePictureFromGallery,
                        icon: const Icon(Icons.browse_gallery),
                        label: const Text('Gallery'),
                      ),
                    ],
                  )
                : const SizedBox(
                    height: 10,
                  ),
            Container(
              child: _selectedImage != null
                  ? Image.file(_selectedImage!)
                  : const SizedBox(
                      height: 10,
                    ),
            ),
            _status == 'Done' && _selectedImage != null ||
                    _status == 'In Progress'
                ? ElevatedButton(
                    onPressed: () => _submitData(), child: const Text("Submit"))
                : const SizedBox(
                    height: 10,
                  ),
          ],
        ),
      ),
    );
  }
}
