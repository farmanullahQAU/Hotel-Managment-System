// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/state_manager.dart';

// import '../constants/constants.dart';
// import '../menue_controller.dart';
// import '../responsive/responsive_wrapper.dart';
// import '../textstyles.dart';

// class Header extends StatelessWidget {
// //title only for mobile view
//   final String title;
// //to controll menu only for mobile view
//   final VoidCallback? onTap;
//   const Header({Key? key,this.onTap,required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth=context.width;
//     return  


//     AnimatedSwitcher(
    
// duration: Duration(milliseconds: 400),

//                                      transitionBuilder: (child,animation)=>ScaleTransition(
                                       
//                                        alignment: Alignment.topLeft,
//                                        scale: animation,child: child,),

//       child: ResponsiveWidget.isSmallScreen(context)?

//       //drawer button
      
//         Container(
//           color: Colors.black,


//           height: 60,
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 40,
//                   width: 45,
//                   child: TextButton(
                
//                     style: ButtonStyle(
//                 backgroundColor:MaterialStateProperty.all<Color> (Colors.black),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
                
                      
//                       borderRadius: BorderRadius.circular(10.0),
//                       side: BorderSide(color: Colors.red)
//                     )
//                   )
//                 ),
//                     onPressed:onTap,
//                     child: Icon(Icons.menu,color: Colors.white,)),
//                 ),
//           Padding(padding: EdgeInsets.only(left: screenWidth*0.3), child: Text(title.toUpperCase(),style: TextStyles.subtitle1,),)
        
//               ],
//             ),
//           ),
//         ):
//        Container(
//          color: navigationBarColor,
//          key: Key("navigation bar"),
//     //width fo nav bar
//           height: 100,
//           child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children:
      
      
//                             Get.find<MenuController>().getNavigationBarItems().map((e) {
//                             final index=e.index;
      
//                             return
      
      
      
      
      
//                               Obx(()=>
//                                   Stack(
//                                     alignment: Alignment.center,
//                                     children: [
//       //add red dot for selected 
      
                                     
                                  
      
//                                       Get.find<MenuController>().currentIdex==index?
      
//                                       Padding(
//                                         padding: const EdgeInsets.only(bottom:40.0),
//                                         child: Container(
                                          
//                                             decoration: const BoxDecoration(
      
//                                                 color: Colors.red,
      
//                                                 shape: BoxShape.circle),
      
//                                             width: 8,height: 8),
//                                       ):Container(),
//                                          TextButton(
      
      
//                                         style: ButtonStyle(
      
      
      
//                                           foregroundColor: MaterialStateProperty.resolveWith<Color>(
//                                                   (Set<MaterialState> states) {
//                                                 if (states.contains(MaterialState.focused)) {
//                                                   return Colors.yellow;
//                                                 }
//                                                 if (states.contains(MaterialState.hovered)) {
//                                                   return Colors.red;
//                                                 }
//                                                 if (states.contains(MaterialState.pressed)) {
//                                                   return Colors.blue;
//                                                 }
//                                                 return Colors.white; 
//                                               }),
//                                         ),
//                                         onPressed: e.onTap,
//                                         child:
      
      
//                                         e.item!,
      
      
      
      
//                                       ),
//                                     ],
//                                   ),
//                               );
//                           }
      
      
      
      
      
//                           ).toList()
      
      
      
//                       ),
//         ),
//     );
      
//   }
// }