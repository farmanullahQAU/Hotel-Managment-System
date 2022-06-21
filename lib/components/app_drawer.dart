import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../constants/text_const.dart';
import '../menue_controller.dart';
import '../textstyles.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
  
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
       DrawerHeader(
         margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color:primaryColor,
        ),
        child: Column(
          children: [
            Text("Baidar G",style: TextStyles.subtitle1,),
            SizedBox(height: 10,),
            Text("Khall",style: TextStyles.body1?.copyWith(color: Colors.white,fontStyle:FontStyle.italic ),)
          ],
        ),
      ),
      ..._addMenuButtons()
    ],
  ),
);
  }

 _addMenuButtons() {

return Get.find<MenuController>().getNavigationItem.map((item) {


  return Obx( ()=>
     ListTile(
       selected: Get.find<MenuController>().currentIdex==item.index,
       selectedColor: Colors.white,
       selectedTileColor: Colors.black,
       title:item.widget,
    
    onTap: item.onTap,
    
    ),
  );
}).toList();

  }
}