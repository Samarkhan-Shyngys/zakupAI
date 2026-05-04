import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'manager_home_screen.dart';
import 'product_catalog_screen.dart';
import 'cart_screen.dart';
import 'manager_orders_screen.dart';

class ManagerMainScreen extends StatefulWidget {
  const ManagerMainScreen({super.key});

  @override
  State<ManagerMainScreen> createState() => _ManagerMainScreenState();
}

class _ManagerMainScreenState extends State<ManagerMainScreen> {
  int _index = 0;

  static const _pages = [
    ManagerHomeScreen(),
    ProductCatalogScreen(),
    CartScreen(),
    ManagerOrdersScreen(),
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
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Главная'),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Каталог'),
            BottomNavigationBarItem(
              icon: Badge(label: Text('3'), child: Icon(Icons.shopping_cart_rounded)),
              label: 'Корзина',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Заказы'),
          ],
        ),
      ),
    );
  }
}
