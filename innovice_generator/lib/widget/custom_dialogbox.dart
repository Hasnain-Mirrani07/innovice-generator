import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../bill_innovoice/bill_innovice/page/billing_innovice_view.dart';
import '../paragraph_to_pdf/billing_inovice_viewmodel.dart';

class CustomDialogBox {
  static void showDialogWithFields(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        final viewModel = Get.put(BillingInoviceViewModel());
        var titleController = TextEditingController();
        var adress = TextEditingController();
        var paymentMethod = TextEditingController();
        return AlertDialog(
          title: Text('Contact Us'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * .8,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                TextFormField(
                  controller: adress,
                  decoration: InputDecoration(hintText: 'Message'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            // TextButton(
            //   onPressed: () {
            //     // Send them to your email maybe?
            //     viewModel.title.value = titleController.text.toString();
            //     viewModel.adress.value = adress.text;
            //     viewModel.paymentMethod.value = paymentMethod.text;
            //     Get.offAll(() => BillingInnoviceView());
            //     //  Navigator.pop(context);
            //   },
            //   child: Text('Send'),
            // ),
          ],
        );
      },
    );
  }
}
