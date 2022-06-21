

import 'dart:io';

import 'package:baidarg/constants/text_const.dart';
import 'package:baidarg/localization/locale_constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:html'as html;

import '../models/order_model.dart';
import 'time_services.dart';

class PdfInvoicesApi{

   static Future generate(Order order) async{
    ByteData byteData=await rootBundle.load("assets/fonts/OpenSans.ttf");
    final font=Font.ttf(byteData);

final pdf=Document();
     pdf.addPage(MultiPage(build:(conext)=>[
buildTitle( order,font),
buildTable(order,font),
Divider(),
buildTotal(order.items.length,order.totalCost,order.orderType)




     ] ));

    final bytes=await  pdf.save();
        final blob = html.Blob([bytes], 'application/pdf');
            final url = html.Url.createObjectUrlFromBlob(blob);
                html.window.open(url, "_blank");
                html.Url.revokeObjectUrl(url);
  }

  
/*

//download the pdf file
 final url = html.Url.createObjectUrlFromBlob(blob);
                final anchor =
                    html.document.createElement('a') as html.AnchorElement
                      ..href = url
                      ..style.display = 'none'
                      ..download = 'some_name.pdf';
                html.document.body?.children.add(anchor);
                anchor.click();
                html.document.body?.children.remove*/


  
  static buildTitle(Order items,Font font)  {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Align(alignment: Alignment.center,child: Text("${LocaleConstants.title}".tr)),

      Text('invoice',style:TextStyle(font: font,fontSize:15)),

      SizedBox(height: 0.9*PdfPageFormat.cm)
    
    ]);
  }
  
  static Future openFile(File file)async{
final url=file.path;
print("urrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
print(url);
 await OpenFile.open(url);


  }
  
   static buildTable(Order order, Font font) {

    final headers=[
      "Item",
"category",
      "unit price",
      "Quantity",
      "Total"

    ];

    final data=order.items.map((item) => [
      item.itemName.tr,
      item.category,

      item.price,
      item.selectedQuantity,
      //perItemPrice*quantity
item.selectedQuantity!*item.price,

      



    ]).toList();
 return Table.fromTextArray(data: data,headers: headers,border: null,headerStyle: TextStyle(fontWeight: FontWeight.bold,)
 
 ,headerDecoration: BoxDecoration(color: PdfColors.grey200),cellHeight: 30,cellAlignments:{
  0:Alignment.centerLeft,
  1:Alignment.centerLeft,
  2:Alignment.centerLeft,
  3:Alignment.centerLeft,
  4:Alignment.centerLeft,
  5:Alignment.centerLeft


 }
 );

  }
  
  static buildTotal(int totalItems, double totalPrice,String orderType) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,

      children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
Row(
  
  children: [

  Text("Total Cost"),
  SizedBox(width:50),
  Text(totalPrice.toString())
]),
SizedBox(height: 10),

Row(
  
  children: [

  Text("Total Items"),
  SizedBox(width:50),
  Text(totalItems.toString())
]),
SizedBox(height: 10),
Row(
  
  children: [

  Text("Date Generated"),
  SizedBox(width:50),
  Text(ServiceProvider().formatDateTime(DateTime.now()))

]),
Row(
  
  children: [

  Text("Order Type"),
  SizedBox(width:50),
  Text(orderType)

])



        ]),
      ]
    );
  }

}