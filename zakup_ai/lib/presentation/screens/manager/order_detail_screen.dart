import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/status_chip.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId, required this.status});

  final String orderId;
  final OrderStatus status;

  static const _items = [
    ('🥕', 'Морковь', '10 кг', '₸ 1,800'),
    ('🥔', 'Картофель', '20 кг', '₸ 3,000'),
    ('🧅', 'Лук репчатый', '15 кг', '₸ 1,800'),
    ('🍎', 'Яблоко', '8 кг', '₸ 2,560'),
    ('🥛', 'Молоко 2,5%', '30 л', '₸ 8,400'),
    ('🌾', 'Гречка', '5 кг', '₸ 1,700'),
    ('🥩', 'Говядина', '6 кг', '₸ 16,800'),
  ];

  @override
  Widget build(BuildContext context) {
    final statusIndex = status.index;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        title: Text('Заказ #$orderId'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Status card
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Статус заказа',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                    StatusChip(status: status),
                  ],
                ),
                const SizedBox(height: 20),
                _StatusTimeline(currentStep: statusIndex),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Delivery info
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Информация о доставке',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                const SizedBox(height: 14),
                _InfoRow(icon: Icons.location_on_outlined,
                    label: 'Адрес', value: 'ул. Абая 112, ДС «Солнышко»'),
                const SizedBox(height: 10),
                _InfoRow(icon: Icons.calendar_today_outlined,
                    label: 'Дата доставки', value: '06 января 2025'),
                const SizedBox(height: 10),
                _InfoRow(icon: Icons.access_time_outlined,
                    label: 'Время', value: '09:00 – 12:00'),
                const SizedBox(height: 10),
                _InfoRow(icon: Icons.person_outlined,
                    label: 'Менеджер', value: 'Айгуль Сейткали'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Items
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Состав заказа',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.text)),
                    Text('${_items.length} позиций',
                        style:
                            const TextStyle(fontSize: 13, color: AppColors.textSub)),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.$2,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.text)),
                                  Text(item.$3,
                                      style: const TextStyle(
                                          fontSize: 12, color: AppColors.textSub)),
                                ],
                              ),
                            ),
                            Text(item.$4,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.text)),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Total
          _Card(
            child: Column(
              children: [
                _TotalRow('Подытог', '₸ 36,060'),
                const SizedBox(height: 8),
                _TotalRow('НДС 12%', '₸ 4,327'),
                const SizedBox(height: 8),
                _TotalRow('Доставка', 'Бесплатно', valueColor: AppColors.delivered),
                const Divider(height: 20),
                _TotalRow('Итого', '₸ 40,387', bold: true),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (status == OrderStatus.draft)
            FilledButton(
              onPressed: () {},
              child: const Text('Отправить на подтверждение'),
            ),
          if (status == OrderStatus.delivered)
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Повторить заказ'),
            ),
        ],
      ),
    );
  }
}

class _StatusTimeline extends StatelessWidget {
  const _StatusTimeline({required this.currentStep});
  final int currentStep;

  static const _steps = [
    ('Черновик', Icons.edit_note_rounded),
    ('В работе', Icons.pending_rounded),
    ('В доставке', Icons.local_shipping_rounded),
    ('Доставлен', Icons.check_circle_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          final done = (i ~/ 2) < currentStep;
          return Expanded(
            child: Container(
              height: 2,
              color: done ? AppColors.primary : AppColors.border,
            ),
          );
        }
        final step = i ~/ 2;
        final done = step < currentStep;
        final current = step == currentStep;
        return Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: done
                    ? AppColors.primary
                    : current
                        ? AppColors.primaryLight
                        : AppColors.scaffold,
                shape: BoxShape.circle,
                border: Border.all(
                  color: done || current ? AppColors.primary : AppColors.border,
                  width: current ? 2 : 1,
                ),
              ),
              child: Icon(
                _steps[step].$2,
                size: 16,
                color: done
                    ? Colors.white
                    : current
                        ? AppColors.primary
                        : AppColors.textSub,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _steps[step].$1,
              style: TextStyle(
                fontSize: 10,
                fontWeight: current || done ? FontWeight.w600 : FontWeight.w400,
                color: done || current ? AppColors.primary : AppColors.textSub,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSub),
        const SizedBox(width: 10),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 13, color: AppColors.textSub)),
              Flexible(
                child: Text(value,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow(this.label, this.value, {this.bold = false, this.valueColor});
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
              fontSize: bold ? 15 : 13,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
              color: bold ? AppColors.text : AppColors.textSub,
            )),
        Text(value,
            style: TextStyle(
              fontSize: bold ? 18 : 13,
              fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
              color: valueColor ?? (bold ? AppColors.primary : AppColors.text),
            )),
      ],
    );
  }
}
