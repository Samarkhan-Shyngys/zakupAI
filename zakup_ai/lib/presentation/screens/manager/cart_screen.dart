import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<_CartItem> _items = [
    _CartItem('🥕', 'Морковь', 'кг', 180, 10),
    _CartItem('🥔', 'Картофель', 'кг', 150, 20),
    _CartItem('🧅', 'Лук репчатый', 'кг', 120, 15),
    _CartItem('🍎', 'Яблоко', 'кг', 320, 8),
    _CartItem('🥛', 'Молоко 2,5%', 'л', 280, 30),
    _CartItem('🌾', 'Гречка', 'кг', 340, 5),
    _CartItem('🥩', 'Говядина', 'кг', 2800, 6),
  ];

  bool _isOrdering = false;

  int get _totalItems => _items.fold(0, (s, i) => s + i.qty);
  int get _totalAmount => _items.fold(0, (s, i) => s + i.qty * i.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Корзина'),
        actions: [
          TextButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Очистить корзину?'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Отмена')),
                  TextButton(
                    onPressed: () {
                      setState(() => _items.forEach((i) => i.qty = 0));
                      Navigator.pop(context);
                    },
                    child: const Text('Очистить',
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
            child: const Text('Очистить',
                style: TextStyle(color: Colors.red, fontSize: 14)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Delivery info banner
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_shipping_outlined,
                    color: AppColors.primary, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Адрес доставки',
                          style: TextStyle(
                              fontSize: 11, color: AppColors.textSub)),
                      const Text('ул. Абая 112, ДС «Солнышко»',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                  ),
                  child: const Text('Изменить',
                      style: TextStyle(fontSize: 12, color: AppColors.primary)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Items
          Expanded(
            child: _items.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shopping_cart_outlined,
                            size: 56, color: AppColors.border),
                        SizedBox(height: 12),
                        Text('Корзина пуста',
                            style: TextStyle(
                                fontSize: 16, color: AppColors.textSub)),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, i) => _CartItemTile(
                      item: _items[i],
                      onQtyChange: (v) => setState(() => _items[i].qty = v),
                      onRemove: () => setState(() => _items.removeAt(i)),
                    ),
                  ),
          ),
          // Summary + Order button
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: Column(
              children: [
                _SummaryRow('Позиций', '$_totalItems шт.'),
                const SizedBox(height: 8),
                _SummaryRow('Стоимость', '₸ ${_format(_totalAmount)}'),
                const SizedBox(height: 8),
                _SummaryRow('Доставка', 'Бесплатно', valueColor: AppColors.delivered),
                const Divider(height: 20),
                _SummaryRow(
                  'Итого',
                  '₸ ${_format(_totalAmount)}',
                  bold: true,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _isOrdering ? null : _placeOrder,
                  child: _isOrdering
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5),
                        )
                      : const Text('Оформить заказ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _placeOrder() async {
    setState(() => _isOrdering = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isOrdering = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Заказ ZK-2025-004 успешно оформлен!'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  String _format(int v) {
    final s = v.toString();
    if (s.length <= 3) return s;
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({
    required this.item,
    required this.onQtyChange,
    required this.onRemove,
  });

  final _CartItem item;
  final ValueChanged<int> onQtyChange;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.scaffold,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text(item.emoji, style: const TextStyle(fontSize: 22))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.text)),
                Text('₸ ${item.price} / ${item.unit}',
                    style: const TextStyle(fontSize: 12, color: AppColors.textSub)),
              ],
            ),
          ),
          Row(
            children: [
              _Stepper(
                icon: Icons.remove,
                onTap: () => onQtyChange(item.qty - 1 < 1 ? 1 : item.qty - 1),
              ),
              SizedBox(
                width: 36,
                child: Text(
                  '${item.qty}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
              _Stepper(
                icon: Icons.add,
                filled: true,
                onTap: () => onQtyChange(item.qty + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({required this.icon, required this.onTap, this.filled = false});
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : AppColors.scaffold,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: filled ? Colors.white : AppColors.text),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow(this.label, this.value, {this.bold = false, this.valueColor});
  final String label;
  final String value;
  final bool bold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontSize: bold ? 15 : 14,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
              color: bold ? AppColors.text : AppColors.textSub,
            )),
        Text(value,
            style: TextStyle(
              fontSize: bold ? 17 : 14,
              fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
              color: valueColor ?? (bold ? AppColors.primary : AppColors.text),
            )),
      ],
    );
  }
}

class _CartItem {
  _CartItem(this.emoji, this.name, this.unit, this.price, this.qty);
  final String emoji;
  final String name;
  final String unit;
  final int price;
  int qty;
}
