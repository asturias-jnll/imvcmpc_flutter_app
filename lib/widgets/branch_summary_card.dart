import 'package:flutter/material.dart';
import '../theme_colors.dart';
import 'dart:math';
import 'dart:ui';

class BranchSummaryCard extends StatelessWidget {
  final String branch;
  final String month;
  final double savings;
  final double disbursement;
  final bool isMobile;

  // Real branch location map
  String _getBranchLocation(String branch) {
    const branchMap = {
      'IMVCMPC - BRANCH 1': 'IBAAN',
      'IMVCMPC - BRANCH 2': 'BAUAN',
      'IMVCMPC - BRANCH 3': 'SAN JOSE',
      'IMVCMPC - BRANCH 4': 'ROSARIO',
      'IMVCMPC - BRANCH 5': 'SAN JUAN',
      'IMVCMPC - BRANCH 6': 'PADRE GARCIA',
      'IMVCMPC - BRANCH 7': 'LIPA CITY',
      'IMVCMPC - BRANCH 8': 'BATANGAS CITY',
      'IMVCMPC - BRANCH 9': 'MABINI LIPA',
      'IMVCMPC - BRANCH 10': 'CALAMIAS',
      'IMVCMPC - BRANCH 11': 'LEMERY',
      'IMVCMPC - BRANCH 12': 'MATAAS NA KAHOY',
    };
    final match = RegExp(r'BRANCH (\d+)').firstMatch(branch);
    if (match != null) {
      final key = 'IMVCMPC - BRANCH ${match.group(1)}';
      return branchMap[key] ?? 'Unknown';
    }
    return 'Unknown';
  }

