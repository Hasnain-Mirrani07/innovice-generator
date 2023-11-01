import 'package:fan_side_drawer/fan_side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovice_generator/widget/custom_dialogbox.dart';
import 'package:printing/printing.dart';

import 'package:innovice_generator/bill_innovoice/bill_innovice/api/pdf_api.dart';

import '../../../paragraph_to_pdf/billing_inovice_viewmodel.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/custome_drawer.dart';
import '../api/pdf_invoice_api.dart';
import '../model/customer.dart';
import '../model/invoice.dart';
import '../model/supplier.dart';
import '../utils.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import '../widget/title_widget.dart';

class BillingInnoviceView extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<BillingInnoviceView> {
  final viewModel = Get.put(BillingInoviceViewModel());
  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        drawer: drawerWidged(),
        appBar: appbarWidged(context),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 48),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: 350,
                  child: PdfPreview(
                    padding: EdgeInsets.zero,
                    // maxPageWidth: double.infinity,
                    //  useActions: true,
                    build: (context) {
                      //innovice created hard coded
                      final date = DateTime.now();
                      final dueDate = date.add(Duration(days: 7));

                      final invoice = Invoice(
                        supplier: Supplier(
                          name: '${viewModel.title.value}',
                          address: '${viewModel.adress.value}',
                          paymentInfo: '${viewModel.paymentMethod.value}',
                        ),
                        customer: Customer(
                          name: 'Apple Inc.',
                          address: 'Apple Street, Cupertino, CA 95014',
                        ),
                        info: InvoiceInfo(
                          date: date,
                          dueDate: dueDate,
                          description: 'My description...',
                          number: '${DateTime.now().year}-9999',
                        ),
                        items: [
                          InvoiceItem(
                            description: 'Coffee',
                            date: DateTime.now(),
                            quantity: 3,
                            vat: 0.19,
                            unitPrice: 5.99,
                          ),
                          InvoiceItem(
                            description: 'Water',
                            date: DateTime.now(),
                            quantity: 8,
                            vat: 0.19,
                            unitPrice: 0.99,
                          ),
                          InvoiceItem(
                            description: 'Orange',
                            date: DateTime.now(),
                            quantity: 3,
                            vat: 0.19,
                            unitPrice: 2.99,
                          ),
                          InvoiceItem(
                            description: 'Apple',
                            date: DateTime.now(),
                            quantity: 8,
                            vat: 0.19,
                            unitPrice: 3.99,
                          ),
                          InvoiceItem(
                            description: 'Mango',
                            date: DateTime.now(),
                            quantity: 1,
                            vat: 0.19,
                            unitPrice: 1.59,
                          ),
                          InvoiceItem(
                            description: 'Blue Berries',
                            date: DateTime.now(),
                            quantity: 5,
                            vat: 0.19,
                            unitPrice: 0.99,
                          ),
                          InvoiceItem(
                            description: 'Lemon',
                            date: DateTime.now(),
                            quantity: 4,
                            vat: 0.19,
                            unitPrice: 1.29,
                          ),
                        ],
                      );

                      return PdfInvoiceApi.generate(invoice);
                      //viewModel.createPDF();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

Widget drawerWidged() {
  return Drawer(
    backgroundColor: Colors.black,
    width: 255,
    child: FanSideDrawer(
      selectedItemBackgroundColor: Colors.grey,
      selectedColor: Colors.black,
      unSelectedColor: Colors.white,
      menuItems: CustomDrawer.menuItems,
    ),
  );
}

AppBar appbarWidged(BuildContext context) {
  return AppBar(
    title: Text("Billing Inovice"),
    actions: [
      GestureDetector(
        onTap: () {
          CustomDialogBox.showDialogWithFields(context);
        },
        child: Row(
          children: [
            Text(
              "Edit Inovice",
              style: TextStyle(fontSize: 15, color: Colors.red),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          ],
        ),
      )
    ],
    centerTitle: true,
  );
}
