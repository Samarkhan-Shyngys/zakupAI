import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'admin_dashboard_screen.dart';
import 'admin_orders_screen.dart';
import 'aggregated_order_screen.dart';
import 'admin_analytics_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _index = 0;

  static const _pages = [
    AdminDashboardScreen(),
    AdminOrdersScreen(),
    AggregatedOrderScreen(),
    AdminAnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_rounded), label: 'Дашборд'),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_rounded), label: 'Заказы'),
            BottomNavigationBarItem(
                icon: Icon(Icons.merge_rounded), label: 'Сводный'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_rounded), label: 'Аналитика'),
          ],
        ),
      ),
    );
  }
}
