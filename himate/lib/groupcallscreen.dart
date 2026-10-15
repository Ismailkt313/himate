import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Groupcall extends StatefulWidget {
  const Groupcall({super.key});

  @override
  State<Groupcall> createState() => _GroupcallState();
}

class _GroupcallState extends State<Groupcall> {
  final bool _animate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 610,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage(
                    'Asset/image/Group 281.png'), // Path to your image
                fit: BoxFit.cover,
              ), // Rounded corners
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                AvatarGlow(
                  startDelay: const Duration(milliseconds: 1000),
                  glowColor: Colors.white,
                  glowShape: BoxShape.circle,
                  animate: _animate,
                  curve: Curves.fastOutSlowIn,
                  child: const Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    color: Colors.transparent,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('Asset/image/Group 65.png'),
                      radius: 50.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Row(
                    children: [
                      AvatarGlow(
                        startDelay: const Duration(milliseconds: 1000),
                        glowColor: Colors.white,
                        glowShape: BoxShape.circle,
                        animate: _animate,
                        curve: Curves.fastOutSlowIn,
                        child: const Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          color: Colors.transparent,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('Asset/image/her.png'),
                            radius: 50.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      AvatarGlow(
                        startDelay: const Duration(milliseconds: 1000),
                        glowColor: Colors.white,
                        glowShape: BoxShape.circle,
                        animate: _animate,
                        curve: Curves.fastOutSlowIn,
                        child: const Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          color: Colors.transparent,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('Asset/image/Group 65.png'),
                            radius: 50.0,
                          ),
                        ),
                      ),
                       const SizedBox(
                        width: 18,
                      ),
                      AvatarGlow(
                        startDelay: const Duration(milliseconds: 1000),
                        glowColor: Colors.white,
                        glowShape: BoxShape.circle,
                        animate: _animate,
                        curve: Curves.fastOutSlowIn,
                        child: const Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          color: Colors.transparent,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('Asset/image/Group 65.png'),
                            radius: 50.0,
                          ),
                        ),
                      ),
                  
                       
                    ],
                  ),
                ),
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Row(
                    children: [
                      AvatarGlow(
                        startDelay: const Duration(milliseconds: 1000),
                        glowColor: Colors.white,
                        glowShape: BoxShape.circle,
                        animate: _animate,
                        curve: Curves.fastOutSlowIn,
                        child: const Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          color: Colors.transparent,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('Asset/image/Group 66.png'),
                            radius: 50.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      AvatarGlow(
                        startDelay: const Duration(milliseconds: 1000),
                        glowColor: Colors.white,
                        glowShape: BoxShape.circle,
                        animate: _animate,
                        curve: Curves.fastOutSlowIn,
                        child: const Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          color: Colors.transparent,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('Asset/image/boy.png'),
                            radius: 50.0,
                          ),
                        ),
                      ),
                       const SizedBox(
                        width: 18,
                      ),
                      AvatarGlow(
                        startDelay: const Duration(milliseconds: 1000),
                        glowColor: Colors.white,
                        glowShape: BoxShape.circle,
                        animate: _animate,
                        curve: Curves.fastOutSlowIn,
                        child: const Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          color: Colors.transparent,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('Asset/image/guy.png'),
                            radius: 50.0,
                          ),
                        ),
                      ),                              
                    ],
                  ),
                ),
                const SizedBox(height: 50,),

                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Row(
                    children: [
                      AvatarGlow(
                        startDelay: const Duration(milliseconds: 1000),
                        glowColor: Colors.white,
                        glowShape: BoxShape.circle,
                        animate: _animate,
                        curve: Curves.fastOutSlowIn,
                        child: const Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          color: Colors.transparent,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('Asset/image/her.png'),
                            radius: 50.0,
                          ),
                        ),
                      ),  
                      const SizedBox(
                        width: 30,
                      ),
                       AvatarGlow(
                        startDelay: const Duration(milliseconds: 1000),
                        glowColor: Colors.white,
                        glowShape: BoxShape.circle,
                        animate: _animate,
                        curve: Curves.fastOutSlowIn,
                        child: const Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          color: Colors.transparent,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('Asset/image/Group 65.png'),
                            radius: 50.0,
                          ),
                        ),
                      ),  
                       const SizedBox(
                        width: 18,
                      ),
                      AvatarGlow(
                        startDelay: const Duration(milliseconds: 1000),
                        glowColor: Colors.white,
                        glowShape: BoxShape.circle,
                        animate: _animate,
                        curve: Curves.fastOutSlowIn,
                        child: const Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          color: Colors.transparent,
                          child: CircleAvatar(
                            radius: 50.0,
                            child: Icon(Icons.add_a_photo),
                          ),
                        ),
                      ),
                  
                       
                    ],
                  ),
                ),
                
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: 250,
                  child: Column(
                    children: [
                      const SizedBox(height: 30,), Image.asset("Asset/image/Rectangle 117.png",height: 40,),const SizedBox(height: 20,),
                       Image.asset("Asset/image/Rectangle 119.png",height: 60,width: 160,),const SizedBox(height: 30,),
                       Image.asset("Asset/image/Rectangle 117.png",height: 40,),const SizedBox(height: 20,),
                    ],
                  ),
                 
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: 250,
                 child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Image.asset("Asset/image/Frame.png",height: 30,),
                    ),
                    const SizedBox(height: 10,),
                     Image.asset("Asset/image/Frame2.png",height: 30,),
                    const SizedBox(height: 10,),
                    Image.asset("Asset/image/gift 1.png",height: 30,),
                    const SizedBox(height: 10,),

                  ],
                 ),
                ),
              ),
            ],
          ),
          Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Expanded(
      child: TextField(
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Type a message',
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
           borderSide: const BorderSide(
            color: Color(0xFFF06C92),
           )
          ),
          filled: true,
          contentPadding: const EdgeInsets.all(20),
          fillColor: Colors.grey[200],
        ),
      ),

    ),
   ElevatedButton(
  onPressed: () {}, 
  style: TextButton.styleFrom(
    backgroundColor: const Color(0xFFF06C92),
     // Text color
  ),
  child: const Text('Send',
  style: TextStyle(color: Colors.white),),
),

  ],
)

        ],
      ),
    );
  }
}
