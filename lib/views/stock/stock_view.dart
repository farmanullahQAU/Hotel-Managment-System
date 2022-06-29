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

      child:FirestoreQueryBuilder<Item>(
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


    
             final item = snapshot.docs[index].data();
    
             return 
             item.stockQuantity!=null?
            Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
               Text("item"),
                    Text(item.itemName.toUpperCase()),
                    SizedBox(height: 10,),
                    Divider(),
                    Text("stock".tr.toUpperCase()),
                    Text(item.stockQuantity.toString())
                  ],
                 ),
               ),
            ):Container();
                     // Obx(()=> controller.selectedItemList.isNotEmpty? Text("kkkk"): Text("mmmmm")),
           }     ,   
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10)        
          ));
        },
      ),
    );
  }
}