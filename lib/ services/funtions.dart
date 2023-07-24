
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class funtions {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadPostWithPicture({
    required String title,
    required String content,
    required String author,
    required DateTime timestamp,
    required File imageFile,
  }) async {
    try {
      final currentUser = _auth.currentUser;
      final userId = currentUser!.uid;

      final newPostRef = _firestore.collection('blog_posts').doc();

      final blogPostData = {
        'id': newPostRef.id,
        'title': title,
        'content': content,
        'author': userId,
        'timestamp': timestamp,
      };

      if(imageFile != null){


        await newPostRef.set(blogPostData);

        final storageReference = FirebaseStorage.instance
            .ref()
            .child('blog_post_images')
            .child("${newPostRef.id}.jpg");
        //File(imageFile.path)
        print(storageReference.fullPath);

        final uploadTask = storageReference.putFile(imageFile);
        await uploadTask.whenComplete(() {});

        final downloadUrl = await storageReference.getDownloadURL();
        print(downloadUrl);

        final blogPostMap = {
          "imageUrl": downloadUrl,
          "author": author,
          "title": title,
          "content": content,
        };
        await _firestore.collection('blog_posts').doc(newPostRef.id).update(blogPostMap);
      }else{
        print("no image selected");
      }

      // You can do something with the blogPostMap if needed

      // Clear the text fields after creating the blog post
      //_titleController.clear();
      // _contentController.clear();
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to upload post with picture');
    }
  }
  Future<void>deletePost()async{
    final newPostRef = _firestore.collection('blog_posts').doc();
    await _firestore.collection('blog_posts').doc(newPostRef.id).delete();
  }

// Other functions...
}
