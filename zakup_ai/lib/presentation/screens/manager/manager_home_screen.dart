import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/status_chip.dart';
import 'order_detail_screen.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1A6B4A), Color(0xFF0D4A32)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Добрый день, Айгуль!',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'ДС «Солнышко»',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.notifications_outlined,
                                      color: Colors.white, size: 26),
                                ),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColors.amber,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '4 января 2025',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.65),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats row
                  Row(
                    children: [
                      _StatCard(label: 'Заказов', value: '3', icon: Icons.receipt_long_rounded),
                      const SizedBox(width: 10),
                      _StatCard(
                          label: 'В работе',
                          value: '1',
                          icon: Icons.pending_rounded,
                          color: AppColors.inProgress,
                          bg: AppColors.inProgressBg),
                      const SizedBox(width: 10),
                      _StatCard(
                          label: 'Доставлено',
                          value: '2',
                          icon: Icons.check_circle_rounded,
                          color: AppColors.delivered,
                          bg: AppColors.deliveredBg),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Monthly budget
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.account_balance_wallet_rounded,
                              color: AppColors.primary, size: 22),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Бюджет на январь',
                                  style: TextStyle(
                                      fontSize: 13, color: AppColors.textSub)),
                              const SizedBox(height: 2),
                              const Text('₸ 320,000',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Использовано',
                                style: TextStyle(fontSize: 11, color: AppColors.textSub)),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: 0.42,
                                backgroundColor: AppColors.primary.withOpacity(0.15),
                                color: AppColors.primary,
                                minHeight: 6,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text('42%',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Активные заказы',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.text)),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Все заказы',
                            style: TextStyle(fontSize: 13, color: AppColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ..._orders.map((o) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _OrderCard(
                          id: o['id'] as String,
                          items: o['items'] as String,
                          amount: o['amount'] as String,
                          date: o['date'] as String,
                          status: o['status'] as OrderStatus,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static final _orders = [
    {
      'id': 'ZK-2025-003',
      'items': '18 позиций',
      'amount': '₸ 52,400',
      'date': '04 янв 2025',
      'status': OrderStatus.inProgress,
    },
    {
      'id': 'ZK-2025-002',
      'items': '12 позиций',
      'amount': '₸ 38,100',
      'date': '02 янв 2025',
      'status': OrderStatus.inDelivery,
    },
    {
      'id': 'ZK-2025-001',
      'items': '9 позиций',
      'amount': '₸ 27,500',
      'date': '30 дек 2024',
      'status': OrderStatus.delivered,
    },
  ];
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    this.color = AppColors.primary,
    this.bg = AppColors.primaryLight,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 10),
            Text(value,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.text)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(fontSize: 11, color: AppColors.textSub)),
          ],
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.id,
    required this.items,
    required this.amount,
    required this.date,
    required this.status,
  });

  final String id;
  final String items;
  final String amount;
  final String date;
  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => OrderDetailScreen(orderId: id, status: status)),
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
                  Text(
                    'Заказ #$id',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text),
                  ),
                  StatusChip(status: status),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _InfoChip(icon: Icons.inventory_2_outlined, label: items),
                  const SizedBox(width: 12),
                  _InfoChip(icon: Icons.payments_outlined, label: amount),
                  const Spacer(),
                  Text(date,
                      style: const TextStyle(fontSize: 12, color: AppColors.textSub)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textSub),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSub)),
      ],
    );
  }
}
