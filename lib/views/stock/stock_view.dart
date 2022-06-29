import 'dart:math';

import 'package:baidarg/constants/firestore_constants.dart';
import 'package:baidarg/constants/text_const.dart';
import 'package:baidarg/localization/locale_constants.dart';
import 'package:baidarg/services/firestore_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import '../../models/item_model.dart';

class ItemsStock extends StatelessWidget {
  const ItemsStock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
// child: FirestoreListView<Item>(
//   shrinkWrap: true,
//   query: FirestoreServices.itemQuery,

//   loadingBuilder: (context) => CircularProgressIndicator(),

//   itemBuilder: (context,snapshot){
//     final item=snapshot.data();
// return 

// item.stockQuantity==null?Container():
// SizedBox(
//   width: context.width*0.5,
//   child:   Card(
//     child:   Column(
//       children: [
//          Text("Stock"),
//           CircleAvatar(
          
//           radius: 70,
          
//           child: Text(item.itemName),),Text(item.stockQuantity.toString()), Text(item.category),
   
//    Text("price".toUpperCase()),
//    Text(item.price.toString()),
   
//    Text("price".toUpperCase()),
//    Text(item.price.toString())
//       ],
//     ),
//   ),
// );

//   },
//   errorBuilder: (context, error, stackTrace) => Text(error.toString()),
//   // ...
// ),

      child:Center(
        child: FirestoreQueryBuilder<Item>(
          //fetch only those whose stock value is added
          query: FirestoreServices.itemQuery,
          builder: (context, snapshot, _) {
        if(snapshot.isFetching)
        {

          return Center(child: CircularProgressIndicator(),);
        }
          return SizedBox(
    
            child: GridView.builder(
              shrinkWrap: true,
             itemCount: snapshot.docs.length,
             itemBuilder: (context, index) {
            
               // if we reached the end of the currently obtained items, we try to
               // obtain more items
               if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                 // Tell FirestoreQueryBuilder to try to obtain more items.
                 // It is safe to call this function from within the build method.
                 snapshot.fetchMore();
               }


    
               Item item = snapshot.docs[index].data();
    
               return 
            
               Padding(
                padding: const EdgeInsets.all(10),
                child:
                DottedBorderExample(item: item,),
                // child: CircleAvatar(
                //    child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //  Text("item"),
                //       Text(item.itemName.toUpperCase()),
                //       SizedBox(height: 10,),
                //       Divider(),
                //       Text("stock".tr.toUpperCase()),
                //       Text(item.stockQuantity.toString())
                //     ],
                //    ),
                //  ),
              );
                       // Obx(()=> controller.selectedItemList.isNotEmpty? Text("kkkk"): Text("mmmmm")),
             }     ,   
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10)        
            ));
          },
        ),
      ),
    );
  }
}


class DottedBorder extends CustomPainter {

  final int? stockValue;
  //number of stories
  final int numberOfStories;
  //length of the space arc (empty one)
  final int spaceLength;
  //start of the arc painting in degree(0-360)
  double startOfArcInDegree = 0;

  DottedBorder({required this.numberOfStories, this.spaceLength = 10,required this.stockValue});

  //drawArc deals with rads, easier for me to use degrees
  //so this takes a degree and change it to rad
  double inRads(double degree){
    return (degree * pi)/180;
  }

  @override
  bool shouldRepaint(DottedBorder oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {

    //circle angle is 360, remove all space arcs between the main story arc (the number of spaces(stories) times the  space length
    //then subtract the number from 360 to get ALL arcs length
    //then divide the ALL arcs length by number of Arc (number of stories) to get the exact length of one arc
    double arcLength = (360 - (numberOfStories * spaceLength))/numberOfStories;


    //be careful here when arc is a negative number
    //that happens when the number of spaces is more than 360
    //feel free to use what logic you want to take care of that
    //note that numberOfStories should be limited too here
    if(arcLength<=0){
      arcLength = 360/spaceLength -1;
    }


    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    //looping for number of stories to draw every story arc
    for(int i =0;i<numberOfStories;i++){
      //printing the arc
      canvas.drawArc(
          rect,
          inRads(startOfArcInDegree),
          //be careful here is:  "double sweepAngle", not "end"
          inRads(arcLength),
          false,
          Paint()
          //here you can compare your SEEN story index with the arc index to make it grey
            ..color = i==0||i==1?Colors.grey:
            //if no stock show red dotts else show teal colors dots
            stockValue==null||stockValue==0?Colors.red:
            Colors.teal
            ..strokeWidth =14.0
            ..style = PaintingStyle.stroke

      );

      //the logic of spaces between the arcs is to start the next arc after jumping the length of space
      startOfArcInDegree += arcLength + spaceLength;
    }




  }
}



class DottedBorderExample extends StatelessWidget {
  final Item item;
  const DottedBorderExample({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 300,height: 300,

                child: CustomPaint(
                                    painter:  DottedBorder(numberOfStories: 13,spaceLength:4 ,stockValue: item.stockQuantity),
              ),),
             Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item.itemName.toUpperCase(),style: Theme.of(context).textTheme.headline6,),
                    SizedBox(height: 10,),
                    Divider(),
                    Text("stock".tr.toUpperCase()),
                    item.stockQuantity==null||item.stockQuantity==0?
                    Text("0",style: TextStyle(fontWeight: FontWeight.bold)):

                    Text(item.stockQuantity.toString(),style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                 ),
            ],
          )

      )
    );
  }
}