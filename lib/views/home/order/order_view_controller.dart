import 'dart:io';

import 'package:baidarg/constants/text_const.dart';
import 'package:baidarg/models/order_model.dart';
import 'package:baidarg/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../models/item_model.dart';
import 'package:pdf/widgets.dart' as pw;


class OrderViewController extends GetxController{
final TextEditingController itemName=TextEditingController();
final TextEditingController itemPrice=TextEditingController();
final TextEditingController quantityController=TextEditingController();



final TextEditingController itemCategory=TextEditingController();

  late final RxList<Item> _items;
  final List<String> orderTypes=[order,parsal];

  List<Item> get items=>_items;
  

  set addToList(Item item)=>_items.add(item);
GlobalKey<FormState> formKey=GlobalKey<FormState>();
RxBool isOrderAdding=false.obs;


 late final RxSet<Item> _selectedItemList;

  Set<Item> get selectedItemList=>_selectedItemList;

  final RxInt _radioValue=1.obs;
  int get radioValue=>_radioValue.value;
set radioValue(int val)=>_radioValue.value=val;

  set addToSelectedItemsList(Item item){
//if the item is checked then add else remove this from selectedList set
    item.isSelected?_selectedItemList.add(item):_selectedItemList.remove(item);
  }
//calculate total price for selected items
  double calculateTotalCost(){

    double total=0;

    for (var item in selectedItemList) {
total=total+(item.price*item.selectedQuantity!);

     }

     return total;
  }
  @override
  void onInit() {
_selectedItemList=<Item>{}.obs;
    _items=<Item>[].obs;
    super.onInit();
  }

  Future<void> addItemToFirestore() async {
    final item= Item(category: itemCategory.text,itemName: itemName.text,price: double.parse(itemPrice.text),stockQuantity: int.parse(quantityController.text));
    await FirestoreServices.addItem(item);


  }

  Order createOrder(){

    return Order(items: selectedItemList.toList(), orderType: orderTypes[radioValue], totalCost: calculateTotalCost());


  }

Future addOrderToFirestore(Order order)
async {
  isOrderAdding.value=true;
try{
unSelectSelected();

await FirestoreServices.addOrderToDB(order);


}
catch(error){
isOrderAdding.value=false;
  Get.showSnackbar(GetSnackBar(title: error.toString(),backgroundColor: Colors.red,));
}

isOrderAdding.value=false;
}

  void unSelectSelected() {

    for (int index=0;index<items.length;index++) { 

      final item=items.toList()[index];
      item.isSelected=false;
items[index]=item;
      
    }
  }





}