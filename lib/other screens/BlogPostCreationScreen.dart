import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:contentmanagement/ services/funtions.dart';

import '../HomePage.dart';
class BlogPostCreationScreen extends StatefulWidget {
  @override
  _BlogPostCreationScreenState createState() => _BlogPostCreationScreenState();
}

class _BlogPostCreationScreenState extends State<BlogPostCreationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final picker = ImagePicker();

  funtions functions1 = funtions();

  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }


  @override
  void dispose() {

    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Blog Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: 8,
              decoration: InputDecoration(
                labelText: 'Content',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Add Image'),
            ),
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_selectedImage != null) {
                  await functions1.uploadPostWithPicture(
                    title: _titleController.text,
                    content: _contentController.text,
                    author: "Author Name",
                    timestamp: DateTime.now(),
                    imageFile: _selectedImage!,
                  );
                } else {
                  // Handle case when no image is selected
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Text('Create Blog Post'),
            ),
          ],
        ),
      ),
    );
  }
}
