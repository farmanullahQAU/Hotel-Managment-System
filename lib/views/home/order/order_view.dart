import 'dart:io';
import 'dart:typed_data';

import 'package:baidarg/components/textfield.dart';
import 'package:baidarg/constants/text_const.dart';
import 'package:baidarg/responsive/responsive_wrapper.dart';
import 'package:baidarg/services/firestore_services.dart';
import 'package:baidarg/services/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:get/state_manager.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../models/item_model.dart';
import 'dart:html'as html;

import '../../../models/order_model.dart';
import 'order_view_controller.dart';

class OrderView extends GetView<OrderViewController> {
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

      
      
            FloatingActionButton(onPressed: ()async{

      
              await showntryForm();
            },child: const Icon(Icons.add),),
          ],
        ),
      body: FirestoreQueryBuilder<Item>(
      query: FirestoreServices.itemQuery,
      builder: (context, snapshot, _) {



        print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
    
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
                     ResponsiveWidget.isLargeScreen(context)?
                     _addItemsGridView(snapshot,10):_addItemsGridView(snapshot,2),
                  
                        //if no item is selected the don't show the pdf button else show
       _addInvoiceButton(),

      SizedBox(height: 20,)
                  
                    ],
                  ),
                ),
              ),
              Container(
                
                // color: Colors.red,
                height: 400,width: double.infinity,),
            ],
          ),
        ),
      );
      },
    ),
    );
  }

  Future showntryForm({bool? isupdate, String? itemId}) async {
   return await Get.defaultDialog(
              
              onConfirm: () async {

                if(controller.formKey.currentState!.validate())
                {
                  isupdate==true?
                  await controller.updateItem(itemId!):
await controller.addItemToFirestore();
    Get.back();

                }
    
  
    
              },
    
              onCancel: (){},
              
              content: const ItemEntryForm());
  }

  Widget _addInvoiceButton()  {
    return Obx(()=>
      AnimatedSwitcher(

           duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          
        child: controller.selectedItemList.isEmpty?Container():
              SizedBox(

                height: 60,
                child: ElevatedButton.icon(onPressed: () async {
              
              
                        final Order order=controller.createOrder();
                        //first add order to firestore then generate invice
                       await controller.addOrderToFirestore(order);
                       await PdfInvoicesApi.generate(order);
              
              
                  
              
              
                },icon: Obx(()=>
                
                
                controller.isOrderAdding.isTrue?const Center(child: CircularProgressIndicator(),):
                 const Icon(Icons.picture_as_pdf)), label: Text("Generate Invoice"),),
              ),
      ),
    );
  }

  GridView _addItemsGridView(FirestoreQueryBuilderSnapshot<Item> snapshot,int crossAxisCount) {
    return GridView.builder(
                    
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Obx(()=>
                           Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                            
                               CircleAvatar(
                                backgroundColor: Theme.of(context).backgroundColor,
                                radius: 53,
                                 child: CircleAvatar(
                                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  radius: 50,
                                  child: Text(item.itemName.tr)),
                               ),
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
                                         Align(alignment: Alignment.topLeft,child: IconButton(
                                          onPressed: () async {
controller.fillFields(item);
              await showntryForm(isupdate: true,itemId: item.itemId);
                                            
                                          },
                                          icon: Icon(Icons.edit)),),
                                     item.stockQuantity!=null?   Text(item.stockQuantity.toString()):Text(""),
                                                            
                                        Expanded(
                                          child: TextField(
                                               inputFormatters: 
              
      [ FilteringTextInputFormatter.allow(RegExp("[0-9.]")),],
                                          
                                          
                                            // controller: TextEditingController(text: item.selectedQuantity.toString()),
                                            
                                            
                                            decoration: InputDecoration(
                                        
                                        
                                        labelText: "Quantity".tr,
                                              border: OutlineInputBorder()
                                            ),
                                            
                                            onChanged: (val){
                                              //if users enter quantity then set field for item
                                      item.selectedQuantity=int.parse(val);
                                           controller.addToSelectedItemsList=item;
                                           
                                          },),
                                        ),
                                       
                                                            
                                        
                                   ],
                                 ),
                               ),
                             ],
                           ),
                          ),
                        );
                      }, gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (1 / 2),
                      mainAxisSpacing: 10,
                        crossAxisCount: crossAxisCount),
                    );
  }

  
}
class RadioButtons extends GetView<OrderViewController> {
  const RadioButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
       Row(
         crossAxisAlignment: CrossAxisAlignment.end,
         mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
            Spacer(),
           for (int i = 0; i < 2; i++)
        Expanded(
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
            Spacer(),

           ],
         ),
    );
  }
}

class ItemEntryForm extends GetView<OrderViewController> {
  const ItemEntryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: !ResponsiveWidget.isLargeScreen(context)?context.width*0.8:context.width*0.4,
      
      
      child: Form(

        key: controller.formKey,
        child: Column(
          
          children: [
          
            TxtField(
              validator: (value)=>value==null||value==""?"required":null,


            lblTxt: itemName.tr,

              
              controller:controller.itemName ,

            
              hintTxt:itemName.tr,),
            const SizedBox(height: 20,),
            TxtField(

                       validator: (value)=>value==null||value==""?"required":
                       
                       null,

              lblTxt: itemPrice.tr,
              inputFormatters: 
              
      [ FilteringTextInputFormatter.allow(RegExp("[0-9.]")),],
              
              
              textInputType: TextInputType.number,
              controller: controller.itemPrice,
              hintTxt:itemPrice.tr,),
            const SizedBox(height: 20,),
            TxtField(
                     validator: (value)=>value==null||value==""?"required":null,


              lblTxt:itemCategory.tr,
              controller: controller.itemCategory,
              hintTxt:itemCategory.tr,),


            const SizedBox(height: 20,),

            TxtField(

            lblTxt: itemQuantity.tr,

              
              controller:controller.quantityController ,

            
              hintTxt:itemQuantity.tr,),
          
          
          
          ],
        ),
      ),
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