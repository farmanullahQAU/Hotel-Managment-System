

import 'package:baidarg/models/item_model.dart';
import 'package:baidarg/views/home/order/order_view_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../constants/firestore_constants.dart';
import '../models/order_model.dart';

class FirestoreServices{

// static Future<void> addItem(Item item){




//  return  FirebaseFirestore.instance.collection(FirestoreConstants.itemCollectionName).doc(item.itemName.toLowerCase()).set(item.toMap());
// }

static Future<void> addItem(Item item)async{




 DocumentReference documentReference=  FirebaseFirestore.instance.collection(FirestoreConstants.itemCollectionName).doc();
 //set item id
 item.itemId=documentReference.id;

 return documentReference.set(item.toMap());
}



static Future addOrderToDB(Order order)async{


for (var element in order.items) { 

if(

element.stockQuantity!=null

){

if(

  element.selectedQuantity!=null&&(element.stockQuantity!>element.selectedQuantity!)

){

  int newStockQuanity=element.stockQuantity!-element.selectedQuantity!;
print("selected qty: ${element.selectedQuantity} ");
  
print("old stock: ${element.stockQuantity} ");

print("new stock: $newStockQuanity ");

FirebaseFirestore.instance.collection(FirestoreConstants.itemCollectionName).doc(element.itemId).update({

FirestoreConstants.stockQuantity:newStockQuanity

});


 }

}

}
 return  await FirebaseFirestore.instance.collection(FirestoreConstants.orderCollectionName).add(order.toMap());

  
}

static final itemQuery = FirebaseFirestore.instance.collection(FirestoreConstants.itemCollectionName)
  // .orderBy(FirestoreConstants.dateFinished, descending: true)
  .withConverter<Item>(
     fromFirestore: (snapshot, _) => Item.fromMap(snapshot.data()!),
     toFirestore: (item, _) => item.toMap(),
   );

    static final getOrderQuery = FirebaseFirestore.instance.collection(FirestoreConstants.orderCollectionName)
  // .orderBy(FirestoreConstants.dateFinished, descending: true)
  .withConverter<Order>(
     fromFirestore: (snapshot, _) => Order.fromMap(snapshot.data()!,snapshot.id),
     toFirestore: (order, _) => order.toMap(),
   );

  

  }
  