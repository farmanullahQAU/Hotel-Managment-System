

import '../constants/firestore_constants.dart';

class Item {
   late final String itemName;
   late final String itemId;
   bool isSelected=false;
   int? selectedQuantity=1;
   late final double price;
   late final String category;
   late final int? stockQuantity;

  
  Item(
      { required this.itemName,
      
      required this.price,
    this.stockQuantity,
      required this.category,
      this.selectedQuantity
      
      });

         Map<String, dynamic> toMap() {

    return {
    FirestoreConstants.category:category,
    FirestoreConstants.price:price,
    FirestoreConstants.itemName:itemName,
    FirestoreConstants.stockQuantity:stockQuantity,
    
    FirestoreConstants.itemId:itemId

 



  

    };
  }
   Item.fromMap( Map<String, dynamic>  data) {
print("itemidiididdididi");
print(data["item_id"]);
     itemId=data[FirestoreConstants.itemId];

  category=data[FirestoreConstants.category];

  price=data[FirestoreConstants.price];
  stockQuantity=data[FirestoreConstants.stockQuantity];


  itemName=data[FirestoreConstants.itemName];

  }



   
}
