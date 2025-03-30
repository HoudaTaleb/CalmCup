import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_calm/providers/order_provider.dart';
import 'bottom_nav_bar.dart';

class EditOrderScreen extends StatefulWidget {
  final Map<String, dynamic> order;

  EditOrderScreen({required this.order});

  @override
  _EditOrderScreenState createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  late String _selectedSize;
  late String _selectedPayment;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.order["size"];
    _selectedPayment = widget.order["paymentMethod"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF251205),
      appBar: AppBar(
        title: Text("Edit Order"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.order["name"], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(widget.order["image"], width: 150, height: 150, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),

            // Size Selection
            Text("Select New Size", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 10),
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

            // Save Changes Button
            ElevatedButton(
              onPressed: () {
                Provider.of<OrderProvider>(context, listen: false).modifyOrder(
                  widget.order["name"],
                  _selectedSize,
                  _selectedPayment,
                );
                Navigator.pop(context); // Go back to orders screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDB944B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text("Save Changes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
