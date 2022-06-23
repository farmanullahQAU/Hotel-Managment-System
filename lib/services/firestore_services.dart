

import 'package:baidarg/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firestore_constants.dart';
import '../models/order_model.dart';

class FirestoreServices{

static Future<void> addItem(Item item){




 return  FirebaseFirestore.instance.collection(FirestoreConstants.itemCollectionName).doc(item.itemName.toLowerCase()).set(item.toMap());
}


static Future addOrderToDB(Order order)async{
 return  await FirebaseFirestore.instance.collection(FirestoreConstants.orderCollectionName).add(order.toMap());

  
}

static final itemQuery = FirebaseFirestore.instance.collection(FirestoreConstants.itemCollectionName)
  // .orderBy(FirestoreConstants.dateFinished, descending: true)
  .withConverter<Item>(
     fromFirestore: (snapshot, _) => Item.fromMap(snapshot.data()!,id:snapshot.id),
     toFirestore: (item, _) => item.toMap(),
   );

    static final getOrderQuery = FirebaseFirestore.instance.collection(FirestoreConstants.orderCollectionName)
  // .orderBy(FirestoreConstants.dateFinished, descending: true)
  .withConverter<Order>(
     fromFirestore: (snapshot, _) => Order.fromMap(snapshot.data()!,snapshot.id),
     toFirestore: (order, _) => order.toMap(),
   );

  

  }
  