import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Image(
                image: AssetImage("Asset/image/profile.png"),
                height: 150.0,
                width: 150.0,
              ),
            ),
            const SizedBox(height: 70),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'DOB',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 55, horizontal: 15),
                ),
              ),
            ),
            const SizedBox(height: 300), // Space before the button
            SizedBox(width: 410,
              child: ElevatedButton(
                onPressed: () {
                  // Define your button's functionality here
                  print('Save button pressed');
                },
                style: ElevatedButton.styleFrom(
                  
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    
                  ),
                   backgroundColor: const Color(0xFFF06C92)
                  
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 16,color: Colors.white),
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
