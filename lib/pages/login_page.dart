
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cac_project/components/my_textfield.dart';
import 'package:flutter_cac_project/components/my_button.dart';
import 'package:flutter_cac_project/components/square_tile.dart';

class LoginPage extends StatefulWidget
{
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {

    //show loading circle
    showDialog(
      context: context, 
      builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
        );
      },
    );
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
    );
    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    //wrong email
    Navigator.pop(context);
    // show error message
    showErrorMessage(e.code);
  }

      //pop the loading circle
}

  //error message
  void showErrorMessage(String message) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
          
          //logo
                const Icon(
                  Icons.food_bank,
                  size: 100,
                ),
          
                const SizedBox(height: 25),
          
                //Welcome!
                Text(
                  'Welcome to cFood!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
          
                const SizedBox(height: 50),
          
                //username
                MyTextField(
                  controller: emailController,
                  hintText: "Username",
                  obscureText: false,
                ),   
          
                const SizedBox(height: 10),
          
                //password
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
          
                const SizedBox(height: 10),
          
                //forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 25),
          
                //sign in button
          
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn,
                ),
          
          
                const SizedBox(height: 50),
                
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                        ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )
                    )
                  ],
                ),
              ),
                
              const SizedBox(height: 50),
          
                //google and apple sign in button
                 
          
              const Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  SquareTile(imagePath: 'lib/Images/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png'),
          
                  SizedBox(width: 25),
          
                  SquareTile(imagePath: 'lib/Images/apple.png'),
                ],
              ),
          
              const SizedBox(height: 50),
          
              //Not a member? Register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700])
                    ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap, 
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                  ],
                )   
              ],
            ),
          ),
        ),
      
      ),
    ); 
  }
}