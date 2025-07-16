import 'package:flutter/material.dart';
import '../widgets/ai_recommendation_card.dart';
import '../widgets/chart_card.dart';
import '../widgets/top_contributors_card.dart';
import '../widgets/top_branches_card.dart';
import '../widgets/filter_button.dart';
import '../widgets/user_profile_bar.dart';

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
            horizontal: isMobile ? 16 : 40,
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar with white background
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
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 28,
                  vertical: 16,
                ),
                margin: const EdgeInsets.only(bottom: 24),
                child: isMobile
                    ? Column(
                        children: [
                          const UserProfileBar(),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              FilterButton(
                                label: 'Filters',
                                options: const [
                                  'BRANCH',
                                  'SAVINGS',
                                  'DISBURSEMENT',
                                  'MONTHLY',
                                  'ANNUALLY',
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                FilterButton(
                                  label: 'Filters',
                                  options: const [
                                    'BRANCH',
                                    'SAVINGS',
                                    'DISBURSEMENT',
                                    'MONTHLY',
                                    'ANNUALLY',
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const UserProfileBar(),
                        ],
                      ),
              ),
              // Dashboard title + AI Recommendation
              isWide
                  ? Row(
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
                                  color: Color(0xFF0B5E1C),
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
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0B5E1C),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Welcome back!',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 18),
                        AIRecommendationCard(),
                      ],
                    ),
              const SizedBox(height: 24),
              // Charts Row
              isWide
                  ? Row(
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
                            ],
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
                            ],
                          ),
                        ),
                        const SizedBox(width: 18),
                        const Expanded(
                          child: ChartCard(
                            title: 'Annual\nSavings per Branch',
                            isLine: true,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: const [
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
                          ],
                        ),
                        SizedBox(height: 18),
                        ChartCard(
                          title: 'Annual\nSavings per Branch',
                          isLine: true,
                        ),
                      ],
                    ),
              const SizedBox(height: 32),
              // Contributors and Branches
              isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(child: TopContributorsCard()),
                        SizedBox(width: 18),
                        SizedBox(width: 340, child: TopBranchesCard()),
                      ],
                    )
                  : Column(
                      children: const [
                        TopContributorsCard(),
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