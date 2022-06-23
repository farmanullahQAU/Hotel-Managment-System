import 'package:baidarg/assets_path.dart';
import 'package:baidarg/components/app_drawer.dart';
import 'package:baidarg/menue_controller.dart';
import 'package:baidarg/responsive/responsive_wrapper.dart';
import 'package:baidarg/views/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      key: Get.find<MenuController>().homeScaffoldKey,

      drawer: AppDrawer(),
      
      // backgroundColor: Theme.of(context).primaryColor,
      
      body: ResponsiveWidget(largeScreen: 


      
      Row(children: [


_addNavigationRail(context),

Flexible(child: Obx(()=> controller.screens.elementAt(controller.currentIndex)))


      ]),

      smallScreen: Stack(children: [

Center(child: Container(width: double.infinity,height: Get.height,color: Colors.pink,)),
        

Positioned(

  top: 0.0,
  left: 0.0,
  child:   IconButton(onPressed: (){
  
  Get.find<MenuController>().controlHomeMenu();
  
  }, icon: Icon(Icons.menu)),
)



      ],)
      
      
      ,)
      
      
      // ResponsiveWidget.isLargeScreen(context)?
      // _addNavigationRail(context):Stack(
      //   children: [
      //     Row(
      //       children: [
      //         Text("Mobile"),
      //       ],
      //     ),
      //     Positioned(
      //       top: 0.0,left: 0.0,
            
      //       child: Icon(Icons.media_bluetooth_off))
      //   ],
      // ),




//       body:
//       Container(child: Center(child: Column(


        
//       children: [
//         Text("HOME"),

// //          Expanded(
// //            child:SignInScreen(
// //              showAuthActionSwitch: false,
// //   subtitleBuilder: (context, action) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 8),
// //       child: Text(
// //         action == AuthAction.signIn
// //             ? 'Welcome to Baidar G Admin panel! Please sign in to continue.'
// //             : 'Welcome to FlutterFire UI! Please create an account to continue',
// //       ),
// //     );
// //   },
// //   footerBuilder: (context, _) {
// //     return const Padding(
// //       padding: EdgeInsets.only(top: 16),
// //       child: Text(
// //         'By signing in, you agree to our terms and conditions.',
// //         style: TextStyle(color: Colors.grey),
// //       ),
// //     );
// //   },
// //   sideBuilder: (context, constraints) {


// //     return Image.asset(backgroundImagePath,width: 100,);
// //   },
// // headerBuilder: (context, constraints, _) {
// //     return Padding(
// //       padding: const EdgeInsets.all(20),
// //       child: AspectRatio(
// //         aspectRatio: 1,
// //         child:     Image.asset(backgroundImagePath))
// // ,
// //     );
// //   },
// //   providerConfigs: [
 
// //     EmailProviderConfiguration(),
// //   ]
// // )
// //          )
     
     
     
     
     
//       ],
//     ),),)
);
  }



  _addNavigationRail(BuildContext context) {
    return Obx(()=>
      NavigationRail(
        minWidth: 100,
        //make current index as selected
        selectedIndex: controller.currentIndex,
        onDestinationSelected: (int index) {
          //set current index
    
          controller.currentIndex = index;
          
        },
        labelType: NavigationRailLabelType.selected,
        destinations:Get.find<MenuController>().getNavigationItem.map((e) => 
        
        
        NavigationRailDestination(
              icon:  CircleAvatar(
                backgroundColor: Colors.transparent,
                child:e.icon,
              ),

              
              selectedIcon: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child:e.icon,
              ),
              label:e.widget??Container()),
        
        ).toList()
      ),
    );
  }
}