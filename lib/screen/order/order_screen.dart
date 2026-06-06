import 'package:coffe_app/screen/order/address_section.dart';
import 'package:coffe_app/screen/order/payment_summary_section.dart';
import 'package:coffe_app/screen/order/product_section.dart';
import 'package:coffe_app/screen/order/wallet_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/custom_button.dart';
import '../../router/app_router/app_router.dart';
import 'discount_section.dart';
import 'order_header_section.dart';
import 'order_tabs.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          child: Column(
            children: [
              const OrderHeaderSection(),
              const SizedBox(height: 24),
              OrderTabs(
                selectedIndex: selectedTabIndex,
                onChanged: (index) {
                  setState(() {
                    selectedTabIndex = index;
                  });
                },
              ),
              const SizedBox(height: 24),
              if (selectedTabIndex == 0) ...[
                const AddressSection(),
                Divider(
                  height: 30,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  thickness: 1,
                ),
              ],
              ProductSection(),
              Divider(
                height: 50,
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                thickness: 2,
              ),
              DiscountSection(),
              SizedBox(height: 30),
              PaymentSummarySection(),
              SizedBox(height: 10),
              WalletSection(),
              SizedBox(height: 50),
              CustomButton(
                text: 'Order',
                onPressed: () => context.push(AppRoutes.map.path),
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
