import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:innovice_generator/helper/theme_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class BillUI extends GetxController {
// for Qr scane and novert into pdf bytes
  late pw.MemoryImage qrImage;
  //
  // createQr(Map<String, dynamic> invoiceData) async {
  //   final image = await QrPainter(
  //     data: invoiceNumber,
  //     version: QrVersions.auto,
  //   ).toImageData(300);
  //
  //   Uint8List bytes = image!.buffer.asUint8List();
  //   qrImage = pw.MemoryImage(bytes);
  //
  //   receiptDialog(invoiceData);
  // }

  Future receiptDialog(Map<String, dynamic> invoiceData) async {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: ThemeHelper.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          child: SizedBox(
            width: 400,
            child: Scaffold(
              appBar: AppBar(),
              body: PdfPreview(
                canDebug: false,
                canChangeOrientation: false,
                canChangePageFormat: false,
                initialPageFormat: const PdfPageFormat(100, double.minPositive),
                build: (format) => createPDF(invoiceData),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<Uint8List> createPDF(Map<String, dynamic> receiptData) async {
    final backgroundLogo = pw.MemoryImage(
        (await rootBundle.load('assets/images/logo_black.png'))
            .buffer
            .asUint8List());
    final fbrPosLogo = pw.MemoryImage(
        (await rootBundle.load('assets/images/fbr_pos_logo.png'))
            .buffer
            .asUint8List());

    var pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (context) {
          return pw.Column(
            children: [
              pw.Image(
                backgroundLogo,
                width: 100,
                height: 100,
              ),
              pw.Text(
                'ISMMART',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 10, bottom: 5),
                child: pw.Text(
                  'Address of Shop where this POS will be operated. Address of Shop where this POS will be operated.',
                  textAlign: pw.TextAlign.center,
                  style: const pw.TextStyle(
                    fontSize: 7,
                  ),
                ),
              ),
              infoItem(
                'Order ID: ${receiptData['USIN']}',
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 10, bottom: 10),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    infoItem(
                      'STRN: 541516165156',
                    ),
                    infoItem(
                      'NTN: 554444',
                    ),
                  ],
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 6, bottom: 3),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    infoItem('29-10-2023'),
                    infoItem('7:14:49 pm'),
                  ],
                ),
              ),
              pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(width: 0.5),
                ),
                child: pw.Column(
                  children: [
                    pw.Row(
                      children: [
                        headingItem('Price'),
                        headingItem('GST%'),
                        headingItem('Qty'),
                        headingItem('GST'),
                        headingItem('Total'),
                      ],
                    ),
                    pw.Divider(thickness: 0.5),
                    pw.ListView.builder(
                      itemCount: receiptData['Items'].length,
                      itemBuilder: (context, index) {
                        final itemName =
                            receiptData['Items'][index]['ItemName'];
                        return pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              itemName,
                              textAlign: pw.TextAlign.center,
                              maxLines: 2,
                              style: pw.TextStyle(
                                fontSize: 5.5,
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Padding(
                              padding:
                                  const pw.EdgeInsets.only(top: 6, bottom: 10),
                              child: pw.Row(
                                children: [
                                  productItem2(
                                      receiptData['Items'][index]['SaleValue']),
                                  productItem2('18'),
                                  productItem2(
                                      receiptData['Items'][index]['Quantity']),
                                  productItem2(receiptData['Items'][index]
                                      ['TaxCharged']),
                                  productItem2(receiptData['Items'][index]
                                      ['TotalAmount']),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    pw.Divider(thickness: 0.5),
                    calculationItem(
                        'Total Amount: ${receiptData['TotalSaleValue']}'),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 5),
                      child: calculationItem(
                          'Total GST: ${receiptData['TotalTaxCharged']}'),
                    ),
                    //calculationItem('Discount (if any):  Rs 00.00'),
                    calculationItem(
                        'Grand Total: ${receiptData['TotalBillAmount']}'),
                    // calculationItem('Paid Amount:  Rs 00.00'),
                    // pw.SizedBox(height: 5),
                    // calculationItem('Balance:  Rs 00.00'),
                  ],
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                'Thanks for visiting us',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 7,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 10, bottom: 2),
                child: pw.Text(
                  'FBR Invoice No:',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                receiptData['InvoiceNumber'],
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 12),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Image(
                      fbrPosLogo,
                      width: 60,
                      height: 60,
                    ),
                    // pw.SizedBox(width: 20),
                    pw.Image(
                      qrImage,
                      width: 60,
                      height: 60,
                    ),
                  ],
                ),
              ),
              pw.Text(
                'Verify this invoice through FBR TaxAsaan Mobile App or SMS at 9966 and win exciting prizes in draw.',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.normal,
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.Text infoItem(String value) {
    return pw.Text(
      value,
      textAlign: pw.TextAlign.right,
      style: const pw.TextStyle(
        fontSize: 7,
      ),
    );
  }

  pw.Text calculationItem(String value) {
    return pw.Text(
      value,
      style: const pw.TextStyle(
        fontSize: 7,
      ),
    );
  }

  pw.Expanded headingItem(String value) {
    return pw.Expanded(
      child: pw.Align(
        alignment: pw.Alignment.center,
        child: pw.Text(
          value,
          style: const pw.TextStyle(
            fontSize: 6.5,
          ),
        ),
      ),
    );
  }

  pw.Expanded productItem2(String receiptData) {
    return pw.Expanded(
      child: pw.Align(
        alignment: pw.Alignment.center,
        child: pw.Text(
          //show data fixd at 2 decimal places,
          receiptData,
          style: pw.TextStyle(
            fontSize: 5.5,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
