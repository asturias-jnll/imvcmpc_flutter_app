import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  final String title;
  final bool isLine;
  final List<double>? barHeights;
  final List<String>? barLabels;
  final List<double>? lineData;
  final List<String>? lineLabels;
  final bool isSparkline;
  final List<double>? sparklineData;
  final List<String>? sparklineLabels;
  const ChartCard({
    required this.title,
    this.isLine = false,
    this.barHeights,
    this.barLabels,
    this.lineData,
    this.lineLabels,
    this.isSparkline = false,
    this.sparklineData,
    this.sparklineLabels,
    super.key,
  });
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
            height: isSparkline ? 160 : (isLine ? 160 : 160),
            alignment: Alignment.center,
            child: isSparkline
                ? SparklineChart(
                    data:
                        sparklineData ??
                        [80, 110, 70, 100, 120, 90, 115, 85, 105, 75, 95, 100],
                    labels:
                        sparklineLabels ??
                        [
                          'B1',
                          'B2',
                          'B3',
                          'B4',
                          'B5',
                          'B6',
                          'B7',
                          'B8',
                          'B9',
                          'B10',
                          'B11',
                          'B12',
                        ],
                  )
                : isLine
                ? SimpleLineGraph(
                    data:
                        lineData ??
                        [80, 110, 70, 100, 120, 90, 115, 85, 105, 75, 95, 100],
                    labels:
                        lineLabels ??
                        [
                          'B1',
                          'B2',
                          'B3',
                          'B4',
                          'B5',
                          'B6',
                          'B7',
                          'B8',
                          'B9',
                          'B10',
                          'B11',
                          'B12',
                        ],
                  )
                : CustomBarGraph(
                    barHeights:
                        barHeights ??
                        [80, 110, 70, 100, 120, 90, 115, 85, 105, 75],
                    barLabels: barLabels,
                  ),
          ),
        ],
      ),
    );
  }
}

