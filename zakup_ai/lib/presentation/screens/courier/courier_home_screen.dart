import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/status_chip.dart';
import 'delivery_detail_screen.dart';

class CourierHomeScreen extends StatelessWidget {
  const CourierHomeScreen({super.key});

  static const _deliveries = [
    _Delivery('ДС «Солнышко»', 'ул. Абая 112', '10:00 – 11:00', '18 позиций', OrderStatus.inDelivery, 1),
    _Delivery('ДС «Радуга»', 'ул. Ленина 45', '11:30 – 12:30', '22 позиции', OrderStatus.inDelivery, 2),
    _Delivery('ДС «Берёзка»', 'пр. Назарбаева 78', '13:00 – 14:00', '11 позиций', OrderStatus.inDelivery, 3),
    _Delivery('ДС «Ромашка»', 'ул. Гагарина 22', '14:30 – 15:30', '9 позиций', OrderStatus.inDelivery, 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.inDelivery,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFBA7517), Color(0xFF8A5510)],
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
                                Text('Привет, Бауыржан!',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.8), fontSize: 13)),
                                const SizedBox(height: 2),
                                const Text('Доставки на сегодня',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.person_rounded,
                                  color: Colors.white, size: 22),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _HeaderStat('4', 'Остановки'),
                            const SizedBox(width: 20),
                            _HeaderStat('60', 'Позиций'),
                            const SizedBox(width: 20),
                            _HeaderStat('18 км', 'Маршрут'),
                          ],
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
                  // Progress card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.inDeliveryBg,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Прогресс доставок',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.inDelivery)),
                            const Text('1 / 4',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.inDelivery)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: const LinearProgressIndicator(
                            value: 0.25,
                            backgroundColor: Colors.white,
                            color: AppColors.inDelivery,
                            minHeight: 10,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('✅ Солнышко доставлен',
                                style: TextStyle(fontSize: 12, color: AppColors.inDelivery)),
                            Text('3 осталось',
                                style: TextStyle(fontSize: 12, color: AppColors.inDelivery)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Активные доставки',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.text)),
                  const SizedBox(height: 12),
                  ..._deliveries.asMap().entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _DeliveryCard(
                          delivery: e.value,
                          stop: e.key + 1,
                          isDone: e.key == 0,
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
}

class _HeaderStat extends StatelessWidget {
  const _HeaderStat(this.value, this.label);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
        Text(label,
            style: TextStyle(
                color: Colors.white.withOpacity(0.7), fontSize: 11)),
      ],
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  const _DeliveryCard({
    required this.delivery,
    required this.stop,
    required this.isDone,
  });

  final _Delivery delivery;
  final int stop;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDone ? AppColors.deliveredBg : Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DeliveryDetailScreen(
              gardenName: delivery.name,
              address: delivery.address,
              isDone: isDone,
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDone ? AppColors.delivered.withOpacity(0.3) : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDone ? AppColors.delivered : AppColors.inDelivery,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isDone
                      ? const Icon(Icons.check_rounded, color: Colors.white, size: 20)
                      : Text('$stop',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(delivery.name,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isDone
                                      ? AppColors.delivered
                                      : AppColors.text,
                                  decoration: isDone
                                      ? TextDecoration.lineThrough
                                      : null)),
                        ),
                        if (isDone)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.deliveredBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Доставлено',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.delivered)),
                          ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 12, color: AppColors.textSub),
                        const SizedBox(width: 3),
                        Text(delivery.address,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textSub)),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.access_time_outlined,
                            size: 12, color: AppColors.textSub),
                        const SizedBox(width: 3),
                        Text(delivery.time,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textSub)),
                        const SizedBox(width: 10),
                        const Icon(Icons.inventory_2_outlined,
                            size: 12, color: AppColors.textSub),
                        const SizedBox(width: 3),
                        Text(delivery.items,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textSub)),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textSub),
            ],
          ),
        ),
      ),
    );
  }
}

class _Delivery {
  const _Delivery(this.name, this.address, this.time, this.items, this.status, this.stop);
  final String name;
  final String address;
  final String time;
  final String items;
  final OrderStatus status;
  final int stop;
}
