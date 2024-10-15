import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'recipe.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  List<String> ingredients = [];
  List<String> steps = [];
  File? _image; // Image file
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Recipe',
          style: TextStyle(fontSize: 21, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField('Recipe Name', (value) => name = value!),
              const SizedBox(height: 16),
              _buildTextField(
                'Ingredients (comma separated)',
                (value) => ingredients =
                    value!.split(',').map((e) => e.trim()).toList(),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Steps (comma separated)',
                (value) =>
                    steps = value!.split(',').map((e) => e.trim()).toList(),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: _image != null
                    ? Image.file(_image!,
                        height: 400, width: 400, fit: BoxFit.cover)
                    : Container(
                        height: 400,
                        width: 400,
                        color: Colors.grey[300],
                        child: const Icon(Icons.add_a_photo,
                            color: Colors.grey, size: 50),
                      ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(
                      context,
                      Recipe(
                        name: name,
                        ingredients: ingredients,
                        steps: steps,
                        imageUrl: _image?.path ?? '',
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text('Add Recipe',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      onSaved: onSaved,
    );
  }
}
