import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({super.key});

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  int _selectedCategory = 0;
  String _search = '';
  final _searchController = TextEditingController();
  final Map<int, int> _cart = {};

  static const _categories = [
    ('Все', Icons.grid_view_rounded),
    ('Овощи', Icons.eco_rounded),
    ('Фрукты', Icons.apple_rounded),
    ('Молочные', Icons.water_drop_rounded),
    ('Крупы', Icons.grain_rounded),
    ('Мясо', Icons.set_meal_rounded),
  ];

  static const _products = [
    _Product(0, 1, '🥕', 'Морковь', 'кг', 180, 'Свежая, мытая'),
    _Product(1, 1, '🥔', 'Картофель', 'кг', 150, 'Отборный'),
    _Product(2, 1, '🧅', 'Лук репчатый', 'кг', 120, 'Средний'),
    _Product(3, 1, '🥦', 'Капуста белокочанная', 'кг', 140, 'Свежая'),
    _Product(4, 1, '🫑', 'Перец болгарский', 'кг', 380, 'Красный/зелёный'),
    _Product(5, 2, '🍎', 'Яблоко', 'кг', 320, 'Голден, Казахстан'),
    _Product(6, 2, '🍊', 'Мандарин', 'кг', 420, 'Турция'),
    _Product(7, 2, '🍌', 'Банан', 'кг', 380, 'Эквадор'),
    _Product(8, 3, '🥛', 'Молоко 2,5%', 'л', 280, 'Савушкин, 1л'),
    _Product(9, 3, '🧈', 'Масло сливочное 82,5%', 'кг', 1800, '200г пачка'),
    _Product(10, 3, '🧀', 'Сыр твёрдый', 'кг', 2200, 'Российский'),
    _Product(11, 4, '🌾', 'Гречка', 'кг', 340, 'Ядрица, 1 сорт'),
    _Product(12, 4, '🌾', 'Рис', 'кг', 280, 'Длиннозёрный'),
    _Product(13, 4, '🌾', 'Овсянка', 'кг', 220, 'Геркулес'),
    _Product(14, 5, '🥩', 'Говядина', 'кг', 2800, 'Охлаждённая'),
    _Product(15, 5, '🍗', 'Куриное филе', 'кг', 1600, 'Охлаждённое'),
  ];

  List<_Product> get _filtered {
    var list = _selectedCategory == 0
        ? _products
        : _products.where((p) => p.category == _selectedCategory).toList();
    if (_search.isNotEmpty) {
      list = list.where((p) => p.name.toLowerCase().contains(_search.toLowerCase())).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Каталог продуктов'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 16, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text(
                    '${_cart.values.fold(0, (a, b) => a + b)}',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _search = v),
              decoration: const InputDecoration(
                hintText: 'Поиск продуктов...',
                prefixIcon: Icon(Icons.search_rounded, color: AppColors.textSub),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              itemCount: _categories.length,
              itemBuilder: (_, i) {
                final selected = _selectedCategory == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedCategory = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(_categories[i].$2,
                              size: 14,
                              color: selected ? Colors.white : AppColors.textSub),
                          const SizedBox(width: 5),
                          Text(
                            _categories[i].$1,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: selected ? Colors.white : AppColors.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final p = _filtered[i];
                final qty = _cart[p.id] ?? 0;
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.scaffold,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(p.emoji, style: const TextStyle(fontSize: 26)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.name,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.text)),
                            const SizedBox(height: 2),
                            Text(p.desc,
                                style: const TextStyle(fontSize: 12, color: AppColors.textSub)),
                            const SizedBox(height: 4),
                            Text(
                              '₸ ${p.price} / ${p.unit}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      qty == 0
                          ? GestureDetector(
                              onTap: () => setState(() => _cart[p.id] = 1),
                              child: Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.add, color: Colors.white, size: 20),
                              ),
                            )
                          : Row(
                              children: [
                                _QtyBtn(
                                  icon: Icons.remove,
                                  onTap: () => setState(() {
                                    if (_cart[p.id]! > 1) {
                                      _cart[p.id] = _cart[p.id]! - 1;
                                    } else {
                                      _cart.remove(p.id);
                                    }
                                  }),
                                ),
                                SizedBox(
                                  width: 32,
                                  child: Text(
                                    '$qty',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.w700),
                                  ),
                                ),
                                _QtyBtn(
                                  icon: Icons.add,
                                  filled: true,
                                  onTap: () =>
                                      setState(() => _cart[p.id] = (_cart[p.id] ?? 0) + 1),
                                ),
                              ],
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

class _QtyBtn extends StatelessWidget {
  const _QtyBtn({required this.icon, required this.onTap, this.filled = false});
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

class _Product {
  const _Product(this.id, this.category, this.emoji, this.name, this.unit, this.price, this.desc);
  final int id;
  final int category;
  final String emoji;
  final String name;
  final String unit;
  final int price;
  final String desc;
}
