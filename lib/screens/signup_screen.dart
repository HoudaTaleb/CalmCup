import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'signin_screen.dart';
import 'package:coffee_calm/providers/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    bool registered = await Provider.of<AuthService>(context, listen: false).registerUser(
      _nameController.text.trim(),
      _lastNameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (registered) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Inscription réussie !")));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erreur lors de l'inscription.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/signin.jpg', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.5)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rejoignez CalmCap',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    Card(
                      color: Colors.white.withOpacity(0.9),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Prénom',
                                  prefixIcon: Icon(Icons.person, color: Colors.brown),
                                ),
                                style: TextStyle(color: Colors.black),
                                validator: (value) => value!.isEmpty ? 'Veuillez entrer votre prénom' : null,
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email, color: Colors.brown)),
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.black),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Veuillez entrer votre email';
                                  if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(value)) return 'Email invalide';
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(labelText: 'Mot de passe', prefixIcon: Icon(Icons.lock, color: Colors.brown)),
                                obscureText: true,
                                style: TextStyle(color: Colors.black),
                                validator: (value) => value!.length < 6 ? 'Mot de passe trop court' : null,
                              ),
                              SizedBox(height: 15),
                              _isLoading
                                  ? CircularProgressIndicator()
                                  : ElevatedButton(
                                onPressed: _register,
                                child: Text("S'inscrire"),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),

                              ),
                            ],
                          ),

                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
