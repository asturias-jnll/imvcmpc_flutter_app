import 'dart:async';
import 'package:flutter/material.dart';
import 'horizontal_bar_chart_card.dart';
import '../theme_colors.dart';

class BranchRankingsCarousel extends StatefulWidget {
  final List<BranchBarData> disbursementData;
  final List<BranchBarData> savingsData;
  final bool small;
  final bool long;
  const BranchRankingsCarousel({
    super.key,
    required this.disbursementData,
    required this.savingsData,
    this.small = false,
    this.long = false,
  });

  @override
  State<BranchRankingsCarousel> createState() => _BranchRankingsCarouselState();
}

class _BranchRankingsCarouselState extends State<BranchRankingsCarousel> {
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
        SizedBox(
          height: widget.small ? 320 : 400,
          width: widget.long ? 520 : null,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              HorizontalBarChartCard(
                title: 'Branch Savings Rankings',
                icon: Icons.savings,
                data: widget.savingsData,
                barColor: AppColors.darkGreen,
                isDisbursement: false,
                small: widget.small,
                long: widget.long,
              ),
              HorizontalBarChartCard(
                title: 'Branch Disbursement Rankings',
                icon: Icons.trending_down,
                data: widget.disbursementData,
                barColor: Colors.red[700]!,
                isDisbursement: true,
                small: widget.small,
                long: widget.long,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
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
