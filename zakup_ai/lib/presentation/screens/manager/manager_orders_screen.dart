import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/status_chip.dart';
import 'order_detail_screen.dart';

class ManagerOrdersScreen extends StatefulWidget {
  const ManagerOrdersScreen({super.key});

  @override
  State<ManagerOrdersScreen> createState() => _ManagerOrdersScreenState();
}

class _ManagerOrdersScreenState extends State<ManagerOrdersScreen> {
  int _filter = 0;

  static const _filters = ['Все', 'Черновик', 'В работе', 'В доставке', 'Доставлен'];

  static const _orders = [
    ('ZK-2025-003', '18 позиций', '₸ 52,400', '04 янв', OrderStatus.inProgress),
    ('ZK-2025-002', '12 позиций', '₸ 38,100', '02 янв', OrderStatus.inDelivery),
    ('ZK-2025-001', '9 позиций', '₸ 27,500', '30 дек', OrderStatus.delivered),
    ('ZK-2024-047', '22 позиции', '₸ 61,200', '28 дек', OrderStatus.delivered),
    ('ZK-2024-046', '5 позиций', '₸ 14,800', '25 дек', OrderStatus.draft),
  ];

  List<(String, String, String, String, OrderStatus)> get _filtered {
    if (_filter == 0) return _orders;
    final status = OrderStatus.values[_filter - 1];
    return _orders.where((o) => o.$5 == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Мои заказы'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              itemCount: _filters.length,
              itemBuilder: (_, i) {
                final sel = _filter == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _filter = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: sel ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: sel ? AppColors.primary : AppColors.border),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _filters[i],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: sel ? Colors.white : AppColors.text,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final o = _filtered[i];
                return Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderDetailScreen(orderId: o.$1, status: o.$5),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Заказ #${o.$1}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.text)),
                              StatusChip(status: o.$5),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.inventory_2_outlined,
                                  size: 14, color: AppColors.textSub),
                              const SizedBox(width: 4),
                              Text(o.$2,
                                  style: const TextStyle(
                                      fontSize: 13, color: AppColors.textSub)),
                              const SizedBox(width: 16),
                              const Icon(Icons.payments_outlined,
                                  size: 14, color: AppColors.textSub),
                              const SizedBox(width: 4),
                              Text(o.$3,
                                  style: const TextStyle(
                                      fontSize: 13, color: AppColors.textSub)),
                              const Spacer(),
                              Text(o.$4,
                                  style: const TextStyle(
                                      fontSize: 12, color: AppColors.textSub)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Новый заказ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
