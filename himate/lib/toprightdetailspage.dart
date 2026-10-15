import 'package:flutter/material.dart';
import 'package:himate/addbank.dart';
import 'package:himate/profileedit.dart';

import 'package:himate/screenS/WalletScreen.dart';

class detailsright extends StatefulWidget {
  const detailsright({super.key});

  @override
  State<detailsright> createState() => _detailsrightState();
}

class _detailsrightState extends State<detailsright> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:10,top: 45),
            child: GestureDetector(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Edit()));
            },
              child:const Image(image: AssetImage("Asset/image/profile.png"),height: 150.0,width: 150.0,)),
          ),const SizedBox(height: 10,),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Diya ',style: TextStyle(fontSize: 25,),),
          ),
          const SizedBox(height: 10,),
          const Padding(
            padding: EdgeInsets.only(left: 95),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Column(
                  children: [
                    Text('24 ',style: TextStyle(fontSize: 20,),),SizedBox(height: 10,),
                    Text('follower ',style: TextStyle(fontSize: 20,),),SizedBox(height: 10,),
                  ],
                ),SizedBox(width: 10,),
            
                Column(
                  children: [
                    Text('6',style: TextStyle(fontSize: 20,),),SizedBox(height: 10,),
                    Text('following ',style: TextStyle(fontSize: 20,),),SizedBox(height: 10,),
                  ],
                ),SizedBox(width: 10,),
            
                Column(
                  children: [
                    Text('16',style: TextStyle(fontSize: 20,),),SizedBox(height: 10,),
                    Text('herts ',style: TextStyle(fontSize: 20,),),SizedBox(height: 10,),
                  ],
                ),SizedBox(width: 10,),
              ],
            ),
          ),
          const SizedBox(height: 30,),


          Padding(
  padding: const EdgeInsets.only(left: 20),
  child: GestureDetector(
    onTap: () {
     // Bankaccount
     Navigator.push(context, MaterialPageRoute(builder: (context)=> const Bankaccount())); 
    },
    child:const Row(
      children: [
        Image(
          image: AssetImage("Asset/image/bank.png"),
          height: 40.0,
          width: 60.0,
        ),
         SizedBox(width: 10), // Adds spacing between the image and text
         Text(
          'Bank Account',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  ),
),


          const SizedBox(height: 10,),

           const Padding(
             padding: EdgeInsets.only(left: 20,right: 20),
             child: Divider(thickness: 1,color: Colors.black,height: 3,),
           ),
           const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(children: [
               Image(image: AssetImage("Asset/image/language.png"),height: 40.0,width: 60.0,),
               Text('Language'),
            ],), 
          ),const SizedBox(height: 10,),
           const Padding(
             padding: EdgeInsets.only(left: 20,right: 20),
             child: Divider(thickness: 1,color: Colors.black,height: 3,),
           ),const SizedBox(height: 30,),
           Padding(
            padding:const EdgeInsets.only(left: 20),
            
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const Walletscreen())); 
              },
              child:const Row(children: [
                 Image(image: AssetImage("Asset/image/wallet.png"),height: 40.0,width: 60.0,),
                 Text('wallet'),
              ],),
            ), 
          ),const SizedBox(height: 10,),
           const Padding(
             padding: EdgeInsets.only(left: 20,right: 20),
             child: Divider(thickness: 1,color: Colors.black,height: 3,),
           ),const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(children: [
               Image(image: AssetImage("Asset/image/wallet.png"),height: 40.0,width: 60.0,),
               Text('Bank Account'),
            ],), 
          ),const SizedBox(height: 10,),
           const Padding(
             padding: EdgeInsets.only(left: 20,right: 20),
             child: Divider(thickness: 1,color: Colors.black,height: 3,),
           ),const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(children: [
               Image(image: AssetImage("Asset/image/blocklist.png"),height: 40.0,width: 60.0,),
               Text('Block List'),
            ],), 
          ),const SizedBox(height: 10,),
           const Padding(
             padding: EdgeInsets.only(left: 20,right: 20),
             child: Divider(thickness: 1,color: Colors.black,height: 3,),
           ),const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(children: [
               Image(image: AssetImage("Asset/image/help.png"),height: 40.0,width: 60.0,),
               Text('Help Center'),
            ],), 
          ),const SizedBox(height: 10,),
           const Padding(
             padding: EdgeInsets.only(left: 20,right: 20),
             child: Divider(thickness: 1,color: Colors.black,height: 3,),
           ),const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(children: [
               Image(image: AssetImage("Asset/image/logout.png"),height: 40.0,width: 60.0,),
               Text('Delete Account'),
            ],), 
          ),const SizedBox(height: 10,),
           const Padding(
             padding: EdgeInsets.only(left: 20,right: 20),
             child: Divider(thickness: 1,color: Colors.black,height: 3,),
           ),
        ],
      ),
      
    );
  }
}