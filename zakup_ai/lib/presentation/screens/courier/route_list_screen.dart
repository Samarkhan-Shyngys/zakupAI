import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'delivery_detail_screen.dart';

class RouteListScreen extends StatelessWidget {
  const RouteListScreen({super.key});

  static const _stops = [
    _Stop(1, 'ДС «Солнышко»', 'ул. Абая 112', '10:00', '11:00', true, '18 поз.', '₸ 52,400'),
    _Stop(2, 'ДС «Радуга»', 'ул. Ленина 45', '11:30', '12:30', false, '22 поз.', '₸ 68,200'),
    _Stop(3, 'ДС «Берёзка»', 'пр. Назарбаева 78', '13:00', '14:00', false, '11 поз.', '₸ 31,800'),
    _Stop(4, 'ДС «Ромашка»', 'ул. Гагарина 22', '14:30', '15:30', false, '9 поз.', '₸ 27,500'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Маршрут'),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.navigation_rounded, size: 16, color: AppColors.primary),
            label: const Text('Навигация',
                style: TextStyle(color: AppColors.primary, fontSize: 13)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Route summary
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                _RouteStat(Icons.store_rounded, '4', 'Остановки', AppColors.primary, AppColors.primaryLight),
                const _Divider(),
                _RouteStat(Icons.route_rounded, '18 км', 'Маршрут', AppColors.inProgress, AppColors.inProgressBg),
                const _Divider(),
                _RouteStat(Icons.access_time_rounded, '5.5 ч', 'Время', AppColors.inDelivery, AppColors.inDeliveryBg),
                const _Divider(),
                _RouteStat(Icons.check_circle_rounded, '1/4', 'Выполнено', AppColors.delivered, AppColors.deliveredBg),
              ],
            ),
          ),
          // Timeline
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              itemCount: _stops.length,
              itemBuilder: (_, i) {
                final stop = _stops[i];
                final isLast = i == _stops.length - 1;
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Timeline indicator
                      SizedBox(
                        width: 48,
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: stop.done
                                    ? AppColors.delivered
                                    : stop.number == 2
                                        ? AppColors.inDelivery
                                        : AppColors.scaffold,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: stop.done
                                      ? AppColors.delivered
                                      : stop.number == 2
                                          ? AppColors.inDelivery
                                          : AppColors.border,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: stop.done
                                    ? const Icon(Icons.check_rounded,
                                        color: Colors.white, size: 18)
                                    : Text('${stop.number}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color: stop.number == 2
                                              ? Colors.white
                                              : AppColors.textSub,
                                        )),
                              ),
                            ),
                            if (!isLast)
                              Expanded(
                                child: Container(
                                  width: 2,
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  color: stop.done
                                      ? AppColors.delivered
                                      : AppColors.border,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Stop card
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
                          child: Material(
                            color: stop.done
                                ? AppColors.deliveredBg
                                : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DeliveryDetailScreen(
                                    gardenName: stop.name,
                                    address: stop.address,
                                    isDone: stop.done,
                                  ),
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: stop.done
                                        ? AppColors.delivered.withOpacity(0.3)
                                        : stop.number == 2
                                            ? AppColors.inDelivery.withOpacity(0.4)
                                            : AppColors.border,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(stop.name,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: stop.done
                                                    ? AppColors.delivered
                                                    : AppColors.text,
                                                decoration: stop.done
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                              )),
                                        ),
                                        if (stop.number == 2 && !stop.done)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: AppColors.inDeliveryBg,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Text('Текущий',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.inDelivery)),
                                          ),
                                        if (stop.done)
                                          const Icon(Icons.check_circle_rounded,
                                              color: AppColors.delivered, size: 18),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined,
                                            size: 13, color: AppColors.textSub),
                                        const SizedBox(width: 3),
                                        Text(stop.address,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: AppColors.textSub)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        _Tag(Icons.access_time_outlined,
                                            '${stop.arrival} – ${stop.departure}'),
                                        const SizedBox(width: 8),
                                        _Tag(Icons.inventory_2_outlined, stop.items),
                                        const SizedBox(width: 8),
                                        _Tag(Icons.payments_outlined, stop.amount),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteStat extends StatelessWidget {
  const _RouteStat(this.icon, this.value, this.label, this.color, this.bg);
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(9)),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.text)),
          Text(label,
              style: const TextStyle(fontSize: 10, color: AppColors.textSub)),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 50, color: AppColors.border);
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: AppColors.textSub),
        const SizedBox(width: 3),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSub)),
      ],
    );
  }
}

class _Stop {
  const _Stop(this.number, this.name, this.address, this.arrival, this.departure,
      this.done, this.items, this.amount);
  final int number;
  final String name;
  final String address;
  final String arrival;
  final String departure;
  final bool done;
  final String items;
  final String amount;
}