class SimpleLineGraph extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  const SimpleLineGraph({
    this.data = const [80, 110, 70, 100, 120, 90, 115, 85, 105, 75, 95, 100],
    this.labels = const [
      'B1',
      'B2',
      'B3',
      'B4',
      'B5',
      'B6',
      'B7',
      'B8',
      'B9',
      'B10',
      'B11',
      'B12',
    ],
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = 100.0;
        final minValue = data.reduce((a, b) => a < b ? a : b);
        final maxValue = data.reduce((a, b) => a > b ? a : b);
        final minIndex = data.indexOf(minValue);
        final maxIndex = data.indexOf(maxValue);
        final pointCount = data.length;
        // Ensure at least 1 label and 1 point
        final safePointCount = pointCount > 1 ? pointCount : 2;
        // Padding for labels so they don't overflow
        final labelPadding = 12.0;
        final graphWidth = width - 2 * labelPadding;
        final dxStep = graphWidth / (safePointCount - 1);
        final minY = data.reduce((a, b) => a < b ? a : b);
        final maxY = data.reduce((a, b) => a > b ? a : b);
        final yRange = maxY - minY == 0 ? 1 : maxY - minY;
        List<Offset> points = List.generate(
          pointCount,
          (i) => Offset(
            labelPadding + i * dxStep,
            height - ((data[i] - minY) / yRange) * (height - 24),
          ),
        );
        return SizedBox(
          width: width,
          height: height + 32,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(width, height),
                painter: _LineGraphPainter(points),
              ),
              // Draw points
              ...List.generate(
                points.length,
                (i) => Positioned(
                  left: points[i].dx - 5,
                  top: points[i].dy - 5,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: i == minIndex || i == maxIndex
                          ? Colors.red
                          : const Color(0xFF0B5E1C),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),
              // Value indicators for min and max
              Positioned(
                left: points[minIndex].dx - 18,
                top: points[minIndex].dy - 28,
                child: Column(
                  children: [
                    Text(
                      data[minIndex].toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Min',
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: points[maxIndex].dx - 18,
                top: points[maxIndex].dy - 28,
                child: Column(
                  children: [
                    Text(
                      data[maxIndex].toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Max',
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    ),
                  ],
                ),
              ),
              // X axis labels
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      labels.length,
                      (i) => Container(
                        width: dxStep,
                        alignment: i == 0
                            ? Alignment.centerLeft
                            : i == labels.length - 1
                            ? Alignment.centerRight
                            : Alignment.center,
                        child: Text(
                          labels[i],
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
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
  final List<String>? barLabels;
  const CustomBarGraph({required this.barHeights, this.barLabels, super.key});
  @override
  Widget build(BuildContext context) {
    final labels =
        barLabels ??
        [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final barCount = barHeights.length;
        final maxBarWidth = 24.0;
        final minBarWidth = 10.0;
        final availableWidth = constraints.maxWidth;
        final barWidth = ((availableWidth - (barCount - 1) * 4) / barCount)
            .clamp(minBarWidth, maxBarWidth);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            barCount,
            (i) => Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _formatK(barHeights[i]),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B5E1C),
                    ),
                  ),
                  Container(
                    width: barWidth,
                    height: barHeights[i],
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0B5E1C), Color(0xFFB2E5B2)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 28,
                    child: Text(
                      labels.length > i ? labels[i] : '',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SparklineChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  const SparklineChart({
    this.data = const [80, 110, 70, 100, 120, 90, 115, 85, 105, 75, 95, 100],
    this.labels = const [
      'B1',
      'B2',
      'B3',
      'B4',
      'B5',
      'B6',
      'B7',
      'B8',
      'B9',
      'B10',
      'B11',
      'B12',
    ],
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = 90.0;
        final bottomPadding = 18.0;
        final minValue = data.reduce((a, b) => a < b ? a : b);
        final maxValue = data.reduce((a, b) => a > b ? a : b);
        final minIndex = data.indexOf(minValue);
        final maxIndex = data.indexOf(maxValue);
        final count = data.length;
        final padding = 16.0;
        final graphWidth = width - 2 * padding;
        final dxStep = graphWidth / (count - 1);
        final minY = data.reduce((a, b) => a < b ? a : b);
        final maxY = data.reduce((a, b) => a > b ? a : b);
        final yRange = maxY - minY == 0 ? 1 : maxY - minY;
        List<Offset> points = List.generate(
          count,
          (i) => Offset(
            padding + i * dxStep,
            (height - bottomPadding) -
                ((data[i] - minY) / yRange) * (height - bottomPadding - 18),
          ),
        );
        return Column(
          children: [
            SizedBox(
              height: height,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(width, height),
                    painter: _SparklinePainter(points),
                  ),
                  if (minIndex != maxIndex) ...[
                    Positioned(
                      left: points[minIndex].dx - 8,
                      top: points[minIndex].dy - 8,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                    Positioned(
                      left: points[minIndex].dx - 24,
                      top: (points[minIndex].dy + 10).clamp(0.0, height - 20),
                      child: Container(
                        width: 48,
                        alignment: Alignment.center,
                        child: Text(
                          _formatMillions(data[minIndex]),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: points[maxIndex].dx - 8,
                      top: points[maxIndex].dy - 8,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                    Positioned(
                      left: points[maxIndex].dx - 24,
                      top: (points[maxIndex].dy + 10).clamp(0.0, height - 20),
                      child: Container(
                        width: 48,
                        alignment: Alignment.center,
                        child: Text(
                          _formatMillions(data[maxIndex]),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    Positioned(
                      left: points[minIndex].dx - 8,
                      top: points[minIndex].dy - 8,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                    Positioned(
                      left: points[minIndex].dx - 24,
                      top: (points[minIndex].dy + 10).clamp(0.0, height - 20),
                      child: Container(
                        width: 48,
                        alignment: Alignment.center,
                        child: Text(
                          _formatMillions(data[minIndex]),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                labels.length,
                (i) => Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      labels[i],
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lowest:  ' + _formatMillions(minValue),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 500 ? 10 : 11,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Highest:  ' + _formatMillions(maxValue),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 500 ? 10 : 11,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<Offset> points;
  _SparklinePainter(this.points);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0B5E1C)
      ..strokeWidth = 2
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

String _formatK(double value) {
  if (value >= 1000) {
    return (value ~/ 1000).toString() + 'k';
  } else {
    return value.toStringAsFixed(0) + 'k';
  }
}

String _formatMillions(num value) {
  if (value >= 1000000) {
    return (value / 1000000).toStringAsFixed(value % 1000000 == 0 ? 0 : 2) +
        'M';
  } else if (value >= 1000) {
    return (value / 1000).toStringAsFixed(value % 1000 == 0 ? 0 : 1) + 'k';
  } else {
    return value.toStringAsFixed(0);
  }
}
