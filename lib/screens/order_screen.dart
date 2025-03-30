import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_calm/providers/order_provider.dart';
import 'bottom_nav_bar.dart';
import 'edit_order_screen.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context).orders;

    return Scaffold(
      backgroundColor: Color(0xFF251205),
      appBar: AppBar(
        title: Text("My Orders", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: orders.isEmpty
          ? Center(child: Text("No orders yet.", style: TextStyle(color: Colors.white, fontSize: 18)))
          : ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            color: Color(0xFF3B2310),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(order["image"], width: 60, height: 60, fit: BoxFit.cover),
              ),
              title: Text(order["name"], style: TextStyle(color: Colors.white, fontSize: 18)),
              subtitle: Text(
                "Size: ${order["size"]} - ${order["paymentMethod"]}\nStatus: ${order["status"]}",
                style: TextStyle(color: Colors.green),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditOrderScreen(order: order),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
