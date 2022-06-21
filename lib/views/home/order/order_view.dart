import 'dart:io';
import 'dart:typed_data';

import 'package:baidarg/components/textfield.dart';
import 'package:baidarg/constants/text_const.dart';
import 'package:baidarg/services/firestore_services.dart';
import 'package:baidarg/services/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:get/state_manager.dart';

import '../../../models/item_model.dart';
import 'dart:html'as html;

import '../../../models/order_model.dart';
import 'order_view_controller.dart';

class OrderView extends GetView<OrderViewController> {
   Uint8List? uint8list;
   OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("calll");

    return Scaffold(


      floatingActionButton: 
         Column(
      
      crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

      
            //if no item is selected the don't show the pdf button else show
      Obx(()=>
        AnimatedSwitcher(

             duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            
          child: controller.selectedItemList.isEmpty?Container():
                FloatingActionButton(onPressed: () async {
          final Order order=controller.createOrder();
         uint8list    =   await PdfInvoicesApi.generate(order);


                  


                },child: const Icon(Icons.picture_as_pdf),),
        ),
      ),
            FloatingActionButton(onPressed: (){

    // anchor.click();
      
      //         Get.defaultDialog(
                
      //           onConfirm: () async {
      
      // await controller.addItemToFirestore();
      // Get.back();
      
      //           },
      
      //           onCancel: (){},
                
      //           content: const ItemEntryForm());
            },child: const Icon(Icons.add),),
          ],
        ),
      body: FirestoreQueryBuilder<Item>(
      query: FirestoreServices.itemQuery,
      builder: (context, snapshot, _) {
    
      return SizedBox(

        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            //show no radio button is no item is selected
          Obx(()=>


          AnimatedSwitcher(
switchInCurve: Curves.easeIn,

             duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: controller.selectedItemList.isEmpty?Container():  
                RadioButtons(),
          ),
          ),
                // Obx(()=> controller.selectedItemList.isNotEmpty? Text("kkkk"): Text("mmmmm")),
              SizedBox(
              
                width: context.width,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GridView.builder(
                      
                        padding: EdgeInsets.all(10),
                        
                        
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
                      controller.addToList=item;
                        
                        
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                
                              height: 30,width: 50,
                              child: Obx(()=>
                               Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                
                                   Text(item.itemName.tr),
                                   Expanded(
                                     child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [
                                         Checkbox(
                                            
                                              checkColor: Colors.white,
                                              value: controller.items[index].isSelected,
                                              onChanged: (bool? value) {
                                                //select/deselect
                                            item.isSelected=!item.isSelected;
                                            //update the list
                                            controller.items[index]=item;
                                               
                                            //add to list which only contains selected items
                                                                controller.addToSelectedItemsList=item;
                                              },
                                            ),
                                            SizedBox(height: 10,),
                                                                
                                            TextField(
                                              // controller: TextEditingController(text: item.selectedQuantity.toString()),
                                              
                                              
                                              decoration: InputDecoration(

                                                border: OutlineInputBorder()
                                              ),
                                              
                                              onChanged: (val){
                                            
                                              controller.selectedItemList.toList()[index].selectedQuantity=int.parse(val);
                                            },)
                                                                
                                            
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                              ),
                            ),
                          );
                        }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
                      ),
                  
                  Text("kkk")
                  
                    ],
                  ),
                ),
              ),
              Container(
                
                color: Colors.red,
                height: 400,width: double.infinity,),
            ],
          ),
        ),
      );
      },
    ),
    );
  }

  
}
class RadioButtons extends GetView<OrderViewController> {
  const RadioButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
       Column(
         crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
      for (int i = 0; i < 2; i++)
        SizedBox(
          width: 300,
          height: 50,
          child: ListTile(
            title: Text(
            i==0?order.tr:parsal.tr,
              // style: Theme.of(context).textTheme.subtitle1.copyWith(color: i == 5 ? Colors.black38 : Colors.black),
            ),
            leading: Radio(
              value: i,
              groupValue: controller.radioValue,
              // activeColor: Color(0xFF6200EE),
              onChanged : (int? value) {
                  controller.radioValue = value!;
                }
            ),
          ),
        ),
      ],
    ),
    );
  }
}

class ItemEntryForm extends GetView<OrderViewController> {
  const ItemEntryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [

        TxtField(
          controller:controller.itemName ,
          hintTxt:itemName.tr,),
        const SizedBox(height: 20,),
        TxtField(
          controller: controller.itemPrice,
          hintTxt:itemPrice.tr,),
        const SizedBox(height: 20,),
        TxtField(
          controller: controller.itemCategory,
          hintTxt:itemCategory.tr,),



      ],
    );
  }
}




class PdfDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          );
        }));
    final bytes = pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Open"),
              onPressed: () {
                final url = html.Url.createObjectUrlFromBlob(blob);
                html.window.open(url, "_blank");
                html.Url.revokeObjectUrl(url);
              },
            ),
            RaisedButton(
              child: Text("Download"),
              onPressed: () {
                final url = html.Url.createObjectUrlFromBlob(blob);
                final anchor =
                    html.document.createElement('a') as html.AnchorElement
                      ..href = url
                      ..style.display = 'none'
                      ..download = 'some_name.pdf';
                html.document.body?.children.add(anchor);
                anchor.click();
                html.document.body?.children.remove(anchor);
                html.Url.revokeObjectUrl(url);
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}