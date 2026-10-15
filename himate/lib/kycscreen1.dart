import 'package:flutter/material.dart';

class kycscreenone extends StatefulWidget {
  const kycscreenone({super.key});

  @override
  State<kycscreenone> createState() => _kycscreenoneState();
}

class _kycscreenoneState extends State<kycscreenone> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30,left: 20),
            child: Text('KYC Verification',style: TextStyle(
              fontSize: 22,
            
            ),),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: TextField(
              decoration: InputDecoration(labelText: 'Register name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))
                )
              ),
            ),
          ),SizedBox(height: 10,),
           Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: TextField(
              decoration: InputDecoration(labelText: 'Home adress',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                )
              ),
            ),
          ),
          SizedBox(height: 10,),
           Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: TextField(
              decoration: InputDecoration(labelText: 'Phone number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                )
              ),
            ),
          ),SizedBox(height: 10,),
           Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: TextField(
              decoration: InputDecoration(labelText: 'Email id ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                )
              ),
            ),
          ),

          SizedBox(
            height: 24,
          ),
             Padding(
               padding: EdgeInsets.only(right: 300),
               child: Text('Bank Details',style: TextStyle(
                fontSize: 20
               ),),
             ),
             SizedBox(height: 10,),
           Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: TextField(
              decoration: InputDecoration(labelText: 'Registerd Name ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                )
              ),
            ),
          ),
          SizedBox(height: 10,),
           Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: TextField(
              decoration: InputDecoration(labelText: 'IFSC code ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                )
              ),
            ),
          ),
           SizedBox(height: 10,),
           Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: TextField(
              decoration: InputDecoration(labelText: 'Account No ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}