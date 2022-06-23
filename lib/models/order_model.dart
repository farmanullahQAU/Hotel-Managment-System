
import '../constants/firestore_constants.dart';
import 'item_model.dart';

class Order {
   late  List<Item> items;
   late double totalCost;
   late final String orderType;

  
  Order(
      { required this.items,
      
      required this.orderType,
      required this.totalCost,
      
      });

         Map<String, dynamic> toMap() {

    return {
    FirestoreConstants.orderItems:items.map((item) => item.toMap()).toList(),
    FirestoreConstants.orderTtype:orderType,
    FirestoreConstants.totalCost:totalCost,
 



  

    };
  }
   Order.fromMap( Map<String, dynamic>  data,id) {

     



  orderType=data[FirestoreConstants.orderTtype];
 
  items=<Item>[];

      data[FirestoreConstants.orderItems].forEach((item) {
        items.add(Item.fromMap(item ));
      });

      
    


  totalCost=data[FirestoreConstants.totalCost];



  }



   
}
