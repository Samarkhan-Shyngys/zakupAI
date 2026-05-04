import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PurchaseChecklistScreen extends StatefulWidget {
  const PurchaseChecklistScreen({super.key});

  @override
  State<PurchaseChecklistScreen> createState() => _PurchaseChecklistScreenState();
}

class _PurchaseChecklistScreenState extends State<PurchaseChecklistScreen> {
  final List<_CheckItem> _items = [
    _CheckItem('🥕', 'Морковь', '53 кг', '🥦 Овощи'),
    _CheckItem('🥔', 'Картофель', '120 кг', '🥦 Овощи'),
    _CheckItem('🧅', 'Лук репчатый', '80 кг', '🥦 Овощи'),
    _CheckItem('🥦', 'Капуста', '44 кг', '🥦 Овощи'),
    _CheckItem('🍎', 'Яблоко', '51 кг', '🍎 Фрукты'),
    _CheckItem('🍊', 'Мандарин', '36 кг', '🍎 Фрукты'),
    _CheckItem('🍌', 'Банан', '41 кг', '🍎 Фрукты'),
    _CheckItem('🥛', 'Молоко 2,5%', '188 л', '🥛 Молочные'),
    _CheckItem('🧈', 'Масло сливочное', '14 кг', '🥛 Молочные'),
    _CheckItem('🌾', 'Гречка', '30 кг', '🌾 Крупы'),
    _CheckItem('🌾', 'Рис', '32 кг', '🌾 Крупы'),
    _CheckItem('🥩', 'Говядина', '38 кг', '🥩 Мясо'),
    _CheckItem('🍗', 'Куриное филе', '50 кг', '🥩 Мясо'),
  ];

  int get _checkedCount => _items.where((i) => i.checked).length;
  double get _progress => _checkedCount / _items.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Чеклист закупки'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text('$_checkedCount / ${_items.length}',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _checkedCount == _items.length
                          ? '✅ Все позиции закуплены!'
                          : 'Отмечено $_checkedCount из ${_items.length} позиций',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _checkedCount == _items.length
                            ? AppColors.delivered
                            : AppColors.text,
                      ),
                    ),
                    Text('${(_progress * 100).toInt()}%',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary)),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: AppColors.scaffold,
                    color: _checkedCount == _items.length
                        ? AppColors.delivered
                        : AppColors.primary,
                    minHeight: 10,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Filter row
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                _FilterBtn('Все', true),
                const SizedBox(width: 8),
                _FilterBtn('Не куплено', false),
                const SizedBox(width: 8),
                _FilterBtn('Куплено', false),
              ],
            ),
          ),
          const Divider(height: 1),
          // List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _items.length,
              itemBuilder: (_, i) {
                final item = _items[i];
                final showHeader =
                    i == 0 || _items[i - 1].category != item.category;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showHeader) ...[
                      if (i > 0) const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(item.category,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textSub)),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: item.checked
                            ? AppColors.deliveredBg
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () =>
                              setState(() => item.checked = !item.checked),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: item.checked
                                    ? AppColors.delivered.withOpacity(0.3)
                                    : AppColors.border,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: item.checked
                                        ? AppColors.delivered
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: item.checked
                                          ? AppColors.delivered
                                          : AppColors.border,
                                      width: 2,
                                    ),
                                  ),
                                  child: item.checked
                                      ? const Icon(Icons.check_rounded,
                                          color: Colors.white, size: 14)
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                Text(item.emoji,
                                    style: const TextStyle(fontSize: 20)),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: item.checked
                                          ? AppColors.textSub
                                          : AppColors.text,
                                      decoration: item.checked
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: item.checked
                                        ? AppColors.deliveredBg
                                        : AppColors.scaffold,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    item.qty,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: item.checked
                                          ? AppColors.delivered
                                          : AppColors.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
        child: FilledButton(
          onPressed: _checkedCount == _items.length ? () {} : null,
          style: FilledButton.styleFrom(
            backgroundColor: _checkedCount == _items.length
                ? AppColors.delivered
                : AppColors.textSub,
          ),
          child: Text(
            _checkedCount == _items.length
                ? 'Закупка завершена — начать доставку'
                : 'Отметьте все позиции ($_checkedCount / ${_items.length})',
          ),
        ),
      ),
    );
  }
}

class _FilterBtn extends StatelessWidget {
  const _FilterBtn(this.label, this.selected);
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.scaffold,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: selected ? Colors.white : AppColors.textSub,
        ),
      ),
    );
  }
}

class _CheckItem {
  _CheckItem(this.emoji, this.name, this.qty, this.category);
  final String emoji;
  final String name;
  final String qty;
  final String category;
  bool checked = false;
}
