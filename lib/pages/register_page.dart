
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cac_project/components/my_textfield.dart';
import 'package:flutter_cac_project/components/my_button.dart';
import 'package:flutter_cac_project/components/square_tile.dart';

class RegisterPage extends StatefulWidget
{
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign user up method
  void signUserUp() async {

    //show loading circle
    showDialog(
      context: context, 
      builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
        );
      },
    );
    // try creating the user
  try {
    //check if password is confirmed
    if (passwordController.text == confirmPasswordController.text) {

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text,
      );
    } else {
      //show error message, passwords dont match
      showErrorMessage("Passwords don't match!");
    }
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
                const SizedBox(height: 50),
          
          //logo
                const Icon(
                  Icons.food_bank,
                  size: 50,
                ),
          
                const SizedBox(height: 25),
          
                //Welcome!
                Text(
                  'Let\'s create an account!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
          
                const SizedBox(height: 25),
          
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
               //confirm password text field
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                
                const SizedBox(height: 25),
          
                //sign in button
          
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
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
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey[700])
                    ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap, 
                    child: const Text(
                      'Login now',
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