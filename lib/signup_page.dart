import 'package:contentmanagement/HomePage.dart';
import 'package:contentmanagement/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class signup_page extends StatefulWidget {
  const signup_page({Key? key}) : super(key: key);

  @override
  State<signup_page> createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> {
  final _auth = FirebaseAuth.instance;
 // String email;
//  String password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  void _signUp() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      // Here, you can perform sign up logic
      print('Sign Up email: $email');
      print('Sign Up password: $password');
    }
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

  //get await_auth => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body:Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Join us"),
              SizedBox(height: 5,),
              Text("Create a new account"),
              SizedBox(height: 40,),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                  labelText: 'Email',

                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  labelText: 'Password',
                ),
                validator:(value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /*ElevatedButton(
                    onPressed: () {
                      // Perform login operation
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      // TODO: Implement your login logic
                      Navigator.pushReplacementNamed(context, '/HomePage');
                    },
                    child: Text('Login'),
                  ),*/
                  ElevatedButton(
                    onPressed: () async {
                      // Perform signup operation
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      // TODO: Implement your signup logic here
                      //Navigator.pushReplacementNamed(context, '/HomePage');
                      try{
                        _showProcessingSnackbar('creating  new account...');
                        final newUser = await _auth.createUserWithEmailAndPassword(
                            email :email,password :password);
                        if (newUser != null){
                          //Navigator.pushNamed(context, 'HomePage()');
                          Navigator.pushReplacementNamed(context, '/HomePage');
                        }
                      }catch (e){
                        print(e);
                      }

                    },
                    child: Text('Signup'),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // Navigate back to login page
                  Navigator.pop(context);
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      )

    );
  }
}
