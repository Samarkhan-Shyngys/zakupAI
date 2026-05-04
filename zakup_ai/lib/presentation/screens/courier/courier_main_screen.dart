import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'courier_home_screen.dart';
import 'purchase_checklist_screen.dart';
import 'route_list_screen.dart';
import 'delivery_map_screen.dart';

class CourierMainScreen extends StatefulWidget {
  const CourierMainScreen({super.key});

  @override
  State<CourierMainScreen> createState() => _CourierMainScreenState();
}

class _CourierMainScreenState extends State<CourierMainScreen> {
  int _index = 0;

  static const _pages = [
    CourierHomeScreen(),
    PurchaseChecklistScreen(),
    RouteListScreen(),
    DeliveryMapScreen(),
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
                icon: Icon(Icons.home_rounded), label: 'Главная'),
            BottomNavigationBarItem(
              icon: Badge(label: Text('5'), child: Icon(Icons.checklist_rounded)),
              label: 'Чеклист',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.route_rounded), label: 'Маршрут'),
            BottomNavigationBarItem(
                icon: Icon(Icons.map_rounded), label: 'Карта'),
          ],
        ),
      ),
    );
  }
}
