import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'manager/manager_main_screen.dart';
import 'admin/admin_main_screen.dart';
import 'courier/courier_main_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 48),
            // Logo + Brand
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.storefront_rounded, size: 38, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'ЗакупАИ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Система управления закупками\nдля детских садов',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.75),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 48),
            // Role cards
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.scaffold,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
                  children: [
                    const Text(
                      'Выберите роль',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSub,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _RoleCard(
                      icon: Icons.shopping_bag_rounded,
                      iconBg: AppColors.primaryLight,
                      iconColor: AppColors.primary,
                      title: 'Менеджер ДС',
                      subtitle: 'Формирование и отслеживание\nзаказов продуктов',
                      onTap: () => _navigate(context, const ManagerMainScreen()),
                    ),
                    const SizedBox(height: 12),
                    _RoleCard(
                      icon: Icons.admin_panel_settings_rounded,
                      iconBg: AppColors.inProgressBg,
                      iconColor: AppColors.inProgress,
                      title: 'Администратор',
                      subtitle: 'Управление всеми заказами,\nаналитика и отчёты',
                      onTap: () => _navigate(context, const AdminMainScreen()),
                    ),
                    const SizedBox(height: 12),
                    _RoleCard(
                      icon: Icons.local_shipping_rounded,
                      iconBg: AppColors.inDeliveryBg,
                      iconColor: AppColors.inDelivery,
                      title: 'Курьер / Снабженец',
                      subtitle: 'Доставка заказов по детским\nсадам по маршруту',
                      onTap: () => _navigate(context, const CourierMainScreen()),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'ЗакупАИ v1.0 • Казахстан / Россия',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: AppColors.textSub.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigate(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(14)),
                child: Icon(icon, color: iconColor, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 13, color: AppColors.textSub, height: 1.4),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textSub),
            ],
          ),
        ),
      ),
    );
  }
}
