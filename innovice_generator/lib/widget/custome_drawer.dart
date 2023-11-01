import 'package:fan_side_drawer/fan_side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:innovice_generator/paragraph_to_pdf/paragraph_to_pdf.dart';

import '../bill_innovoice/bill_innovice/page/billing_innovice_view.dart';

class CustomDrawer {
  static List<DrawerMenuItem> get menuItems => [
        DrawerMenuItem(
            title: 'Billing Innovice',
            icon: Icons.house_rounded,
            iconSize: 15,
            onMenuTapped: () {
              Get.to(() => BillingInnoviceView());
            }),
        DrawerMenuItem(
            title: 'Salary Slip',
            icon: Icons.account_circle_rounded,
            iconSize: 15,
            onMenuTapped: () {}),
        DrawerMenuItem(
            title: 'Image to PDF',
            icon: Icons.info_rounded,
            iconSize: 15,
            onMenuTapped: () {}),
        DrawerMenuItem(
            title: 'Paragraph to PDF',
            icon: Icons.wallet_rounded,
            iconSize: 15,
            onMenuTapped: () {
              Get.to(() => ParagraphToPDF());
            }),
        DrawerMenuItem(
            title: 'More Features Comming Soon',
            icon: Icons.downloading,
            iconSize: 15,
            onMenuTapped: () {}),
      ];
}