  const BranchSummaryCard({
    super.key,
    required this.branch,
    required this.month,
    required this.savings,
    required this.disbursement,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final total = savings + disbursement;
    final savingsPercent = total == 0.0
        ? 0.0
        : (savings / total * 100).toDouble();
    final disbPercent = total == 0.0
        ? 0.0
        : (disbursement / total * 100).toDouble();
    final cardPadding = isMobile
        ? const EdgeInsets.all(12)
        : const EdgeInsets.symmetric(horizontal: 18, vertical: 14);
    final valueStyle = TextStyle(
      fontSize: isMobile ? 18 : 22,
      fontWeight: FontWeight.bold,
      color: AppColors.green,
      shadows: [
        Shadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
      ],
    );
    final labelStyle = TextStyle(
      fontSize: isMobile ? 12 : 14,
      color: Color(0xFF222222),
      fontWeight: FontWeight.w600,
    );
    final divider = Container(
      width: 1,
      height: isMobile ? 60 : 70,
      color: Colors.grey.withOpacity(0.18),
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 16),
    );
    final branchLocation = _getBranchLocation(branch);
    return ClipRRect(
      borderRadius: BorderRadius.circular(isMobile ? 18 : 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(isMobile ? 18 : 24),
          border: Border.all(color: AppColors.green.withOpacity(0.13)),
          boxShadow: [
            BoxShadow(
              color: AppColors.green.withOpacity(0.08),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: isMobile ? 10 : 18),
        child: Stack(
          children: [
            // Gradient accent bar
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 7,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.green, AppColors.yellowGreen],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isMobile ? 18 : 24),
                    bottomLeft: Radius.circular(isMobile ? 18 : 24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: cardPadding.copyWith(left: cardPadding.left + 10),
              child: isMobile
                  ? LayoutBuilder(
                      builder: (context, constraints) {
                        final screenWidth = constraints.maxWidth;
                        final pieSize = screenWidth < 320
                            ? 63.0
                            : (screenWidth < 350
                                  ? 80.0
                                  : (screenWidth < 420 ? 100.0 : 120.0));
                        final cardHPadding = screenWidth < 350 ? 4.0 : 10.0;
                        final cardVPadding = screenWidth < 350 ? 6.0 : 12.0;
                        final fontSizeMain = screenWidth < 320
                            ? 13.0
                            : (screenWidth < 350 ? 15.0 : 19.0);
                        final fontSizeLabel = screenWidth < 350 ? 11.0 : 14.0;
                        final leftGap = screenWidth < 350 ? 12.0 : 20.0;
                        final gap = screenWidth < 320
                            ? 16.0
                            : (screenWidth < 350
                                  ? 20.0
                                  : (screenWidth < 420 ? 28.0 : 36.0));
                        // Remove leftGap, add vertical divider between pie and values
                        final pieAndValuesRow = Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: pieSize,
                              height: pieSize,
                              child: _PieChart(
                                savingsPercent: savingsPercent,
                                disbPercent: disbPercent,
                                isMobile: true,
                                total: total,
                                showCenterPercent: false,
                                withBorder: true,
                                customSize: pieSize,
                              ),
                            ),
                            Container(
                              width: 2,
                              height: pieSize,
                              margin: EdgeInsets.symmetric(horizontal: gap),
                              color: Colors.grey[400],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _SectionLabel(label: 'SAVINGS'),
                                _ValueRow(
                                  icon: Icons.savings,
                                  color: AppColors.green,
                                  value: savings,
                                  percent: savingsPercent,
                                  valueStyle: valueStyle.copyWith(
                                    fontSize: fontSizeMain,
                                  ),
                                  labelStyle: labelStyle.copyWith(
                                    fontSize: fontSizeLabel,
                                  ),
                                  badge: true,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  height: 1,
                                  color: Colors.grey.withOpacity(0.13),
                                ),
                                _SectionLabel(label: 'DISBURSEMENT'),
                                _ValueRow(
                                  icon: Icons.account_balance_wallet,
                                  color: AppColors.yellowGreen,
                                  value: disbursement,
                                  percent: disbPercent,
                                  valueStyle: valueStyle.copyWith(
                                    color: AppColors.yellowGreen,
                                    fontSize: fontSizeMain,
                                  ),
                                  labelStyle: labelStyle.copyWith(
                                    color: AppColors.yellowGreen,
                                    fontSize: fontSizeLabel,
                                  ),
                                  badge: true,
                                ),
                              ],
                            ),
                          ],
                        );
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header with branch left, location right
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _Header(
                                  branch: branch,
                                  month: month,
                                  isMobile: true,
                                  location: '',
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: AppColors.yellowGreen,
                                      size: 15,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      branchLocation,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF444444),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: screenWidth < 350 ? 4 : 8),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: cardHPadding,
                                vertical: cardVPadding,
                              ),
                              child: screenWidth < 320
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: _PieChart(
                                            savingsPercent: savingsPercent,
                                            disbPercent: disbPercent,
                                            isMobile: true,
                                            total: total,
                                            showCenterPercent: false,
                                            withBorder: true,
                                            customSize: pieSize,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        _SectionLabel(label: 'SAVINGS'),
                                        _ValueRow(
                                          icon: Icons.savings,
                                          color: AppColors.green,
                                          value: savings,
                                          percent: savingsPercent,
                                          valueStyle: valueStyle.copyWith(
                                            fontSize: fontSizeMain,
                                          ),
                                          labelStyle: labelStyle.copyWith(
                                            fontSize: fontSizeLabel,
                                          ),
                                          badge: true,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 6,
                                          ),
                                          height: 1,
                                          color: Colors.grey.withOpacity(0.13),
                                        ),
                                        _SectionLabel(label: 'DISBURSEMENT'),
                                        _ValueRow(
                                          icon: Icons.account_balance_wallet,
                                          color: AppColors.yellowGreen,
                                          value: disbursement,
                                          percent: disbPercent,
                                          valueStyle: valueStyle.copyWith(
                                            color: AppColors.yellowGreen,
                                            fontSize: fontSizeMain,
                                          ),
                                          labelStyle: labelStyle.copyWith(
                                            color: AppColors.yellowGreen,
                                            fontSize: fontSizeLabel,
                                          ),
                                          badge: true,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: pieAndValuesRow.children,
                                    ),
                            ),
                          ],
                        );
                      },
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Faint background highlight behind pie chart
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: AppColors.green.withOpacity(0.07),
                                shape: BoxShape.circle,
                              ),
                            ),
                            _PieChart(
                              savingsPercent: savingsPercent,
                              disbPercent: disbPercent,
                              isMobile: false,
                              total: total,
                              showCenterPercent: true,
                              withBorder: true,
                            ),
                          ],
                        ),
                        const SizedBox(width: 18),
                        // Align branch/month header with values
                        _Header(
                          branch: branch,
                          month: month,
                          isMobile: false,
                          location: branchLocation,
                        ),
                        const SizedBox(width: 18),
                        divider,
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _SectionLabel(label: 'SAVINGS'),
                                    _ValueRow(
                                      icon: Icons.savings,
                                      color: AppColors.green,
                                      value: savings,
                                      percent: savingsPercent,
                                      valueStyle: valueStyle,
                                      labelStyle: labelStyle,
                                      badge: true,
                                    ),
                                  ],
                                ),
                              ),
                              divider,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _SectionLabel(label: 'DISBURSEMENT'),
                                    _ValueRow(
                                      icon: Icons.account_balance_wallet,
                                      color: AppColors.yellowGreen,
                                      value: disbursement,
                                      percent: disbPercent,
                                      valueStyle: valueStyle.copyWith(
                                        color: AppColors.yellowGreen,
                                      ),
                                      labelStyle: labelStyle.copyWith(
                                        color: AppColors.yellowGreen,
                                      ),
                                      badge: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: Colors.black54,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class _ValueRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double value;
  final double percent;
  final TextStyle valueStyle;
  final TextStyle labelStyle;
  final bool badge;
  const _ValueRow({
    required this.icon,
    required this.color,
    required this.value,
    required this.percent,
    required this.valueStyle,
    required this.labelStyle,
    this.badge = false,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (badge)
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.13),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(6),
            child: Icon(icon, color: color, size: 18),
          )
        else
          Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        _AnimatedValue(
          value: value,
          builder: (val) =>
              Text('₱${val.toStringAsFixed(0)}', style: valueStyle),
        ),
        const SizedBox(width: 8),
        _AnimatedValue(
          value: percent,
          builder: (val) =>
              Text('${val.toStringAsFixed(1)}%', style: labelStyle),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String branch;
  final String month;
  final bool isMobile;
  final String location;
  const _Header({
    required this.branch,
    required this.month,
    required this.isMobile,
    required this.location,
  });
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: isMobile ? 14 : 16,
      color: Color(0xFF0B5E1C),
      letterSpacing: 0.2,
    );
    return isMobile
        ? Row(
            children: [
              Icon(
                Icons.pie_chart,
                color: AppColors.green,
                size: isMobile ? 18 : 22,
              ),
              const SizedBox(width: 6),
              Text('$branch - $month', style: style),
            ],
          )
        : Row(
            children: [
              Icon(Icons.pie_chart, color: AppColors.green, size: 20),
              const SizedBox(width: 6),
              Text('$branch - $month', style: style),
              const SizedBox(width: 12),
              Icon(Icons.location_on, color: AppColors.yellowGreen, size: 18),
              Text(
                location,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF444444),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
  }
}

class _PieChart extends StatelessWidget {
  final double savingsPercent;
  final double disbPercent;
  final bool isMobile;
  final double total;
  final bool showCenterPercent;
  final bool withBorder;
  final double? customSize;
  const _PieChart({
    required this.savingsPercent,
    required this.disbPercent,
    required this.isMobile,
    required this.total,
    this.showCenterPercent = false,
    this.withBorder = false,
    this.customSize,
  });
  @override
  Widget build(BuildContext context) {
    final size = customSize ?? (isMobile ? 105.0 : 80.0);
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: savingsPercent),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, animatedSavings, _) {
        final animatedDisb = 100 - animatedSavings;
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                painter: _PieChartPainter(
                  animatedSavings,
                  animatedDisb,
                  withBorder: withBorder,
                ),
                size: Size(size, size),
              ),
              showCenterPercent && !isMobile
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '₱${total.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: isMobile ? 9 : 11,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          '₱${total.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 11 : 14,
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final double savingsPercent;
  final double disbPercent;
  final bool withBorder;
  _PieChartPainter(
    this.savingsPercent,
    this.disbPercent, {
    this.withBorder = false,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.18;
    final double startAngle = -3.14 / 2;
    final double sweepSavings = 3.14 * 2 * (savingsPercent / 100);
    final double sweepDisb = 3.14 * 2 * (disbPercent / 100);
    // Savings arc (gradient)
    final savingsGradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepSavings,
      colors: [AppColors.green, AppColors.green.withOpacity(0.7)],
    );
    paint.shader = savingsGradient.createShader(rect);
    paint.color = AppColors.green;
    canvas.drawArc(rect, startAngle, sweepSavings, false, paint);
    // Disbursement arc (gradient)
    final disbGradient = SweepGradient(
      startAngle: startAngle + sweepSavings,
      endAngle: startAngle + sweepSavings + sweepDisb,
      colors: [AppColors.yellowGreen, AppColors.yellowGreen.withOpacity(0.7)],
    );
    paint.shader = disbGradient.createShader(rect);
    paint.color = AppColors.yellowGreen;
    canvas.drawArc(rect, startAngle + sweepSavings, sweepDisb, false, paint);
    // Pie border
    if (withBorder) {
      final borderPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.08
        ..color = Colors.white.withOpacity(0.8);
      canvas.drawCircle(rect.center, size.width / 2.18, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _AnimatedValue extends StatelessWidget {
  final double value;
  final Widget Function(double) builder;
  const _AnimatedValue({required this.value, required this.builder});
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, val, _) => builder(val),
      key: ValueKey(value),
    );
  }
}
