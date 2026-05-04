import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/status_chip.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Дашборд'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.person_rounded,
                      color: AppColors.primary, size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Date & greeting
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A6B4A), Color(0xFF0D4A32)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Добрый день, Азамат!',
                          style: TextStyle(color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 4),
                      const Text('Сводка за сегодня',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text('4 января 2025',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6), fontSize: 13)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text('Активных ДС',
                          style: TextStyle(color: Colors.white70, fontSize: 11)),
                      const SizedBox(height: 2),
                      const Text('8',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 4 stat cards
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.55,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _StatCard(
                icon: Icons.receipt_long_rounded,
                iconColor: AppColors.primary,
                iconBg: AppColors.primaryLight,
                label: 'Заказов сегодня',
                value: '24',
                delta: '+3 от вчера',
                deltaPositive: true,
              ),
              _StatCard(
                icon: Icons.payments_rounded,
                iconColor: Color(0xFF185FA5),
                iconBg: Color(0xFFDCEAF9),
                label: 'Сумма заказов',
                value: '₸ 842K',
                delta: '+12% к пред.',
                deltaPositive: true,
              ),
              _StatCard(
                icon: Icons.pending_rounded,
                iconColor: AppColors.inDelivery,
                iconBg: AppColors.inDeliveryBg,
                label: 'Ожидают подтв.',
                value: '7',
                delta: '2 просрочено',
                deltaPositive: false,
              ),
              _StatCard(
                icon: Icons.check_circle_rounded,
                iconColor: AppColors.delivered,
                iconBg: AppColors.deliveredBg,
                label: 'Доставлено',
                value: '15',
                delta: '63% выполнено',
                deltaPositive: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Bar chart
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Заказы за неделю',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.scaffold,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Дек — Янв',
                          style: TextStyle(fontSize: 12, color: AppColors.textSub)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 160,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 32,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipColor: (_) => AppColors.text,
                          getTooltipItem: (group, _, rod, __) => BarTooltipItem(
                            '${rod.toY.toInt()}',
                            const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (v, _) {
                              const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(days[v.toInt()],
                                    style: const TextStyle(
                                        fontSize: 11, color: AppColors.textSub)),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            getTitlesWidget: (v, _) => Text(
                              '${v.toInt()}',
                              style: const TextStyle(
                                  fontSize: 10, color: AppColors.textSub),
                            ),
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 8,
                        getDrawingHorizontalLine: (_) => const FlLine(
                          color: AppColors.divider,
                          strokeWidth: 1,
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: [
                        _bar(0, 18),
                        _bar(1, 24),
                        _bar(2, 20),
                        _bar(3, 28),
                        _bar(4, 22),
                        _bar(5, 14),
                        _bar(6, 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Recent orders mini
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Последние заказы',
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
          ..._recentOrders.map((o) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.school_rounded,
                            color: AppColors.primary, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(o.$1,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.text)),
                            Text(o.$2,
                                style: const TextStyle(
                                    fontSize: 12, color: AppColors.textSub)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          StatusChip(status: o.$4, small: true),
                          const SizedBox(height: 4),
                          Text(o.$3,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.text)),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  BarChartGroupData _bar(int x, double y) => BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            toY: y,
            color: AppColors.primary,
            width: 22,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 32,
              color: AppColors.scaffold,
            ),
          ),
        ],
      );

  static const _recentOrders = [
    ('ДС «Солнышко»', '18 позиций • ₸ 52,400', '04 янв', OrderStatus.inProgress),
    ('ДС «Радуга»', '22 позиции • ₸ 68,200', '04 янв', OrderStatus.inDelivery),
    ('ДС «Берёзка»', '11 позиций • ₸ 31,800', '03 янв', OrderStatus.delivered),
  ];
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
    required this.delta,
    required this.deltaPositive,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;
  final String delta;
  final bool deltaPositive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration:
                    BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              Row(
                children: [
                  Icon(
                    deltaPositive ? Icons.trending_up_rounded : Icons.warning_rounded,
                    size: 12,
                    color: deltaPositive ? AppColors.delivered : AppColors.inDelivery,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    delta,
                    style: TextStyle(
                      fontSize: 10,
                      color: deltaPositive ? AppColors.delivered : AppColors.inDelivery,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.text)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppColors.textSub)),
        ],
      ),
    );
  }
}
