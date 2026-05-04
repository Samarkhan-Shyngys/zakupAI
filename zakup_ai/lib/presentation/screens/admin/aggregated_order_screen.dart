import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class AggregatedOrderScreen extends StatefulWidget {
  const AggregatedOrderScreen({super.key});

  @override
  State<AggregatedOrderScreen> createState() => _AggregatedOrderScreenState();
}

class _AggregatedOrderScreenState extends State<AggregatedOrderScreen> {
  final Set<int> _expanded = {0};

  static const _gardens = [
    'ДС «Солнышко»',
    'ДС «Радуга»',
    'ДС «Берёзка»',
    'ДС «Ромашка»',
    'ДС «Звёздочка»',
    'ДС «Арман»',
  ];

  static const _categories = [
    _Category(
      '🥦 Овощи и зелень',
      AppColors.deliveredBg,
      AppColors.delivered,
      [
        _AggItem('🥕', 'Морковь', 'кг', [10, 12, 8, 15, 10, 0], 180),
        _AggItem('🥔', 'Картофель', 'кг', [20, 25, 18, 22, 20, 15], 150),
        _AggItem('🧅', 'Лук репчатый', 'кг', [15, 10, 12, 18, 15, 10], 120),
        _AggItem('🥦', 'Капуста', 'кг', [8, 10, 6, 12, 8, 0], 140),
      ],
    ),
    _Category(
      '🍎 Фрукты',
      AppColors.inDeliveryBg,
      AppColors.inDelivery,
      [
        _AggItem('🍎', 'Яблоко', 'кг', [8, 10, 7, 12, 8, 6], 320),
        _AggItem('🍊', 'Мандарин', 'кг', [5, 8, 5, 8, 6, 4], 420),
        _AggItem('🍌', 'Банан', 'кг', [6, 8, 5, 10, 7, 5], 380),
      ],
    ),
    _Category(
      '🥛 Молочные продукты',
      AppColors.inProgressBg,
      AppColors.inProgress,
      [
        _AggItem('🥛', 'Молоко 2,5%', 'л', [30, 40, 28, 35, 30, 25], 280),
        _AggItem('🧈', 'Масло сливочное', 'кг', [2, 3, 2, 3, 2, 2], 1800),
        _AggItem('🧀', 'Сыр твёрдый', 'кг', [3, 4, 3, 4, 3, 2], 2200),
      ],
    ),
    _Category(
      '🌾 Крупы',
      AppColors.primaryLight,
      AppColors.primary,
      [
        _AggItem('🌾', 'Гречка', 'кг', [5, 6, 4, 6, 5, 4], 340),
        _AggItem('🌾', 'Рис', 'кг', [5, 6, 5, 7, 5, 4], 280),
        _AggItem('🌾', 'Овсянка', 'кг', [4, 5, 3, 5, 4, 3], 220),
      ],
    ),
    _Category(
      '🥩 Мясо и птица',
      Color(0xFFFDE8E8),
      Color(0xFFB91C1C),
      [
        _AggItem('🥩', 'Говядина', 'кг', [6, 8, 5, 8, 6, 5], 2800),
        _AggItem('🍗', 'Куриное филе', 'кг', [8, 10, 7, 10, 8, 7], 1600),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final totalAmount = _categories.expand((c) => c.items).fold(
      0,
      (sum, item) {
        final totalQty = item.qtys.fold(0, (a, b) => a + b);
        return sum + totalQty * item.price;
      },
    );

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Сводный заказ'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.download_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
        ],
      ),
      body: Column(
        children: [
          // Header summary
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A6B4A), Color(0xFF0D4A32)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.merge_rounded, color: Colors.white70, size: 18),
                    const SizedBox(width: 8),
                    const Text('Объединённый заказ • 4 января 2025',
                        style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SummChip('${_gardens.length} ДС', Icons.school_rounded),
                    _SummChip('${_categories.expand((c) => c.items).length} позиций',
                        Icons.inventory_2_rounded),
                    _SummChip('₸ ${_fmtK(totalAmount)}', Icons.payments_rounded),
                  ],
                ),
              ],
            ),
          ),
          // Kindergartens row
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              itemCount: _gardens.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  alignment: Alignment.center,
                  child: Text(_gardens[i],
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _categories.length,
              itemBuilder: (_, i) {
                final cat = _categories[i];
                final isExpanded = _expanded.contains(i);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          borderRadius: isExpanded
                              ? const BorderRadius.vertical(top: Radius.circular(14))
                              : BorderRadius.circular(14),
                          onTap: () => setState(() {
                            if (isExpanded) {
                              _expanded.remove(i);
                            } else {
                              _expanded.add(i);
                            }
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: cat.bg,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(cat.title.split(' ').first,
                                        style: const TextStyle(fontSize: 18)),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cat.title.substring(
                                            cat.title.indexOf(' ') + 1),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.text),
                                      ),
                                      Text('${cat.items.length} позиций',
                                          style: const TextStyle(
                                              fontSize: 12, color: AppColors.textSub)),
                                    ],
                                  ),
                                ),
                                Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up_rounded
                                      : Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.textSub,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isExpanded) ...[
                          const Divider(height: 1),
                          // Header row
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14, 8, 14, 4),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 3,
                                  child: Text('Продукт',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textSub)),
                                ),
                                const SizedBox(
                                  width: 60,
                                  child: Text('Итого',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textSub)),
                                ),
                                const SizedBox(
                                  width: 70,
                                  child: Text('Сумма',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textSub)),
                                ),
                              ],
                            ),
                          ),
                          ...cat.items.map((item) {
                            final total = item.qtys.fold(0, (a, b) => a + b);
                            final amount = total * item.price;
                            return Column(
                              children: [
                                const Divider(height: 1),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          children: [
                                            Text(item.emoji,
                                                style: const TextStyle(fontSize: 16)),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(item.name,
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: AppColors.text)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: cat.bg,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text('$total ${item.unit}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: cat.color)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                        child: Text(
                                          '₸ ${_fmt(amount)}',
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.text),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send_rounded, size: 18),
          label: const Text('Отправить поставщику'),
        ),
      ),
    );
  }

  String _fmt(int v) {
    final s = v.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  String _fmtK(int v) => v >= 1000 ? '${(v / 1000).toStringAsFixed(0)}K' : '$v';
}

class _SummChip extends StatelessWidget {
  const _SummChip(this.label, this.icon);
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 14),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _Category {
  const _Category(this.title, this.bg, this.color, this.items);
  final String title;
  final Color bg;
  final Color color;
  final List<_AggItem> items;
}

class _AggItem {
  const _AggItem(this.emoji, this.name, this.unit, this.qtys, this.price);
  final String emoji;
  final String name;
  final String unit;
  final List<int> qtys;
  final int price;
}
