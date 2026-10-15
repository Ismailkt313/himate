import 'package:flutter/material.dart';
import 'package:himate/bottomscreens/callscreen.dart';
import 'package:himate/bottomscreens/secondtab.dart';
import 'package:himate/screenS/ReloadScreen.dart';
import 'package:himate/screenS/thirdScreen.dart';

class SimpleBottomNavBar extends StatefulWidget {
  const SimpleBottomNavBar({super.key});

  @override
  _SimpleBottomNavBarState createState() => _SimpleBottomNavBarState();
}

class _SimpleBottomNavBarState extends State<SimpleBottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const mainscreen(),
    const Secondbottomscreen(),
    const Thirdscreen(),
    const Reloadscreen()
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows content to extend behind the bottom bar
      body: Stack(
        children: [
          _pages[_currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFF06C92), // Pink background for the tab bar
                  borderRadius: BorderRadius.circular(27),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // _buildNavItem(
                      //     Image.asset("Asset/image/himate logo 2.png",height: 10,),
                      //     'Home',
                      //     0),
                      // _buildNavItem(Icon(Icons.sensors_rounded), 'Search', 1),
                      // _buildNavItem(Icon(Icons.sensors_rounded), 'Profile', 2),
                      // _buildNavItem(Icon(Icons.sensors_rounded), 'Zzzz', 3),

                     _buildNavItem('himate logo 2.png', 'himate logo 2.png', 0),
                     _buildNavItem('Vector-2.png', 'unVector-2.png', 1),
                     _buildNavItem('Vector.png', 'unVector-1.png', 2),
                     _buildNavItem('Vector-1.png', 'unVector.png', 3),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//   Widget _buildNavItem(Widget icon, String label, int index) {
//     bool isSelected = _currentIndex == index;
//     return GestureDetector(
//       onTap: () {
//         _onTap(index);
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 60,
//             width: 60,
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.white : Color(0xFFF06C92),
//               shape: BoxShape.circle,
//               boxShadow: isSelected
//                   ? [
//                       BoxShadow(
//                         color: Colors.white.withOpacity(0.5),
//                         blurRadius: 13,
//                         offset: Offset(0, 3),
//                       ),
//                     ]
//                   : [],
//             ),
//             child: Icon(
//               (icon is IconData) as IconData?,
//               color: isSelected ? Colors.pinkAccent : Colors.white,
//               size: 28,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget _buildNavItem(dynamic icon, String label, int index) {
//   bool isSelected = _currentIndex == index;
//   return GestureDetector(
//     onTap: () {
//       _onTap(index);
//     },
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           height: 60,
//           width: 60,
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.white : Color(0xFFF06C92),
//             shape: BoxShape.circle,
//             boxShadow: isSelected
//                 ? [
//                     BoxShadow(
//                       color: Colors.white.withOpacity(0.5),
//                       blurRadius: 13,
//                       offset: Offset(0, 3),
//                     ),
//                   ]
//                 : [],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(12.0), // Adjust padding as needed
//             child: icon is IconData
//                 ? Icon(
//                     icon,
//                     color: isSelected ? Color(0xFFF06C92) : Colors.white,
//                     size: 28,
//                   )
//                 : icon is String
//                     ? Image.asset(
//                         icon,
//                         color: isSelected ? Color(0xFFF06C92) : Colors.white,
//                         fit: BoxFit.contain,
//                       )
//                     : SizedBox.shrink(),
//           ),
//         ),
//         SizedBox(height: 5),
//         Text(
//           label,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.white70,
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     ),
//   );
// }
// }
Widget _buildNavItem(String assetName, String selectedAssetName, int index) {
  bool isSelected = _currentIndex == index;
  return GestureDetector(
    onTap: () {
      _onTap(index);
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.transparent, // Remove background color
            shape: BoxShape.circle,
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                      color: Colors.white,
                      // blurRadius: 13,
                      // offset: Offset(0, 0),
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(
              isSelected
                  ? 'Asset/image/$selectedAssetName'  // Selected state image
                  : 'Asset/image/$assetName',          // Default state image
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    ),
  );
}
}