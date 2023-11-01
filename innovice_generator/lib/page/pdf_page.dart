import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../api/pdf_api.dart';
import '../api/pdf_paragraph_api.dart';
import '../main.dart';
import 'package:pdf/widgets.dart' as pw;

import '../widget/button_widget.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  Future<Uint8List> simpleTextToPdf() async {
    print("get document dir --- ");
    final pdf = pw.Document();
    // final font = await PdfGoogleFonts.nunitoExtraLight();
    final emoji = await PdfGoogleFonts.notoColorEmoji();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              'Hello 🐒💁👌🎍😍🦊👨 world!',
              style: pw.TextStyle(
                fontFallback: [emoji],
                fontSize: 25,
              ),
            ),
          ); // Center
        }));

    /// Page

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  width: 300,
                  child: SizedBox(
                    height: 500,
                    width: 300,
                    child: PdfPreview(
                      padding: EdgeInsets.zero,
                      // maxPageWidth: double.infinity,
                      //  useActions: true,
                      build: (context) {
                        return PdfParagraphApi.generate();
                        //viewModel.createPDF();
                      },
                    ),
                  ),
                ),

                //jk,hjkl,ghjkl
                // ButtonWidget(
                //   text: 'Simple PDF',
                //   onClicked: () async {
                //     final pdfFile =
                //         await PdfApi.generateCenteredText('Sample Text');
                //
                //     //  PdfApi.openFile(pdfFile);
                //   },
                // ),
                // const SizedBox(height: 24),
                // ButtonWidget(
                //   text: 'Paragraphs PDF',
                //   onClicked: () async {
                //     final pdfFile = await PdfParagraphApi.generate();
                //
                //     //   PdfApi.openFile(pdfFile);
                //   },
                // ),
                //
              ],
            ),
          ),
        ),
      );
}
