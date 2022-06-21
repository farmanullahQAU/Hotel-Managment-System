

import '../constants/firestore_constants.dart';

class Item {
   late final String itemName;
   bool isSelected=false;
   int? selectedQuantity=1;
   late final double price;
   late final String category;

  
  Item(
      { required this.itemName,
      
      required this.price,
      required this.category,
      this.selectedQuantity
      
      });

         Map<String, dynamic> toMap() {

    return {
    FirestoreConstants.category:category,
    FirestoreConstants.price:price,
    FirestoreConstants.itemName:itemName,
 



  

    };
  }
   Item.fromMap( Map<String, dynamic>  data,id) {

     



  category=data[FirestoreConstants.category];

  price=data[FirestoreConstants.price];

  itemName=data[FirestoreConstants.itemName];

  }



   
}
