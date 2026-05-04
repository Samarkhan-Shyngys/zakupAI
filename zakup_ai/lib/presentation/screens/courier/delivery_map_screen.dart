import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class DeliveryMapScreen extends StatelessWidget {
  const DeliveryMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Карта маршрута'),
      ),
      body: Stack(
        children: [
          // Map placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFE8F0E9),
            child: CustomPaint(painter: _MapPainter()),
          ),
          // Map pin overlays
          ..._pins.map((p) => Positioned(
                left: p.x,
                top: p.y,
                child: _MapPin(
                    label: p.label, done: p.done, current: p.current),
              )),
          // Bottom sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Следующая остановка',
                          style: TextStyle(fontSize: 13, color: AppColors.textSub)),
                      Text('2 из 4',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.inDeliveryBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.school_rounded,
                            color: AppColors.inDelivery, size: 22),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ДС «Радуга»',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.text)),
                            Text('ул. Ленина 45 • 2.4 км',
                                style: TextStyle(
                                    fontSize: 13, color: AppColors.textSub)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('11:30',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.text)),
                          Text('~12 мин',
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.textSub)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.navigation_rounded, size: 16),
                          label: const Text('Навигатор'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            foregroundColor: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.check_circle_outlined, size: 16),
                          label: const Text('Прибыл'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            minimumSize: Size.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const _pins = [
    _Pin(60, 120, 'Магазин', false, false),
    _Pin(140, 220, 'ДС Солнышко', true, false),
    _Pin(230, 160, 'ДС Радуга', false, true),
    _Pin(290, 300, 'ДС Берёзка', false, false),
    _Pin(180, 380, 'ДС Ромашка', false, false),
  ];
}

class _Pin {
  const _Pin(this.x, this.y, this.label, this.done, this.current);
  final double x;
  final double y;
  final String label;
  final bool done;
  final bool current;
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.label, required this.done, required this.current});
  final String label;
  final bool done;
  final bool current;

  @override
  Widget build(BuildContext context) {
    final color = done
        ? AppColors.delivered
        : current
            ? AppColors.inDelivery
            : AppColors.primary;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Text(label,
              style: const TextStyle(
                  color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
        ),
        CustomPaint(
          size: const Size(12, 8),
          painter: _PinTail(color),
        ),
      ],
    );
  }
}

class _PinTail extends CustomPainter {
  _PinTail(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dottedPaint = Paint()
      ..color = AppColors.primary.withOpacity(0.4)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Roads
    canvas.drawLine(Offset(size.width * 0.1, size.height * 0.15),
        Offset(size.width * 0.9, size.height * 0.4), roadPaint);
    canvas.drawLine(Offset(size.width * 0.2, size.height * 0.1),
        Offset(size.width * 0.2, size.height * 0.9), roadPaint);
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.0),
        Offset(size.width * 0.5, size.height * 1.0), roadPaint);
    canvas.drawLine(Offset(size.width * 0.0, size.height * 0.6),
        Offset(size.width * 1.0, size.height * 0.6), roadPaint);

    // Route line
    final routePath = Path()
      ..moveTo(size.width * 0.18, size.height * 0.25)
      ..lineTo(size.width * 0.38, size.height * 0.35)
      ..lineTo(size.width * 0.62, size.height * 0.27)
      ..lineTo(size.width * 0.78, size.height * 0.48)
      ..lineTo(size.width * 0.48, size.height * 0.62);

    // Draw dashed route
    final pathMetrics = routePath.computeMetrics();
    for (final metric in pathMetrics) {
      double dist = 0;
      while (dist < metric.length) {
        final seg = metric.extractPath(dist, dist + 12);
        canvas.drawPath(seg, dottedPaint);
        dist += 18;
      }
    }

    // Grid overlay
    final gridPaint = Paint()
      ..color = Colors.black.withOpacity(0.04)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
