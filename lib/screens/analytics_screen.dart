import 'package:flutter/material.dart';
import '../widgets/user_profile_bar.dart';
import '../widgets/filter_button.dart';
import '../widgets/ai_recommendation_card.dart';
import '../widgets/chart_card.dart';
import '../widgets/top_branches_card.dart';
import '../theme_colors.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final isMobile = constraints.maxWidth < 600;
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
                // Filters in a Row
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: FilterButton(
                          label: 'Filter by Branch',
                          options: [for (int i = 1; i <= 12; i++) 'BRANCH $i'],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: FilterButton(
                          label: 'Filter by Month',
                          options: const [
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
                          ],
                        ),
                      ),
                    ),
                  ],
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
                      FilterButton(
                        label: 'Filter by Branch',
                        options: [for (int i = 1; i <= 12; i++) 'BRANCH $i'],
                      ),
                      const SizedBox(width: 10),
                      FilterButton(
                        label: 'Filter by Month',
                        options: const [
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
                        ],
                      ),
                      const Spacer(),
                      const UserProfileBar(),
                    ],
                  ),
                ),
              // AI Recommendation
              const AIRecommendationCard(),
              const SizedBox(height: 24),
              // Charts and Top Branches
              isWide
                  ? IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Left column: Monthly Savings (top), Monthly Disbursements (bottom)
                          Expanded(
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 280,
                                  child: ChartCard(
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
                                  ),
                                ),
                                SizedBox(height: 18),
                                SizedBox(
                                  height: 280,
                                  child: ChartCard(
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
                                  ),
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
                        ),
                        SizedBox(height: 18),
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
                        ),
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
                        TopBranchesCard(),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}
