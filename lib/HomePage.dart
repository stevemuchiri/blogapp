import 'package:cached_network_image/cached_network_image.dart';
import 'package:contentmanagement/%20services/funtions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:contentmanagement/models/datamodel.dart';
import 'package:contentmanagement/other_screens/BlogPostCreationScreen.dart';

import 'other screens/BlogPostCreationScreen.dart';
import 'package:contentmanagement/ services/funtions.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  funtions funtions2 = funtions();

  Stream<List<BlogPost>> _getBlogPostsStream() {
    return _firestore
        .collection('blog_posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return BlogPost(
        id: doc.id,
        title: data['title'] ?? '',
        content: data['content'] ?? '',
        author: data['author'] ?? '',
        timestamp: (data['timestamp'] as Timestamp?)?.toDate() ??
            DateTime.now(),
        imageUrl: data['imageUrl'] ?? '',
      );
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leverage Your Niche'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogPostCreationScreen(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add_box_rounded,),
        //Text('post'),

      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                // TODO: Implement profile functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit My Profile'),
              onTap: () {
                // TODO: Implement edit profile functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active),
              title: const Text('Notifications'),
              onTap: () {
                // TODO: Implement notifications functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // TODO: Implement settings functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await _auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login_page',
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: StreamProvider<List<BlogPost>>(
        create: (_) => _getBlogPostsStream(),
        initialData: [], // Optional initial data
        catchError: (_, __) => [], // Optional error handling
        child: BlogPostList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (int index) {
          // Handle navigation to different screens
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
        ],
        unselectedFontSize: 12,
        iconSize: 24,
        selectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 8,
      ),
    );
  }
}

class BlogPostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blogPosts = context.watch<List<BlogPost>>();

    if (blogPosts.isEmpty) {
      return Center(child: Text('No blog posts found.'));
    }

    return ListView.builder(
      itemCount: blogPosts.length,
      itemBuilder: (context, index) {
        final blogPost = blogPosts[index];

        return Card(
          elevation: 10.0,
          margin: EdgeInsets.all(15),
          child: Container(
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(blogPost.title),
                SizedBox(height: 5),
                CachedNetworkImage(
                    imageUrl:blogPost.imageUrl,
                imageBuilder: (context,imageProvider)=>Container(
                  width: 400,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:imageProvider,
                        fit: BoxFit.fitWidth
                    )
                  ),
                ),
                placeholder: (context,url)=> Container(
                  alignment: Alignment.center,
                  child:CircularProgressIndicator(),

                ),
                //if (blogPost.imageUrl.isNotblogPost.imageUrlEmpty)
              //Image.network(, fit: BoxFit.cover),
                ),
                SizedBox(height: 5),
                Text(blogPost.content),
                ElevatedButton(
                  onPressed: () async{
                    await showDialog(context: context,
                        builder: (context)
                        {
                          return AlertDialog(
                            title: const Text('delete post'),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              },
                                  child: const Text('No')
                              ),
                              TextButton(onPressed: () async{
                                await funtions().deletePost();
                                Navigator.pop(context);
                                Navigator.pop(context);
                                //Provider.of<postProvider>(context, listen: false)
                                   //.refresh(Widget.userUid);
                                //ref.refresh(postProvider(Widget.userUid));
                              },
                                  child: const Text('yes')
                              )
                            ],
                          );
                        }
                    );

                    // TODO: Implement delete functionality
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 18,
                      backgroundColor: Colors.redAccent,
                    ),
                  ),
                ),
                // Add more widgets as needed
              ],
            ),
          ),
        );
      },
    );
  }
}
