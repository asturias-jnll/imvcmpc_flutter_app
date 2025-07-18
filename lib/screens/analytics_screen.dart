import 'package:flutter/material.dart';
import '../widgets/user_profile_bar.dart';
import '../widgets/filter_button.dart';
import '../widgets/ai_recommendation_card.dart';
import '../widgets/chart_card.dart';
import '../widgets/top_branches_card.dart';
import '../widgets/branch_summary_card.dart';
import '../widgets/analytics_charts_carousel.dart';
import '../widgets/branch_rankings_carousel.dart';
import '../widgets/horizontal_bar_chart_card.dart';
import '../theme_colors.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int selectedBranch = 1;
  String selectedMonth = 'JANUARY';

  final branchOptions = [for (int i = 1; i <= 12; i++) 'BRANCH $i'];
  static const monthOptions = [
    'JANUARY',
    'FEBRUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final isMobile = constraints.maxWidth < 600;
        // Branches and locations
        final List<Map<String, String>> branches = [
          {'branch': 'IMVCMPC - BRANCH 1', 'location': 'IBAAN'},
          {'branch': 'IMVCMPC - BRANCH 2', 'location': 'BAUAN'},
          {'branch': 'IMVCMPC - BRANCH 3', 'location': 'SAN JOSE'},
          {'branch': 'IMVCMPC - BRANCH 4', 'location': 'ROSARIO'},
          {'branch': 'IMVCMPC - BRANCH 5', 'location': 'SAN JUAN'},
          {'branch': 'IMVCMPC - BRANCH 6', 'location': 'PADRE GARCIA'},
          {'branch': 'IMVCMPC - BRANCH 7', 'location': 'LIPA CITY'},
          {'branch': 'IMVCMPC - BRANCH 8', 'location': 'BATANGAS CITY'},
          {'branch': 'IMVCMPC - BRANCH 9', 'location': 'MABINI LIPA'},
          {'branch': 'IMVCMPC - BRANCH 10', 'location': 'CALAMIAS'},
          {'branch': 'IMVCMPC - BRANCH 11', 'location': 'LEMERY'},
          {'branch': 'IMVCMPC - BRANCH 12', 'location': 'MATAAS NA KAHOY'},
        ];
        // Short branch codes for display
        final List<String> branchCodes = [
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
        ];
        // Custom branch orders for demo
        final disbursementOrder = [
          4,
          11,
          2,
          6,
          1,
          7,
          8,
          9,
          10,
          0,
          3,
          5,
        ]; // 5,12,3,7,2,... (0-based)
        final savingsOrder = [
          8,
          5,
          2,
          4,
          0,
          1,
          3,
          6,
          7,
          9,
          10,
          11,
        ]; // 9,6,3,5,1,... (0-based)
        final savingsData = List.generate(
          12,
          (i) => BranchBarData(
            branch: branchCodes[savingsOrder[i]],
            location: branches[savingsOrder[i]]['location']!,
            value: 80000 + (i * 12000) + (i.isEven ? 10000 : 0),
          ),
        );
        final disbursementData = List.generate(
          12,
          (i) => BranchBarData(
            branch: branchCodes[disbursementOrder[i]],
            location: branches[disbursementOrder[i]]['location']!,
            value: 60000 + (i * 9000) + (i.isOdd ? 8000 : 0),
          ),
        );
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 40,
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isMobile) ...[
                // Appbar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  margin: const EdgeInsets.only(bottom: 18),
                  child: const Row(children: [Spacer(), UserProfileBar()]),
                ),
                // Modern Filter Section
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Filter Header with icon
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF0B5E1C),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(7),
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Analytics Filters',
                            style: TextStyle(
                              color: const Color(0xFF0B5E1C),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Branch and Month Filters in a single row
                      Row(
                        children: [
                          Expanded(
                            child: FilterButton(
                              label: branchOptions[selectedBranch - 1],
                              options: branchOptions,
                              onSelected: (value) {
                                setState(() {
                                  selectedBranch =
                                      branchOptions.indexOf(value) + 1;
                                });
                              },
                              noRightMargin: false,
                              icon: Icons.store,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FilterButton(
                              label: selectedMonth,
                              options: monthOptions,
                              onSelected: (value) {
                                setState(() {
                                  selectedMonth = value;
                                });
                              },
                              noRightMargin: true,
                              icon: Icons.calendar_today,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
              ],
              if (!isMobile)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 16,
                  ),
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Filter Header with icon
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0B5E1C),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(7),
                        child: const Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Analytics Filters',
                        style: TextStyle(
                          color: const Color(0xFF0B5E1C),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 24),
                      FilterButton(
                        label: branchOptions[selectedBranch - 1],
                        options: branchOptions,
                        onSelected: (value) {
                          setState(() {
                            selectedBranch = branchOptions.indexOf(value) + 1;
                          });
                        },
                        icon: Icons.store,
                      ),
                      const SizedBox(width: 10),
                      FilterButton(
                        label: selectedMonth,
                        options: monthOptions,
                        onSelected: (value) {
                          setState(() {
                            selectedMonth = value;
                          });
                        },
                        icon: Icons.calendar_today,
                      ),
                      const Spacer(),
                      const UserProfileBar(),
                    ],
                  ),
                ),
              // AI Recommendation
              const AIRecommendationCard(),
              const SizedBox(height: 18),
              // Branch summary card (moved below AI recommendation)
              BranchSummaryCard(
                branch: branchOptions[selectedBranch - 1],
                month: selectedMonth,
                savings: _getSavings(selectedBranch, selectedMonth),
                disbursement: _getDisbursement(selectedBranch, selectedMonth),
                isMobile: isMobile,
              ),
              const SizedBox(height: 18),
              // Charts and Top Branches
              isWide
                  ? IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left column: Swipeable Monthly Charts + BranchRankingsCarousel
                          Expanded(
                            child: Column(
                              children: [
                                AnalyticsChartsCarousel(),
                                const SizedBox(height: 12),
                                BranchRankingsCarousel(
                                  disbursementData: disbursementData,
                                  savingsData: savingsData,
                                  small: true,
                                  long: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 18),
                          // Right column: Annual Savings (top), Top Branches (bottom)
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 280,
                                  child: ChartCard(
                                    title: 'Annual\nSavings per Branch',
                                    isSparkline: true,
                                    sparklineData: [
                                      1200000,
                                      1500000,
                                      900000,
                                      1300000,
                                      1800000,
                                      1100000,
                                      1600000,
                                      1000000,
                                      1400000,
                                      950000,
                                      1250000,
                                      1350000,
                                    ],
                                    sparklineLabels: [
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
                                    backgroundColor: AppColors.yellowGreen
                                        .withOpacity(0.18),
                                  ),
                                ),
                                SizedBox(height: 18),
                                TopBranchesCard(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        AnalyticsChartsCarousel(),
                        SizedBox(height: 18),
                        ChartCard(
                          title: 'Annual\nSavings per Branch',
                          isSparkline: true,
                          sparklineData: [
                            1200000,
                            1500000,
                            900000,
                            1300000,
                            1800000,
                            1100000,
                            1600000,
                            1000000,
                            1400000,
                            950000,
                            1250000,
                            1350000,
                          ],
                          sparklineLabels: [
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
                          backgroundColor: AppColors.yellowGreen.withOpacity(
                            0.18,
                          ),
                        ),
                        SizedBox(height: 18),
                        BranchRankingsCarousel(
                          disbursementData: disbursementData,
                          savingsData: savingsData,
                          small: true,
                          long: false,
                        ),
                        TopBranchesCard(),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  // Add mock data methods for now
  double _getSavings(int branch, String month) {
    // Replace with real data logic
    return 100000.0 + branch * 5000 + monthOptions.indexOf(month) * 2000;
  }

  double _getDisbursement(int branch, String month) {
    // Replace with real data logic
    return 80000.0 + branch * 4000 + monthOptions.indexOf(month) * 1500;
  }
}
