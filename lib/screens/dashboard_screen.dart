import 'package:flutter/material.dart';
import '../widgets/ai_recommendation_card.dart';
import '../widgets/chart_card.dart';
import '../widgets/top_contributors_card.dart';
import '../widgets/top_branches_card.dart';
import '../widgets/filter_button.dart';
import '../widgets/user_profile_bar.dart';
import '../theme_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final isMobile = constraints.maxWidth < 600;
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 0 : 40,
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar for finance (match ReportsScreen)
              if (isMobile)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  child: Container(
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
                    margin: const EdgeInsets.only(
                      bottom: 18,
                      left: 0,
                      right: 0,
                      top: 0,
                    ),
                    child: const Row(children: [Spacer(), UserProfileBar()]),
                  ),
                ),
              if (isMobile)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dashboard title + AI Recommendation
                      const Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkGreen,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      const Text(
                        'Welcome back!',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      SizedBox(height: 18),
                      const AIRecommendationCard(),
                      SizedBox(height: 24),
                      // Charts
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
                        valueColor: AppColors.darkGreen,
                        backgroundColor: AppColors.yellowGreen.withOpacity(
                          0.18,
                        ),
                      ),
                      SizedBox(height: 32),
                      // Contributors and Branches
                      const TopContributorsCard(),
                      SizedBox(height: 18),
                      const TopBranchesCard(),
                    ],
                  ),
                ),
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
                  child: const Row(children: [Spacer(), UserProfileBar()]),
                ),
              // Dashboard title + AI Recommendation
              if (isWide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Dashboard',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: AppColors.darkGreen,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Welcome back!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    const Expanded(flex: 3, child: AIRecommendationCard()),
                  ],
                ),
              if (isWide) ...[
                const SizedBox(height: 24),
                // Charts Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
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
                    ),
                    const SizedBox(width: 18),
                    Expanded(
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
                    ),
                    const SizedBox(width: 18),
                    Expanded(
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
                        valueColor: AppColors.darkGreen,
                        backgroundColor: AppColors.yellowGreen.withOpacity(
                          0.18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Contributors and Branches
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(child: TopContributorsCard()),
                    SizedBox(width: 18),
                    SizedBox(width: 340, child: TopBranchesCard()),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
