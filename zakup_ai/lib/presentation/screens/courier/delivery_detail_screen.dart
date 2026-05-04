import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class DeliveryDetailScreen extends StatefulWidget {
  const DeliveryDetailScreen({
    super.key,
    required this.gardenName,
    required this.address,
    this.isDone = false,
  });

  final String gardenName;
  final String address;
  final bool isDone;

  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  bool _delivered = false;
  bool _isConfirming = false;

  static const _items = [
    ('🥕', 'Морковь', '10 кг'),
    ('🥔', 'Картофель', '20 кг'),
    ('🧅', 'Лук репчатый', '15 кг'),
    ('🥦', 'Капуста', '8 кг'),
    ('🍎', 'Яблоко', '8 кг'),
    ('🥛', 'Молоко 2,5%', '30 л'),
    ('🌾', 'Гречка', '5 кг'),
    ('🥩', 'Говядина', '6 кг'),
  ];

  @override
  void initState() {
    super.initState();
    _delivered = widget.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(title: Text(widget.gardenName)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Garden info card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _delivered
                    ? [const Color(0xFF3B6D11), const Color(0xFF245009)]
                    : [AppColors.inDelivery, const Color(0xFF8A5510)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.school_rounded,
                          color: Colors.white, size: 26),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.gardenName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on_rounded,
                                  color: Colors.white70, size: 14),
                              const SizedBox(width: 4),
                              Text(widget.address,
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (_delivered)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.check_circle_rounded,
                            color: Colors.white, size: 24),
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _InfoBadge(
                        Icons.access_time_outlined, '10:00 – 11:00'),
                    const SizedBox(width: 10),
                    _InfoBadge(Icons.inventory_2_outlined,
                        '${_items.length} позиций'),
                    const SizedBox(width: 10),
                    _InfoBadge(Icons.payments_outlined, '₸ 36,060'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Contact card
          Container(
            padding: const EdgeInsets.all(14),
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
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.person_rounded,
                      color: AppColors.primary, size: 22),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Контактное лицо',
                          style: TextStyle(fontSize: 11, color: AppColors.textSub)),
                      Text('Айгуль Сейткали',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    _ActionBtn(Icons.phone_rounded, () {}),
                    const SizedBox(width: 8),
                    _ActionBtn(Icons.message_rounded, () {}),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Items list
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
                    const Text('Список товаров',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text)),
                    Text('${_items.length} позиций',
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.textSub)),
                  ],
                ),
                const SizedBox(height: 12),
                ...List.generate(_items.length, (i) {
                  final item = _items[i];
                  return Column(
                    children: [
                      if (i > 0) const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Text(item.$1, style: const TextStyle(fontSize: 22)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(item.$2,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.text)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: _delivered
                                    ? AppColors.deliveredBg
                                    : AppColors.scaffold,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(item.$3,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: _delivered
                                          ? AppColors.delivered
                                          : AppColors.text)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Notes card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.note_outlined, size: 16, color: AppColors.textSub),
                    SizedBox(width: 6),
                    Text('Примечание',
                        style: TextStyle(fontSize: 13, color: AppColors.textSub)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Привезти до 11:00. Позвонить завхозу при прибытии.',
                  style: TextStyle(fontSize: 13, color: AppColors.text, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: _delivered
          ? Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.deliveredBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_rounded,
                        color: AppColors.delivered, size: 20),
                    SizedBox(width: 8),
                    Text('Доставка подтверждена',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.delivered,
                            fontSize: 15)),
                  ],
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.navigation_rounded, size: 18),
                    label: const Text('Открыть навигацию'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      foregroundColor: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FilledButton.icon(
                    onPressed: _isConfirming ? null : _confirmDelivery,
                    icon: _isConfirming
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : const Icon(Icons.check_circle_outlined, size: 18),
                    label: const Text('Подтвердить доставку'),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _confirmDelivery() async {
    setState(() => _isConfirming = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _isConfirming = false;
      _delivered = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.gardenName} — доставка подтверждена!'),
        backgroundColor: AppColors.delivered,
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  const _InfoBadge(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 13),
          const SizedBox(width: 5),
          Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn(this.icon, this.onTap);
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 18),
      ),
    );
  }
}
