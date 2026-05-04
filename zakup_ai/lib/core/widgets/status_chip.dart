import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum OrderStatus { draft, inProgress, inDelivery, delivered }

extension OrderStatusLabel on OrderStatus {
  String get label => switch (this) {
        OrderStatus.draft => 'Черновик',
        OrderStatus.inProgress => 'В работе',
        OrderStatus.inDelivery => 'В доставке',
        OrderStatus.delivered => 'Доставлен',
      };

  Color get color => switch (this) {
        OrderStatus.draft => AppColors.draft,
        OrderStatus.inProgress => AppColors.inProgress,
        OrderStatus.inDelivery => AppColors.inDelivery,
        OrderStatus.delivered => AppColors.delivered,
      };

  Color get bg => switch (this) {
        OrderStatus.draft => AppColors.draftBg,
        OrderStatus.inProgress => AppColors.inProgressBg,
        OrderStatus.inDelivery => AppColors.inDeliveryBg,
        OrderStatus.delivered => AppColors.deliveredBg,
      };
}

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status, this.small = false});

  final OrderStatus status;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 10,
        vertical: small ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: status.bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: status.color,
          fontSize: small ? 11 : 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
