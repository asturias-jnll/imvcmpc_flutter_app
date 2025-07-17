import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    'Branch 10 - CALAMIAS',
    'Branch 11 - LEMERY',
    'Branch 12 - MATAAS NA KAHOY',
  ];
  final types = ['Select Type', 'SAVINGS', 'DISBURSEMENT'];

  String selectedBranch = 'Select Branch';
  String selectedType = 'Select Type';
  DateTime? selectedDate;
  String selectedOption = 'Select';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Scaffold(
          backgroundColor: const Color(0xFFE9EEF3),
          body: SingleChildScrollView(
            child: isMobile
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top bar (mobile)
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
                            margin: const EdgeInsets.only(bottom: 18),
                            child: const Row(
                              children: [Spacer(), UserProfileBar()],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 8.0,
                          ),
                          child: const Text(
                            'Reports',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B5E1C),
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Top row: SELECT BRANCH, CALENDAR
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              StyledDropdown<String>(
                                value: selectedBranch,
                                items: branches,
                                onChanged: (v) =>
                                    setState(() => selectedBranch = v!),
                              ),
                              const SizedBox(height: 12),
                              _buildCalendarPicker(context),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Type selection and summary
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              // Type toggle buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
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
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: SizedBox(
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
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Summary container
                              SizedBox(
                                width: double.infinity,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ReportsSummaryRow(
                                        label: 'SELECTED BRANCH',
                                        value: selectedBranch == 'Select Branch'
                                            ? '-'
                                            : selectedBranch
                                                  .split('-')
                                                  .last
                                                  .trim(),
                                      ),
                                      const SizedBox(height: 8),
                                      ReportsSummaryRow(
                                        label: 'SELECTED DATE',
                                        value: selectedDate == null
                                            ? '-'
                                            : DateFormat(
                                                'MMMM d, yyyy',
                                              ).format(selectedDate!),
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
                        ),
                        const SizedBox(height: 32),
                        // Download button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFF0B5E1C,
                                ).withOpacity(0.5),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () =>
                                  _showDownloadProgressDialog(context),
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
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top bar (desktop/tablet)
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
                          child: const Row(
                            children: [Spacer(), UserProfileBar()],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 8.0,
                          ),
                          child: const Text(
                            'Reports',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B5E1C),
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Top row: SELECT BRANCH, CALENDAR
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: StyledDropdown<String>(
                                  value: selectedBranch,
                                  items: branches,
                                  onChanged: (v) =>
                                      setState(() => selectedBranch = v!),
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                flex: 3,
                                child: _buildCalendarPicker(context),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Type selection and summary
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Type toggle buttons
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
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
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: SizedBox(
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
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              // Summary container
                              Expanded(
                                flex: 3,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ReportsSummaryRow(
                                        label: 'SELECTED BRANCH',
                                        value: selectedBranch == 'Select Branch'
                                            ? '-'
                                            : selectedBranch
                                                  .split('-')
                                                  .last
                                                  .trim(),
                                      ),
                                      const SizedBox(height: 8),
                                      ReportsSummaryRow(
                                        label: 'SELECTED DATE',
                                        value: selectedDate == null
                                            ? '-'
                                            : DateFormat(
                                                'MMMM d, yyyy',
                                              ).format(selectedDate!),
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
                        ),
                        const SizedBox(height: 32),
                        // Download button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFF0B5E1C,
                                ).withOpacity(0.5),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () =>
                                  _showDownloadProgressDialog(context),
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

  Widget _buildCalendarPicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? now,
          firstDate: DateTime(2020),
          lastDate: DateTime(now.year + 2),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF0B5E1C), // header background color
                  onPrimary: Colors.white, // header text color
                  onSurface: Color(0xFF0B5E1C), // body text color
                  secondary: Color(0xFFB2E5B2), // accent color
                ),
                dialogBackgroundColor: Color(0xFFE9EEF3),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xFF0B5E1C),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                dialogTheme: DialogThemeData(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          setState(() => selectedDate = picked);
        }
      },
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFF0B5E1C)),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: const Color(0xFF0B5E1C)),
            const SizedBox(width: 12),
            Text(
              selectedDate == null
                  ? 'Select Date'
                  : DateFormat('MMMM d, yyyy').format(selectedDate!),
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF0B5E1C),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDownloadProgressDialog(BuildContext context) async {
    double progress = 0.0;
    late StateSetter setStateDialog;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            setStateDialog = setState;
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Downloading file...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: LinearProgressIndicator(
                      value: progress,
                      color: const Color(0xFF0B5E1C),
                      backgroundColor: const Color(0xFFB2E5B2),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    // Animate progress
    const int totalMillis = 2000;
    const int interval = 20;
    int elapsed = 0;
    while (elapsed < totalMillis) {
      await Future.delayed(const Duration(milliseconds: interval));
      elapsed += interval;
      progress = elapsed / totalMillis;
      if (progress > 1.0) progress = 1.0;
      setStateDialog(() {});
    }
    Navigator.of(context).pop(); // Close progress dialog
    _showDownloadSuccessDialog(context);
  }

  void _showDownloadSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF0B5E1C), size: 48),
            const SizedBox(height: 16),
            const Text(
              'Downloaded successfully!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
              style: TextStyle(
                color: Color(0xFF0B5E1C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
