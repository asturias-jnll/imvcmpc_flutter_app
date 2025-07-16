import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  final String title;
  final bool isLine;
  final List<double>? barHeights;
  const ChartCard({required this.title, this.isLine = false, this.barHeights, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: isLine ? 120 : 120,
            alignment: Alignment.center,
            child: isLine
                ? const SimpleLineGraph()
                : CustomBarGraph(
                    barHeights:
                        barHeights ??
                        [80, 110, 70, 100, 120, 90, 115, 85, 105, 75],
                  ),
          ),
        ],
      ),
    );
  }
}

class SimpleLineGraph extends StatelessWidget {
  const SimpleLineGraph({super.key});
  @override
  Widget build(BuildContext context) {
    // Responsive width/height for the line graph
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = 80.0;
        final points = [
          Offset(0, height * 0.75),
          Offset(width * 0.1, height * 0.5),
          Offset(width * 0.2, height * 0.7),
          Offset(width * 0.3, height * 0.3),
          Offset(width * 0.4, height * 0.6),
          Offset(width * 0.5, height * 0.2),
          Offset(width * 0.6, height * 0.5),
          Offset(width * 0.7, height * 0.3),
          Offset(width * 0.8, height * 0.75),
          Offset(width * 0.9, height * 0.5),
          Offset(width, height * 0.6),
        ];
        return SizedBox(
          width: width,
          height: height,
          child: CustomPaint(painter: _LineGraphPainter(points)),
        );
      },
    );
  }
}

class _LineGraphPainter extends CustomPainter {
  final List<Offset> points;
  _LineGraphPainter(this.points);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0B5E1C)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final path = Path();
    if (points.isNotEmpty) {
      path.moveTo(points[0].dx, points[0].dy);
      for (var i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomBarGraph extends StatelessWidget {
  final List<double> barHeights;
  const CustomBarGraph({required this.barHeights, super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        barHeights.length,
        (i) => Container(
          width: 18,
          height: barHeights[i],
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(
              colors: [Color(0xFF0B5E1C), Color(0xFFB2E5B2)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
    );
  }
} 