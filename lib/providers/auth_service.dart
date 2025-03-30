import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  String? _firstName;
  String? _lastName;
  String? _email;

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;

  Future<bool> signIn(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    print("Connexion en cours...");
    print("Email saisi : $email");
    print("Mot de passe saisi : $password");
    print("Email stocké : $storedEmail");
    print("Mot de passe stocké : $storedPassword");

    if (storedEmail == email && storedPassword == password) {
      _firstName = prefs.getString('firstName');
      _lastName = prefs.getString('lastName');
      _email = email;
      notifyListeners();

      bool firstLogin = prefs.getBool('firstLogin') ?? true;
      if (firstLogin) {
        await prefs.setBool('firstLogin', false); // Mettre à jour pour la prochaine connexion
      }
      print("Connexion réussie ! Première connexion : $firstLogin");
      return firstLogin;
    }
    print("Échec de la connexion");
    return false;
  }

  Future<bool> registerUser(String firstName, String lastName, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setBool('firstLogin', true); // Marquer comme première connexion

    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    notifyListeners();

    print("Utilisateur enregistré : $firstName $lastName ($email)");
    return true;
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _firstName = null;
    _lastName = null;
    _email = null;
    notifyListeners();

    print("Déconnexion effectuée");
  }
}
