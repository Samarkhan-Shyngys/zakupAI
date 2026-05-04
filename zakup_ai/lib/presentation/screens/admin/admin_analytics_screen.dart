import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_colors.dart';

class AdminAnalyticsScreen extends StatefulWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  State<AdminAnalyticsScreen> createState() => _AdminAnalyticsScreenState();
}

class _AdminAnalyticsScreenState extends State<AdminAnalyticsScreen> {
  int _period = 1;

  static const _periods = ['Неделя', 'Месяц', '3 месяца'];

  static const _monthlyData = [420, 380, 510, 460, 490, 520, 480, 550, 580, 520, 610, 640];
  static const _monthLabels = ['Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн',
                                'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'];

  static const _topProducts = [
    ('🥔', 'Картофель', '842 кг', 0.88),
    ('🥛', 'Молоко 2,5%', '1 240 л', 0.82),
    ('🥕', 'Морковь', '620 кг', 0.76),
    ('🥩', 'Говядина', '310 кг', 0.70),
    ('🌾', 'Гречка', '280 кг', 0.65),
  ];

  static const _gardenStats = [
    ('ДС «Солнышко»', '₸ 214K', 0.92),
    ('ДС «Радуга»', '₸ 198K', 0.85),
    ('ДС «Берёзка»', '₸ 176K', 0.78),
    ('ДС «Ромашка»', '₸ 154K', 0.68),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Аналитика'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.download_rounded)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Period selector
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.scaffold,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: List.generate(_periods.length, (i) {
                final sel = _period == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _period = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      decoration: BoxDecoration(
                        color: sel ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      alignment: Alignment.center,
                      child: Text(_periods[i],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: sel ? Colors.white : AppColors.textSub,
                          )),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          // KPI cards
          Row(
            children: const [
              _KpiCard('₸ 2.84M', 'Сумма заказов', Icons.payments_rounded,
                  '+18%', true, AppColors.primary, AppColors.primaryLight),
              SizedBox(width: 10),
              _KpiCard('248', 'Всего заказов', Icons.receipt_long_rounded,
                  '+12%', true, AppColors.inProgress, AppColors.inProgressBg),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              _KpiCard('96%', 'Выполнено в срок', Icons.check_circle_rounded,
                  '+4%', true, AppColors.delivered, AppColors.deliveredBg),
              SizedBox(width: 10),
              _KpiCard('₸ 11,450', 'Ср. сумма заказа', Icons.trending_up_rounded,
                  '+6%', true, AppColors.inDelivery, AppColors.inDeliveryBg),
            ],
          ),
          const SizedBox(height: 20),
          // Line chart
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
                const Text('Заказы по месяцам (тыс. ₸)',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                const SizedBox(height: 6),
                const Text('2024 год',
                    style: TextStyle(fontSize: 12, color: AppColors.textSub)),
                const SizedBox(height: 20),
                SizedBox(
                  height: 180,
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: 11,
                      minY: 300,
                      maxY: 700,
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            _monthlyData.length,
                            (i) => FlSpot(i.toDouble(), _monthlyData[i].toDouble()),
                          ),
                          isCurved: true,
                          color: AppColors.primary,
                          barWidth: 2.5,
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.primary.withOpacity(0.18),
                                AppColors.primary.withOpacity(0.0),
                              ],
                            ),
                          ),
                          dotData: const FlDotData(show: false),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (v, _) => Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                _monthLabels[v.toInt() % 12],
                                style: const TextStyle(
                                    fontSize: 10, color: AppColors.textSub),
                              ),
                            ),
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 36,
                            interval: 100,
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
                        horizontalInterval: 100,
                        getDrawingHorizontalLine: (_) => const FlLine(
                            color: AppColors.divider, strokeWidth: 1),
                      ),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Top products
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
                const Text('Топ продуктов',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                const SizedBox(height: 14),
                ..._topProducts.asMap().entries.map((e) {
                  final p = e.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          child: Text('${e.key + 1}',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textSub)),
                        ),
                        Text(p.$1, style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(p.$2,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.text)),
                                  Text(p.$3,
                                      style: const TextStyle(
                                          fontSize: 12, color: AppColors.textSub)),
                                ],
                              ),
                              const SizedBox(height: 5),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: p.$4,
                                  backgroundColor: AppColors.scaffold,
                                  color: AppColors.primary,
                                  minHeight: 6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // By kindergarten
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
                const Text('По детским садам',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                const SizedBox(height: 14),
                ..._gardenStats.map((g) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryLight,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.school_rounded,
                                        color: AppColors.primary, size: 16),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(g.$1,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.text)),
                                ],
                              ),
                              Text(g.$2,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: g.$3,
                              backgroundColor: AppColors.scaffold,
                              color: AppColors.primary,
                              minHeight: 6,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard(this.value, this.label, this.icon, this.delta, this.positive,
      this.iconColor, this.iconBg);

  final String value;
  final String label;
  final IconData icon;
  final String delta;
  final bool positive;
  final Color iconColor;
  final Color iconBg;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                      positive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                      size: 11,
                      color: positive ? AppColors.delivered : AppColors.inDelivery,
                    ),
                    Text(delta,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: positive ? AppColors.delivered : AppColors.inDelivery,
                        )),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(value,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.text)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(fontSize: 11, color: AppColors.textSub)),
          ],
        ),
      ),
    );
  }
}
