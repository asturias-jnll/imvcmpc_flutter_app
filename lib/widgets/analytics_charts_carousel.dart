import 'dart:async';
import 'package:flutter/material.dart';
import 'chart_card.dart';
import '../theme_colors.dart';

class AnalyticsChartsCarousel extends StatefulWidget {
  const AnalyticsChartsCarousel({super.key});

  @override
  State<AnalyticsChartsCarousel> createState() =>
      _AnalyticsChartsCarouselState();
}

class _AnalyticsChartsCarouselState extends State<AnalyticsChartsCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        _currentPage = (_currentPage + 1) % 2;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Swipeable charts container
        Container(
          height: 280, // Fixed height for consistent carousel
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              // Monthly Savings Chart
              ChartCard(
                title: 'Monthly\nSavings per Branch',
                barHeights: [
                  80,
                  110,
                  70,
                  100,
                  120,
                  90,
                  115,
                  85,
                  105,
                  75,
                  95,
                  100,
                ],
                barLabels: [
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
                ],
                barGradient: const LinearGradient(
                  colors: [AppColors.darkGreen, AppColors.limeGreen],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              // Monthly Disbursements Chart
              ChartCard(
                title: 'Monthly\nDisbursements per Branch',
                barHeights: [
                  60,
                  90,
                  80,
                  110,
                  70,
                  100,
                  120,
                  90,
                  115,
                  85,
                  95,
                  105,
                ],
                barLabels: [
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
                ],
                barGradient: const LinearGradient(
                  colors: [AppColors.green, AppColors.yellowGreen],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? AppColors.darkGreen
                    : Colors.grey.withOpacity(0.3),
              ),
            );
          }),
        ),
      ],
    );
  }
}
