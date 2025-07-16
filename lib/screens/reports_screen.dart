import 'package:flutter/material.dart';
import '../widgets/user_profile_bar.dart';
import '../widgets/styled_dropdown.dart';
import '../widgets/reports_summary_row.dart';
import '../widgets/type_toggle_button.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});
  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final branches = [
    'Select Branch',
    'Branch 1 - IBAAN',
    'Branch 2 - BAUAN',
    'Branch 3 - SAN JOSE',
    'Branch 4 - ROSARIO',
    'Branch 5 - SAN JUAN',
    'Branch 6 - PADRE GARCIA',
    'Branch 7 - LIPA CITY',
    'Branch 8 - BATANGAS CITY',
    'Branch 9 - MABINI LIPA',
  ];
  final months = [
    'Select Month',
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
  final years = ['Select Year', '2025', '2024', '2023', '2022'];
  final types = ['Select Type', 'SAVINGS', 'DISBURSEMENT'];

  String selectedBranch = 'Select Branch';
  String selectedMonth = 'Select Month';
  String selectedYear = 'Select Year';
  String selectedType = 'Select Type';
  String selectedOption = 'Select';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Scaffold(
          backgroundColor: const Color(0xFFE9EEF3),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 40,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : 28,
                        vertical: 16,
                      ),
                      margin: const EdgeInsets.only(bottom: 24),
                      child: isMobile
                          ? Column(
                              children: [
                                const Text(
                                  'Reports',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0B5E1C),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const UserProfileBar(),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Reports',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0B5E1C),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const Spacer(),
                                const UserProfileBar(),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Top row: SELECT BRANCH, SELECT MONTH, SELECT YEAR
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 40,
                    ),
                    child: isMobile
                        ? Column(
                            children: [
                              StyledDropdown<String>(
                                value: selectedBranch,
                                items: branches,
                                onChanged: (v) =>
                                    setState(() => selectedBranch = v!),
                              ),
                              const SizedBox(height: 12),
                              StyledDropdown<String>(
                                value: selectedMonth,
                                items: months,
                                onChanged: (v) =>
                                    setState(() => selectedMonth = v!),
                              ),
                              const SizedBox(height: 12),
                              StyledDropdown<String>(
                                value: selectedYear,
                                items: years,
                                onChanged: (v) =>
                                    setState(() => selectedYear = v!),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: StyledDropdown<String>(
                                  value: selectedBranch,
                                  items: branches,
                                  onChanged: (v) =>
                                      setState(() => selectedBranch = v!),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: StyledDropdown<String>(
                                  value: selectedMonth,
                                  items: months,
                                  onChanged: (v) =>
                                      setState(() => selectedMonth = v!),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: StyledDropdown<String>(
                                  value: selectedYear,
                                  items: years,
                                  onChanged: (v) =>
                                      setState(() => selectedYear = v!),
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 12),
                  // Two-column grid: left (MEMBER/SAVINGS/DISBURSEMENT), right (TYPE MEMBER/SUMMARY)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 40,
                    ),
                    child: isMobile
                        ? Column(
                            children: [
                              // Left column
                              Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 44,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF0B5E1C,
                                        ).withOpacity(0.5),
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          side: const BorderSide(
                                            color: Color(0xFF0B5E1C),
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      onPressed: () {},
                                      child: const Text('MEMBER'),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 54,
                                    child: TypeToggleButton(
                                      label: 'SAVINGS',
                                      icon: Icons.savings,
                                      selected: selectedType == 'SAVINGS',
                                      onTap: () => setState(
                                        () => selectedType = 'SAVINGS',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 54,
                                    child: TypeToggleButton(
                                      label: 'DISBURSEMENT',
                                      icon: Icons.payments,
                                      selected: selectedType == 'DISBURSEMENT',
                                      onTap: () => setState(
                                        () => selectedType = 'DISBURSEMENT',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Right column
                              Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 44,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'TYPE MEMBER.........',
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 10,
                                            ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF0B5E1C),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF0B5E1C),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 116,
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFF0B5E1C),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ReportsSummaryRow(
                                            label: 'SELECTED BRANCH',
                                            value:
                                                selectedBranch ==
                                                        'Select Branch'
                                                    ? '-'
                                                    : selectedBranch
                                                          .split('-')
                                                          .last
                                                          .trim(),
                                          ),
                                          const SizedBox(height: 8),
                                          ReportsSummaryRow(
                                            label: 'SELECTED DATE',
                                            value:
                                                (selectedMonth ==
                                                        'Select Month' ||
                                                    selectedYear ==
                                                        'Select Year')
                                                    ? '-'
                                                    : '${selectedMonth} ${selectedYear}',
                                          ),
                                          const SizedBox(height: 8),
                                          ReportsSummaryRow(
                                            label: 'SELECTED TYPE',
                                            value: selectedType == 'Select Type'
                                                ? '-'
                                                : selectedType,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 44,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF0B5E1C,
                                          ).withOpacity(0.5),
                                          foregroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            side: const BorderSide(
                                              color: Color(0xFF0B5E1C),
                                            ),
                                          ),
                                          elevation: 0,
                                        ),
                                        onPressed: () {},
                                        child: const Text('MEMBER'),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 54,
                                      child: TypeToggleButton(
                                        label: 'SAVINGS',
                                        icon: Icons.savings,
                                        selected: selectedType == 'SAVINGS',
                                        onTap: () => setState(
                                          () => selectedType = 'SAVINGS',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 54,
                                      child: TypeToggleButton(
                                        label: 'DISBURSEMENT',
                                        icon: Icons.payments,
                                        selected:
                                            selectedType == 'DISBURSEMENT',
                                        onTap: () => setState(
                                          () => selectedType = 'DISBURSEMENT',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 44,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'TYPE MEMBER.........',
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 10,
                                              ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF0B5E1C),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF0B5E1C),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 116,
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xFF0B5E1C),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ReportsSummaryRow(
                                              label: 'SELECTED BRANCH',
                                              value:
                                                  selectedBranch ==
                                                      'Select Branch'
                                                  ? '-'
                                                  : selectedBranch
                                                        .split('-')
                                                        .last
                                                        .trim(),
                                            ),
                                            const SizedBox(height: 8),
                                            ReportsSummaryRow(
                                              label: 'SELECTED DATE',
                                              value:
                                                  (selectedMonth ==
                                                          'Select Month' ||
                                                      selectedYear ==
                                                          'Select Year')
                                                      ? '-'
                                                      : '${selectedMonth} ${selectedYear}',
                                            ),
                                            const SizedBox(height: 8),
                                            ReportsSummaryRow(
                                              label: 'SELECTED TYPE',
                                              value:
                                                  selectedType == 'Select Type'
                                                  ? '-'
                                                  : selectedType,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 32),
                  // Download button
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 40,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF0B5E1C,
                          ).withOpacity(0.5),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: const Text(
                          'DOWNLOAD REPORT AS PDF',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
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