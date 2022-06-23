import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';

import '../../models/order_model.dart';
import '../../services/firestore_services.dart';

class StockView extends StatelessWidget {
  const StockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
    
    child: FirestoreQueryBuilder<Order>(
        query: FirestoreServices.getOrderQuery,
        builder: (context, snapshot, _) {
      
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
    
             final user = snapshot.docs[index].data();
    
             return Container(
               padding: const EdgeInsets.all(8),
               color: Colors.teal[100],
               child:  Text(user.orderType),
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