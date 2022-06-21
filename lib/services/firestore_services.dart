

import 'package:baidarg/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firestore_constants.dart';

class FirestoreServices{

static Future<void> addItem(Item item){




 return  FirebaseFirestore.instance.collection(FirestoreConstants.itemCollectionName).doc(item.itemName.toLowerCase()).set(item.toMap());
}

static final itemQuery = FirebaseFirestore.instance.collection(FirestoreConstants.itemCollectionName)
  // .orderBy(FirestoreConstants.dateFinished, descending: true)
  .withConverter<Item>(
     fromFirestore: (snapshot, _) => Item.fromMap(snapshot.data()!,snapshot.id),
     toFirestore: (item, _) => item.toMap(),
   );

    

  

  }
  