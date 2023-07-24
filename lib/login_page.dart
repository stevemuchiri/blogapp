import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:contentmanagement/signup_page.dart';
import 'package:contentmanagement/HomePage.dart';
class login_page extends StatefulWidget {
  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  // Perform login/signup operation
  final _auth = FirebaseAuth.instance;

// TODO: Implement your login/signup logic here

// After successful login/signup, save the user to the database
  //saveUserToDatabase(userId, email);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  void _login() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      // Here, you can perform login authentication and redirection logic
      print('Login email: $email');
      print('Login password: $password');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
  // Function to show a snackbar with a specific message
  void _showProcessingSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // ...

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        title: Text('Content Management System'),
      ),
      body:Container(
        padding: EdgeInsets.all(35),
        child: Form (
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child:Container(),
              ),
              Text("Please SIGNUP if you don't have an account"),
              SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                validator:(value){
                  if(value!.isEmpty){
                    return 'please enter your email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                validator:(value){
                  if(value!.isEmpty){
                    return 'please enter your password';
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async{
                      // Perform login operation
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      // TODO: Implement your login logic
                      //Navigator.pushReplacementNamed(context, '/HomePage');
                      try{
                        _showProcessingSnackbar('Logging in...');
                        final User = await _auth.signInWithEmailAndPassword(email: email, password: password);
                        if (User != null){
                          Navigator.pushReplacementNamed(context, '/HomePage');

                        }
                      }catch (e){
                        print(e);
                        // handel login error
                        String errorMessage = 'An error occured during login. please try again.';
                        if(e is FirebaseAuthException){
                          if(e.code == 'user not found'){
                            errorMessage = 'User not found. Please check your email and try again.';
                          }else if(e.code =='Wrong-password'){
                            errorMessage = 'Incorrect password. Please try again.';
                            _showErrorSnackbar(errorMessage);
                            return; // Return early to prevent navigation to the home page
                          }
                        }

                        _showErrorSnackbar(errorMessage);



                      }
                    },
                    child: Text('Login'),
                  ),

                ],
              ),
              TextButton(
                onPressed: () {
                  // Navigate to signup page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => signup_page()),
                  );
                },
                child: Text("Don't have an account? Sign up"),
              ),
            ],
          ),

        ),
      ),

      );



  }


}