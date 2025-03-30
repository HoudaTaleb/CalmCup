import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_calm/providers/order_provider.dart';
import 'order_screen.dart';
import 'bottom_nav_bar.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productImage;

  OrderConfirmationScreen({
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  @override
  _OrderConfirmationScreenState createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  String _selectedSize = "M";
  String _selectedPayment = "Credit Card";
  String _selectedDeliveryMethod = "Sur place";

  final TextEditingController _tableNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // 🎯 Champs pour paiement par carte
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF251205),
      appBar: AppBar(
        title: Text("Order Confirmation"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Your Order", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(widget.productImage, width: 150, height: 150, fit: BoxFit.cover),
              ),
              SizedBox(height: 20),
              Text(widget.productName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 5),
              Text("\$${widget.productPrice}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFDB944B))),
              SizedBox(height: 30),

              // ✅ Sélection de la taille
              _buildSectionTitle("Select Size"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ["S", "M", "L"].map((size) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ChoiceChip(
                      label: Text(size, style: TextStyle(color: Colors.white)),
                      selected: _selectedSize == size,
                      selectedColor: Color(0xFFDB944B),
                      onSelected: (selected) {
                        setState(() {
                          _selectedSize = size;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // ✅ Choix du mode de livraison
              _buildSectionTitle("Choose Delivery Method"),
              Column(
                children: ["Sur place", "À emporter", "Livraison à domicile"].map((method) {
                  return ListTile(
                    leading: Icon(
                      _selectedDeliveryMethod == method ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: Colors.white,
                    ),
                    title: Text(method, style: TextStyle(color: Colors.white)),
                    onTap: () {
                      setState(() {
                        _selectedDeliveryMethod = method;
                      });
                    },
                  );
                }).toList(),
              ),

              // ✅ Affichage des champs supplémentaires selon le mode de livraison
              if (_selectedDeliveryMethod == "Sur place")
                _buildTextField(_tableNumberController, "Table Number", TextInputType.number),

              if (_selectedDeliveryMethod == "Livraison à domicile") ...[
                _buildTextField(_addressController, "Delivery Address", TextInputType.text),
                _buildTextField(_phoneController, "Phone Number", TextInputType.phone),
              ],

              SizedBox(height: 20),

              // ✅ Sélection du moyen de paiement
              _buildSectionTitle("Select Payment Method"),
              Column(
                children: ["Credit Card", "PayPal", "Cash on Delivery"].map((method) {
                  return ListTile(
                    leading: Icon(
                      _selectedPayment == method ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: Colors.white,
                    ),
                    title: Text(method, style: TextStyle(color: Colors.white)),
                    onTap: () {
                      setState(() {
                        _selectedPayment = method;
                      });
                    },
                  );
                }).toList(),
              ),

              // ✅ Affichage des champs de carte si "Credit Card" est sélectionné
              if (_selectedPayment == "Credit Card") ...[
                _buildTextField(_cardNumberController, "Card Number", TextInputType.number),
                _buildTextField(_expiryDateController, "Expiry Date (MM/YY)", TextInputType.datetime),
                _buildTextField(_cvvController, "CVV", TextInputType.number),
              ],

              SizedBox(height: 30),

              // ✅ Bouton de confirmation de commande
              ElevatedButton(
                onPressed: _confirmOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDB944B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text("Confirm Order", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  // ✅ Fonction pour afficher un champ texte
  Widget _buildTextField(TextEditingController controller, String label, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDB944B)),
          ),
        ),
      ),
    );
  }

  // ✅ Fonction pour afficher les titres de section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 5),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  // ✅ Fonction pour confirmer la commande
  void _confirmOrder() {
    if (_selectedPayment == "Credit Card" &&
        (_cardNumberController.text.isEmpty ||
            _expiryDateController.text.isEmpty ||
            _cvvController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter your card details"),
      ));
      return;
    }

    Provider.of<OrderProvider>(context, listen: false).addOrder(
      widget.productName,
      widget.productPrice,
      widget.productImage,
      _selectedSize,
      _selectedPayment,
      _selectedDeliveryMethod,
      _tableNumberController.text,
      _addressController.text,
      _phoneController.text,
    );

    _showOrderSuccessDialog();
  }

  // ✅ Fonction pour afficher le dialogue de confirmation et rediriger vers "My Orders"
  void _showOrderSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Order Successful"),
          content: Text("Your order has been placed successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => OrderScreen()),
                      (route) => false, // Supprime toutes les pages précédentes de la pile
                );
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
