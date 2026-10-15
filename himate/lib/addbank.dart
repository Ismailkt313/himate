import 'package:flutter/material.dart';

class Bankaccount extends StatefulWidget {
  const Bankaccount({super.key});

  @override
  State<Bankaccount> createState() => _BankaccountState();
}

class _BankaccountState extends State<Bankaccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Text(
              "Add New Account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Register Name Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Register Name',
               // hintText: 'Enter your registered name',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                 contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              ),
            ),
            const SizedBox(height: 20),

            // Account Number Field
            TextField(
              decoration: InputDecoration(
                labelText: 'IFSC code',
               // hintText: 'Enter your account number',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                 contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              ),
            ),
            const SizedBox(height: 20),

            // Bank Name Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Account Number',
               // hintText: 'Enter your bank name',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              ),
              
            ),const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 180),
              child: Text('your Information is secure with us'),
            ),
           // const SizedBox(height: 410),

            // Next Button
      
          ],
        ),
      ),

      floatingActionButton: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF06C92),
          padding: const EdgeInsets.symmetric(horizontal: 195, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          
        ),
        
        child: const Text(
          'Save',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
