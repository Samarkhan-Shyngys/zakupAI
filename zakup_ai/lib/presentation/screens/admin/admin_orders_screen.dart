import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/status_chip.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  int _filter = 0;
  String _search = '';
  final _searchCtrl = TextEditingController();

  static const _filterLabels = ['Все', 'Черновик', 'В работе', 'В доставке', 'Доставлен'];

  static const _orders = [
    _Order('ZK-2025-024', 'ДС «Солнышко»', 'Айгуль Сейткали', '18 поз.', '₸ 52,400', '04 янв', OrderStatus.inProgress),
    _Order('ZK-2025-023', 'ДС «Радуга»', 'Данияр Ахметов', '22 поз.', '₸ 68,200', '04 янв', OrderStatus.inDelivery),
    _Order('ZK-2025-022', 'ДС «Берёзка»', 'Зарина Мусаева', '11 поз.', '₸ 31,800', '03 янв', OrderStatus.delivered),
    _Order('ZK-2025-021', 'ДС «Ромашка»', 'Нурлан Касымов', '9 поз.', '₸ 27,500', '03 янв', OrderStatus.inDelivery),
    _Order('ZK-2025-020', 'ДС «Звёздочка»', 'Гульнар Бекова', '14 поз.', '₸ 42,100', '02 янв', OrderStatus.delivered),
    _Order('ZK-2025-019', 'ДС «Арман»', 'Асем Нурланова', '5 поз.', '₸ 14,800', '02 янв', OrderStatus.draft),
    _Order('ZK-2025-018', 'ДС «Достык»', 'Куаныш Джаксыбеков', '20 поз.', '₸ 58,300', '01 янв', OrderStatus.inProgress),
    _Order('ZK-2025-017', 'ДС «Алтын»', 'Фариза Токтарова', '16 поз.', '₸ 47,900', '30 дек', OrderStatus.delivered),
  ];

  List<_Order> get _filtered {
    var list = _filter == 0 ? _orders : _orders.where((o) => o.status.index == _filter - 1).toList();
    if (_search.isNotEmpty) {
      list = list.where((o) =>
          o.garden.toLowerCase().contains(_search.toLowerCase()) ||
          o.id.toLowerCase().contains(_search.toLowerCase())).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Все заказы'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _search = v),
              decoration: const InputDecoration(
                hintText: 'Поиск по ДС или номеру заказа...',
                prefixIcon: Icon(Icons.search_rounded, color: AppColors.textSub),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter chips
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              itemCount: _filterLabels.length,
              itemBuilder: (_, i) {
                final sel = _filter == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _filter = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: sel ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: sel ? AppColors.primary : AppColors.border),
                      ),
                      alignment: Alignment.center,
                      child: Text(_filterLabels[i],
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: sel ? Colors.white : AppColors.text)),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Row(
              children: [
                Text('${_filtered.length} заказов',
                    style: const TextStyle(fontSize: 13, color: AppColors.textSub)),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final o = _filtered[i];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => _showOrderSheet(context, o),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
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
                                      Text(o.garden,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.text)),
                                      Text(o.manager,
                                          style: const TextStyle(
                                              fontSize: 12, color: AppColors.textSub)),
                                    ],
                                  ),
                                ),
                                StatusChip(status: o.status, small: true),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text('#${o.id}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textSub)),
                                const SizedBox(width: 10),
                                const Icon(Icons.inventory_2_outlined,
                                    size: 12, color: AppColors.textSub),
                                const SizedBox(width: 3),
                                Text(o.items,
                                    style: const TextStyle(
                                        fontSize: 12, color: AppColors.textSub)),
                                const Spacer(),
                                Text(o.amount,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.text)),
                              ],
                            ),
                            if (o.status == OrderStatus.inProgress ||
                                o.status == OrderStatus.draft) ...[
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)),
                                        side: const BorderSide(color: AppColors.border),
                                      ),
                                      child: const Text('Отклонить',
                                          style: TextStyle(
                                              fontSize: 13, color: AppColors.textSub)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: FilledButton(
                                      onPressed: () {},
                                      style: FilledButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        minimumSize: Size.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)),
                                      ),
                                      child: const Text('Подтвердить',
                                          style: TextStyle(fontSize: 13)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderSheet(BuildContext context, _Order o) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 36, height: 4,
                decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(o.garden,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700)),
                StatusChip(status: o.status),
              ],
            ),
            const SizedBox(height: 16),
            _SheetRow('Номер заказа', '#${o.id}'),
            _SheetRow('Менеджер', o.manager),
            _SheetRow('Количество позиций', o.items),
            _SheetRow('Сумма', o.amount),
            _SheetRow('Дата', o.date),
            const SizedBox(height: 20),
            FilledButton(onPressed: () => Navigator.pop(context),
                child: const Text('Закрыть')),
          ],
        ),
      ),
    );
  }
}

class _SheetRow extends StatelessWidget {
  const _SheetRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSub, fontSize: 14)),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.text)),
        ],
      ),
    );
  }
}

class _Order {
  const _Order(this.id, this.garden, this.manager, this.items, this.amount, this.date, this.status);
  final String id;
  final String garden;
  final String manager;
  final String items;
  final String amount;
  final String date;
  final OrderStatus status;
}
