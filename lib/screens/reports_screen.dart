import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/user_profile_bar.dart';
import '../widgets/styled_dropdown.dart';
import '../widgets/reports_summary_row.dart';
import '../widgets/type_toggle_button.dart';
import 'dart:math';
import '../member_data.dart';

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
  final months = [
    'Select Month',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final years = [
    'Select Year',
    ...List.generate(10, (i) => (DateTime.now().year - i).toString()),
  ];

  String selectedBranch = 'Select Branch';
  String selectedType = 'Select Type';
  DateTime? selectedDate;
  String selectedOption = 'Member'; // Default to Member
  String selectedMonth = 'Select Month';
  String selectedYear = 'Select Year';
  TextEditingController searchMemberController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Map<String, dynamic>? selectedMember;

  // Add a helper to get branch location from branch name
  String? getBranchLocation(String branch) {
    final branchMap = {
      'Branch 1 - IBAAN': 'IBAAN',
      'Branch 2 - BAUAN': 'BAUAN',
      'Branch 3 - SAN JOSE': 'SAN JOSE',
      'Branch 4 - ROSARIO': 'ROSARIO',
      'Branch 5 - SAN JUAN': 'SAN JUAN',
      'Branch 6 - PADRE GARCIA': 'PADRE GARCIA',
      'Branch 7 - LIPA CITY': 'LIPA CITY',
      'Branch 8 - BATANGAS CITY': 'BATANGAS CITY',
      'Branch 9 - MABINI LIPA': 'MABINI LIPA',
      'Branch 10 - CALAMIAS': 'CALAMIAS',
      'Branch 11 - LEMERY': 'LEMERY',
      'Branch 12 - MATAAS NA KAHOY': 'MATAAS NA KAHOY',
    };
    return branchMap[branch];
  }

  // Add a function to generate a random amount for the branch report
  double getRandomAmount(String type) {
    final rand = Random();
    if (type == 'SAVINGS') {
      return 20000 + rand.nextInt(30000) + rand.nextDouble(); // 20k-50k
    } else {
      return 10000 + rand.nextInt(20000) + rand.nextDouble(); // 10k-30k
    }
  }

  double? branchAmount;

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
                        // Member/Branch toggle (mobile)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6FBF6),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: const Color(0xFF0B5E1C),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(
                                      () => selectedOption = 'Member',
                                    ),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selectedOption == 'Member'
                                            ? const Color(0xFF0B5E1C)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: selectedOption == 'Member'
                                                ? Colors.white
                                                : const Color(0xFF0B5E1C),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Member',
                                            style: TextStyle(
                                              color: selectedOption == 'Member'
                                                  ? Colors.white
                                                  : const Color(0xFF0B5E1C),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(
                                      () => selectedOption = 'Branch',
                                    ),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selectedOption == 'Branch'
                                            ? const Color(0xFFB8D53D)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.store,
                                            color: selectedOption == 'Branch'
                                                ? Colors.white
                                                : const Color(0xFFB8D53D),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Branch',
                                            style: TextStyle(
                                              color: selectedOption == 'Branch'
                                                  ? Colors.white
                                                  : const Color(0xFFB8D53D),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: const Text(
                            'Use the filters to search for specific members, select branches, and customize your report by date, month, or year.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF616161), // a bit grey
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Filters and summary for Member/Branch
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              if (selectedOption == 'Member') ...[
                                // Member autocomplete
                                Autocomplete<String>(
                                  optionsBuilder:
                                      (TextEditingValue textEditingValue) {
                                        if (textEditingValue.text == '') {
                                          return const Iterable<String>.empty();
                                        }
                                        return allContributors
                                            .map((m) => m['name'] as String)
                                            .where(
                                              (name) =>
                                                  name.toLowerCase().contains(
                                                    textEditingValue.text
                                                        .toLowerCase(),
                                                  ),
                                            );
                                      },
                                  onSelected: (String selection) {
                                    setState(() {
                                      selectedMember = allContributors
                                          .firstWhere(
                                            (m) => m['name'] == selection,
                                          );
                                    });
                                  },
                                  fieldViewBuilder:
                                      (
                                        context,
                                        controller,
                                        focusNode,
                                        onEditingComplete,
                                      ) {
                                        return TextField(
                                          controller: controller,
                                          focusNode: focusNode,
                                          decoration: InputDecoration(
                                            hintText: 'Search member...',
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Color(0xFF0B5E1C),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  vertical: 16,
                                                  horizontal: 20,
                                                ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              borderSide: BorderSide(
                                                color: Color(0xFF0B5E1C),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              borderSide: BorderSide(
                                                color: Color(0xFF0B5E1C),
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              borderSide: BorderSide(
                                                color: Color(0xFFB8D53D),
                                                width: 2.5,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFE9F7EF),
                                          ),
                                          style: TextStyle(fontSize: 16),
                                        );
                                      },
                                  optionsViewBuilder:
                                      (context, onSelected, options) {
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: Material(
                                            elevation: 4,
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxHeight: 200,
                                                minWidth: 300,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.08),
                                                    blurRadius: 8,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: ListView.builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                itemCount: options.length,
                                                itemBuilder: (context, index) {
                                                  final option = options
                                                      .elementAt(index);
                                                  return InkWell(
                                                    onTap: () =>
                                                        onSelected(option),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          18,
                                                        ),
                                                    hoverColor: Color(
                                                      0xFFB8D53D,
                                                    ),
                                                    focusColor: Color(
                                                      0xFFB8D53D,
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 14,
                                                            horizontal: 20,
                                                          ),
                                                      child: Text(
                                                        option,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                ),
                                const SizedBox(height: 12),
                              ],
                              if (selectedOption == 'Branch') ...[
                                // Branch, Month, Year dropdowns
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 320,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xFF0D5B11),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 4,
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: selectedBranch,
                                              isExpanded: true,
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Color(0xFF0D5B11),
                                              ),
                                              dropdownColor: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              menuMaxHeight: 260,
                                              onChanged: (v) {
                                                setState(() {
                                                  selectedBranch = v!;
                                                  branchAmount =
                                                      getRandomAmount(
                                                        selectedType,
                                                      );
                                                });
                                              },
                                              items: branches.map((item) {
                                                return DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 1,
                                      child: DropdownButtonFormField<String>(
                                        value: selectedMonth,
                                        decoration: InputDecoration(
                                          labelText: 'Month',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xFF0D5B11),
                                              width: 2,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xFF0D5B11),
                                              width: 2,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xFFB8D53D),
                                              width: 2.5,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFE9F7EF),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                        ),
                                        isExpanded: true,
                                        dropdownColor: Colors.white,
                                        borderRadius: BorderRadius.circular(24),
                                        menuMaxHeight: 260,
                                        items: months.map((month) {
                                          return DropdownMenuItem<String>(
                                            value: month,
                                            child: Text(
                                              month,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (v) {
                                          setState(() {
                                            selectedMonth = v!;
                                            branchAmount = getRandomAmount(
                                              selectedType,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 1,
                                      child: DropdownButtonFormField<String>(
                                        value: selectedYear,
                                        decoration: InputDecoration(
                                          labelText: 'Year',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xFF0D5B11),
                                              width: 2,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xFF0D5B11),
                                              width: 2,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xFFB8D53D),
                                              width: 2.5,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFE9F7EF),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                        ),
                                        isExpanded: true,
                                        dropdownColor: Colors.white,
                                        borderRadius: BorderRadius.circular(24),
                                        menuMaxHeight: 260,
                                        items: years.map((year) {
                                          return DropdownMenuItem<String>(
                                            value: year,
                                            child: Text(
                                              year,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (v) {
                                          setState(() {
                                            selectedYear = v!;
                                            branchAmount = getRandomAmount(
                                              selectedType,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                              ],
                              // Date picker button (for both modes)
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF0B5E1C),
                                    side: const BorderSide(
                                      color: Color(0xFF0B5E1C),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                  ),
                                  icon: const Icon(Icons.calendar_today),
                                  label: Text(
                                    selectedDate == null
                                        ? 'Select Date'
                                        : DateFormat(
                                            'MMMM d, yyyy',
                                          ).format(selectedDate!),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  onPressed: () async {
                                    final now = DateTime.now();
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate ?? now,
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(now.year + 2),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: const Color(0xFF0B5E1C),
                                              onPrimary: Colors.white,
                                              surface: const Color(0xFFFFF9E5),
                                              onSurface: const Color(
                                                0xFF0D5B11,
                                              ),
                                              secondary: const Color(
                                                0xFF8DC71E,
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
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Type toggle buttons (for both modes)
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => setState(
                                        () => selectedType = 'SAVINGS',
                                      ),
                                      child: Container(
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: selectedType == 'SAVINGS'
                                              ? Color(0xFF0D5B11)
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                          border: Border.all(
                                            color: Color(0xFF0D5B11),
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.savings,
                                              color: selectedType == 'SAVINGS'
                                                  ? Colors.white
                                                  : Color(0xFF0D5B11),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              'SAVINGS',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: selectedType == 'SAVINGS'
                                                    ? Colors.white
                                                    : Color(0xFF0D5B11),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => setState(
                                        () => selectedType = 'DISBURSEMENT',
                                      ),
                                      child: Container(
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: selectedType == 'DISBURSEMENT'
                                              ? Color(0xFFB8D53D)
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                          border: Border.all(
                                            color: Color(0xFFB8D53D),
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.payments,
                                              color:
                                                  selectedType == 'DISBURSEMENT'
                                                  ? Colors.white
                                                  : Color(0xFFB8D53D),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              'DISBURSEMENT',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    selectedType ==
                                                        'DISBURSEMENT'
                                                    ? Colors.white
                                                    : Color(0xFFB8D53D),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Summary section
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF0B5E1C)),
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                child: selectedOption == 'Member'
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'MEMBER REPORT',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Color(0xFF0B5E1C),
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                              SizedBox(width: 12),
                                              Expanded(
                                                child: Divider(
                                                  color: Color(0xFFB8D53D),
                                                  thickness: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18),
                                          _SummaryRow(
                                            icon: Icons.calendar_today,
                                            label: 'Date',
                                            value: selectedDate == null
                                                ? '-'
                                                : DateFormat(
                                                    'MMMM d, yyyy',
                                                  ).format(selectedDate!),
                                            iconBg: Color(0xFFB8D53D),
                                          ),
                                          _SummaryRow(
                                            icon: Icons.person,
                                            label: 'Name',
                                            value: selectedMember != null
                                                ? selectedMember!['name']
                                                : '-',
                                            iconBg: Color(0xFF0B5E1C),
                                          ),
                                          _SummaryRow(
                                            icon: Icons.location_on,
                                            label: 'Branch',
                                            value: selectedMember != null
                                                ? '${selectedMember!['branch']} (${selectedMember!['location']})'
                                                : '-',
                                            iconBg: Color(0xFF0B5E1C),
                                          ),
                                          _SummaryRow(
                                            icon: Icons.account_balance_wallet,
                                            label: selectedType == 'SAVINGS'
                                                ? 'Savings'
                                                : 'Disbursement',
                                            value: selectedMember != null
                                                ? '₱' +
                                                      (selectedType == 'SAVINGS'
                                                          ? selectedMember!['savings']
                                                                .toString()
                                                          : selectedMember!['disbursement']
                                                                .toString())
                                                : '-',
                                            iconBg: Color(0xFF0B5E1C),
                                            highlight: true,
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'BRANCH REPORT',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Color(0xFF0B5E1C),
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                              SizedBox(width: 12),
                                              Expanded(
                                                child: Divider(
                                                  color: Color(0xFFB8D53D),
                                                  thickness: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 18),
                                          _SummaryRow(
                                            icon: Icons.calendar_today,
                                            label: 'Date',
                                            value: selectedDate == null
                                                ? '-'
                                                : DateFormat(
                                                    'MMMM d, yyyy',
                                                  ).format(selectedDate!),
                                            iconBg: Color(0xFFB8D53D),
                                          ),
                                          _SummaryRow(
                                            icon: Icons.location_city,
                                            label: 'Branch',
                                            value:
                                                selectedBranch ==
                                                    'Select Branch'
                                                ? '-'
                                                : selectedBranch,
                                            iconBg: Color(0xFF0B5E1C),
                                          ),
                                          _SummaryRow(
                                            icon: Icons.calendar_month,
                                            label: 'Month',
                                            value:
                                                selectedMonth == 'Select Month'
                                                ? '-'
                                                : selectedMonth,
                                            iconBg: Color(0xFFB8D53D),
                                          ),
                                          _SummaryRow(
                                            icon: Icons.event,
                                            label: 'Year',
                                            value: selectedYear == 'Select Year'
                                                ? '-'
                                                : selectedYear,
                                            iconBg: Color(0xFFB8D53D),
                                          ),
                                          _SummaryRow(
                                            icon: Icons.account_balance_wallet,
                                            label: selectedType == 'SAVINGS'
                                                ? 'Savings'
                                                : 'Disbursement',
                                            value: branchAmount != null
                                                ? '₱' +
                                                      branchAmount!
                                                          .toStringAsFixed(2)
                                                : '-',
                                            iconBg: Color(0xFF0B5E1C),
                                            highlight: true,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.download,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'DOWNLOAD REPORT AS PDF',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D5B11),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 2,
                                shadowColor: const Color(
                                  0xFFB2E5B2,
                                ).withOpacity(0.18),
                              ),
                              onPressed: () =>
                                  _showDownloadProgressDialog(context),
                            ),
                          ),
                        ),
                        // MOBILE VIEW: Place below the download button
                        if (isMobile) ...[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                            child: SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                icon: Icon(
                                  Icons.clear,
                                  color: Color(0xFF0B5E1C),
                                  size: 20,
                                ),
                                label: Text(
                                  'CLEAR',
                                  style: TextStyle(
                                    color: Color(0xFF0B5E1C),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                style:
                                    OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Color(0xFF0B5E1C),
                                        width: 1.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      backgroundColor: Colors.white,
                                    ).copyWith(
                                      overlayColor:
                                          MaterialStateProperty.resolveWith<
                                            Color?
                                          >((Set<MaterialState> states) {
                                            if (states.contains(
                                                  MaterialState.pressed,
                                                ) ||
                                                states.contains(
                                                  MaterialState.hovered,
                                                )) {
                                              return Color(
                                                0xFFB8D53D,
                                              ).withOpacity(0.10);
                                            }
                                            return null;
                                          }),
                                    ),
                                onPressed: _clearFilters,
                              ),
                            ),
                          ),
                        ],
                        // DESKTOP/TABLET VIEW: Place below the report card, left-aligned, compact
                        if (!isMobile) ...[
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: OutlinedButton.icon(
                              icon: Icon(
                                Icons.clear,
                                color: Color(0xFF0B5E1C),
                                size: 18,
                              ),
                              label: Text(
                                'CLEAR',
                                style: TextStyle(
                                  color: Color(0xFF0B5E1C),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              style:
                                  OutlinedButton.styleFrom(
                                    minimumSize: Size(90, 32),
                                    side: BorderSide(
                                      color: Color(0xFF0B5E1C),
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 16,
                                    ),
                                    backgroundColor: Colors.white,
                                    textStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ).copyWith(
                                    overlayColor:
                                        MaterialStateProperty.resolveWith<
                                          Color?
                                        >((Set<MaterialState> states) {
                                          if (states.contains(
                                                MaterialState.pressed,
                                              ) ||
                                              states.contains(
                                                MaterialState.hovered,
                                              )) {
                                            return Color(
                                              0xFFB8D53D,
                                            ).withOpacity(0.10);
                                          }
                                          return null;
                                        }),
                                  ),
                              onPressed: _clearFilters,
                            ),
                          ),
                        ],
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
                          child: Row(
                            children: [
                              // Member/Branch toggle
                              Container(
                                margin: const EdgeInsets.only(right: 32),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF6FBF6),
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                    color: const Color(0xFF0B5E1C),
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => setState(
                                        () => selectedOption = 'Member',
                                      ),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 18,
                                        ),
                                        decoration: BoxDecoration(
                                          color: selectedOption == 'Member'
                                              ? const Color(0xFF0B5E1C)
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            32,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: selectedOption == 'Member'
                                                  ? Colors.white
                                                  : const Color(0xFF0B5E1C),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Member',
                                              style: TextStyle(
                                                color:
                                                    selectedOption == 'Member'
                                                    ? Colors.white
                                                    : const Color(0xFF0B5E1C),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => setState(
                                        () => selectedOption = 'Branch',
                                      ),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 18,
                                        ),
                                        decoration: BoxDecoration(
                                          color: selectedOption == 'Branch'
                                              ? const Color(0xFFB8D53D)
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            32,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.store,
                                              color: selectedOption == 'Branch'
                                                  ? Colors.white
                                                  : const Color(0xFFB8D53D),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Branch',
                                              style: TextStyle(
                                                color:
                                                    selectedOption == 'Branch'
                                                    ? Colors.white
                                                    : const Color(0xFFB8D53D),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              UserProfileBar(),
                            ],
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: const Text(
                            'Use the filters to search for specific members, select branches, and customize your report by date, month, or year.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF616161), // a bit grey
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Desktop/tablet content
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left column: select branch, type toggles, summary
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Autocomplete for Search Member (only for Member selection)
                                    if (selectedOption == 'Member')
                                      Autocomplete<String>(
                                        optionsBuilder:
                                            (
                                              TextEditingValue textEditingValue,
                                            ) {
                                              if (textEditingValue.text == '') {
                                                return const Iterable<
                                                  String
                                                >.empty();
                                              }
                                              return allContributors
                                                  .map(
                                                    (m) => m['name'] as String,
                                                  )
                                                  .where(
                                                    (name) => name
                                                        .toLowerCase()
                                                        .contains(
                                                          textEditingValue.text
                                                              .toLowerCase(),
                                                        ),
                                                  );
                                            },
                                        onSelected: (String selection) {
                                          setState(() {
                                            selectedMember = allContributors
                                                .firstWhere(
                                                  (m) => m['name'] == selection,
                                                );
                                          });
                                        },
                                        fieldViewBuilder:
                                            (
                                              context,
                                              controller,
                                              focusNode,
                                              onEditingComplete,
                                            ) {
                                              return TextField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                decoration: InputDecoration(
                                                  hintText: 'Search member...',
                                                  prefixIcon: Icon(
                                                    Icons.search,
                                                    color: Color(0xFF0B5E1C),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 16,
                                                        horizontal: 20,
                                                      ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          32,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: Color(
                                                        0xFF0B5E1C,
                                                      ), // default border color
                                                      width: 2,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              32,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: Color(
                                                            0xFF0B5E1C,
                                                          ),
                                                          width: 2,
                                                        ),
                                                      ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          32,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: Color(
                                                        0xFFB8D53D,
                                                      ), // THEME GREEN for focus
                                                      width: 2.5,
                                                    ),
                                                  ),
                                                  filled: true,
                                                  fillColor: Color(0xFFE9F7EF),
                                                ),
                                                style: TextStyle(fontSize: 16),
                                              );
                                            },
                                        optionsViewBuilder: (context, onSelected, options) {
                                          return Align(
                                            alignment: Alignment.topLeft,
                                            child: Material(
                                              elevation: 4,
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  maxHeight: 200,
                                                  minWidth: 300,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.08),
                                                      blurRadius: 8,
                                                      offset: Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  itemCount: options.length,
                                                  itemBuilder: (context, index) {
                                                    final option = options
                                                        .elementAt(index);
                                                    return InkWell(
                                                      onTap: () =>
                                                          onSelected(option),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            18,
                                                          ),
                                                      hoverColor: Color(
                                                        0xFFB8D53D,
                                                      ), // Green hover
                                                      focusColor: Color(
                                                        0xFFB8D53D,
                                                      ), // Green focus
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 14,
                                                              horizontal: 20,
                                                            ),
                                                        child: Text(
                                                          option,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    if (selectedOption == 'Member')
                                      const SizedBox(height: 12),
                                    // Branch dropdown (only for Branch selection)
                                    if (selectedOption == 'Branch')
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: 320,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xFF0D5B11),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 4,
                                                ), // Match contentPadding of other dropdowns
                                                child: DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    value: selectedBranch,
                                                    isExpanded: true,
                                                    icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Color(0xFF0D5B11),
                                                    ),
                                                    dropdownColor: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          24,
                                                        ),
                                                    menuMaxHeight: 260,
                                                    onChanged: (v) {
                                                      setState(() {
                                                        selectedBranch = v!;
                                                        branchAmount =
                                                            getRandomAmount(
                                                              selectedType,
                                                            );
                                                      });
                                                    },
                                                    items: branches.map((item) {
                                                      return DropdownMenuItem<
                                                        String
                                                      >(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            flex: 1,
                                            child: DropdownButtonFormField<String>(
                                              value: selectedMonth,
                                              decoration: InputDecoration(
                                                labelText: 'Month',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF0D5B11),
                                                    width: 2,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            24,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                          0xFF0D5B11,
                                                        ),
                                                        width: 2,
                                                      ),
                                                    ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            24,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                          0xFFB8D53D,
                                                        ),
                                                        width: 2.5,
                                                      ),
                                                    ),
                                                filled: true,
                                                fillColor: Color(0xFFE9F7EF),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 14,
                                                    ),
                                              ),
                                              isExpanded: true,
                                              dropdownColor: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              menuMaxHeight: 260,
                                              items: months.map((month) {
                                                return DropdownMenuItem<String>(
                                                  value: month,
                                                  child: Text(
                                                    month,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (v) {
                                                setState(() {
                                                  selectedMonth = v!;
                                                  branchAmount =
                                                      getRandomAmount(
                                                        selectedType,
                                                      );
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            flex: 1,
                                            child: DropdownButtonFormField<String>(
                                              value: selectedYear,
                                              decoration: InputDecoration(
                                                labelText: 'Year',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF0D5B11),
                                                    width: 2,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            24,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                          0xFF0D5B11,
                                                        ),
                                                        width: 2,
                                                      ),
                                                    ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            24,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                          0xFFB8D53D,
                                                        ),
                                                        width: 2.5,
                                                      ),
                                                    ),
                                                filled: true,
                                                fillColor: Color(0xFFE9F7EF),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 14,
                                                    ),
                                              ),
                                              isExpanded: true,
                                              dropdownColor: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              menuMaxHeight: 260,
                                              items: years.map((year) {
                                                return DropdownMenuItem<String>(
                                                  value: year,
                                                  child: Text(
                                                    year,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (v) {
                                                setState(() {
                                                  selectedYear = v!;
                                                  branchAmount =
                                                      getRandomAmount(
                                                        selectedType,
                                                      );
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (selectedOption == 'Branch')
                                      const SizedBox(height: 12),
                                    // Type toggles (enabled for both)
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => setState(
                                              () => selectedType = 'SAVINGS',
                                            ),
                                            child: Container(
                                              height: 44,
                                              decoration: BoxDecoration(
                                                color: selectedType == 'SAVINGS'
                                                    ? Color(0xFF0D5B11)
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                border: Border.all(
                                                  color: Color(0xFF0D5B11),
                                                  width: 2,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.savings,
                                                    color:
                                                        selectedType ==
                                                            'SAVINGS'
                                                        ? Colors.white
                                                        : Color(0xFF0D5B11),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    'SAVINGS',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          selectedType ==
                                                              'SAVINGS'
                                                          ? Colors.white
                                                          : Color(0xFF0D5B11),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => setState(
                                              () =>
                                                  selectedType = 'DISBURSEMENT',
                                            ),
                                            child: Container(
                                              height: 44,
                                              decoration: BoxDecoration(
                                                color:
                                                    selectedType ==
                                                        'DISBURSEMENT'
                                                    ? Color(0xFFB8D53D)
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                border: Border.all(
                                                  color: Color(0xFFB8D53D),
                                                  width: 2,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.payments,
                                                    color:
                                                        selectedType ==
                                                            'DISBURSEMENT'
                                                        ? Colors.white
                                                        : Color(0xFFB8D53D),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    'DISBURSEMENT',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          selectedType ==
                                                              'DISBURSEMENT'
                                                          ? Colors.white
                                                          : Color(0xFFB8D53D),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    // Update the summary section for Member selection
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 18,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFF0B5E1C),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                      ),
                                      child: selectedOption == 'Member'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'MEMBER REPORT',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Color(
                                                          0xFF0B5E1C,
                                                        ),
                                                        letterSpacing: 1.2,
                                                      ),
                                                    ),
                                                    SizedBox(width: 12),
                                                    Expanded(
                                                      child: Divider(
                                                        color: Color(
                                                          0xFFB8D53D,
                                                        ),
                                                        thickness: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 18),
                                                _SummaryRow(
                                                  icon: Icons.calendar_today,
                                                  label: 'Date',
                                                  value: selectedDate == null
                                                      ? '-'
                                                      : DateFormat(
                                                          'MMMM d, yyyy',
                                                        ).format(selectedDate!),
                                                  iconBg: Color(0xFFB8D53D),
                                                ),
                                                _SummaryRow(
                                                  icon: Icons.person,
                                                  label: 'Name',
                                                  value: selectedMember != null
                                                      ? selectedMember!['name']
                                                      : '-',
                                                  iconBg: Color(0xFF0B5E1C),
                                                ),
                                                _SummaryRow(
                                                  icon: Icons.location_on,
                                                  label: 'Branch',
                                                  value: selectedMember != null
                                                      ? '${selectedMember!['branch']} (${selectedMember!['location']})'
                                                      : '-',
                                                  iconBg: Color(0xFF0B5E1C),
                                                ),
                                                _SummaryRow(
                                                  icon: Icons
                                                      .account_balance_wallet,
                                                  label:
                                                      selectedType == 'SAVINGS'
                                                      ? 'Savings'
                                                      : 'Disbursement',
                                                  value: selectedMember != null
                                                      ? '₱' +
                                                            (selectedType ==
                                                                    'SAVINGS'
                                                                ? selectedMember!['savings']
                                                                      .toString()
                                                                : selectedMember!['disbursement']
                                                                      .toString())
                                                      : '-',
                                                  iconBg: Color(0xFF0B5E1C),
                                                  highlight: true,
                                                ),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'BRANCH REPORT',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Color(
                                                          0xFF0B5E1C,
                                                        ),
                                                        letterSpacing: 1.2,
                                                      ),
                                                    ),
                                                    SizedBox(width: 12),
                                                    Expanded(
                                                      child: Divider(
                                                        color: Color(
                                                          0xFFB8D53D,
                                                        ),
                                                        thickness: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 18),
                                                _SummaryRow(
                                                  icon: Icons.calendar_today,
                                                  label: 'Date',
                                                  value: selectedDate == null
                                                      ? '-'
                                                      : DateFormat(
                                                          'MMMM d, yyyy',
                                                        ).format(selectedDate!),
                                                  iconBg: Color(0xFFB8D53D),
                                                ),
                                                _SummaryRow(
                                                  icon: Icons.location_city,
                                                  label: 'Branch',
                                                  value:
                                                      selectedBranch ==
                                                          'Select Branch'
                                                      ? '-'
                                                      : selectedBranch,
                                                  iconBg: Color(0xFF0B5E1C),
                                                ),
                                                _SummaryRow(
                                                  icon: Icons.calendar_month,
                                                  label: 'Month',
                                                  value:
                                                      selectedMonth ==
                                                          'Select Month'
                                                      ? '-'
                                                      : selectedMonth,
                                                  iconBg: Color(0xFFB8D53D),
                                                ),
                                                _SummaryRow(
                                                  icon: Icons.event,
                                                  label: 'Year',
                                                  value:
                                                      selectedYear ==
                                                          'Select Year'
                                                      ? '-'
                                                      : selectedYear,
                                                  iconBg: Color(0xFFB8D53D),
                                                ),
                                                _SummaryRow(
                                                  icon: Icons
                                                      .account_balance_wallet,
                                                  label:
                                                      selectedType == 'SAVINGS'
                                                      ? 'Savings'
                                                      : 'Disbursement',
                                                  value: branchAmount != null
                                                      ? '₱' +
                                                            branchAmount!
                                                                .toStringAsFixed(
                                                                  2,
                                                                )
                                                      : '-',
                                                  iconBg: Color(0xFF0B5E1C),
                                                  highlight: true,
                                                ),
                                              ],
                                            ),
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: OutlinedButton.icon(
                                        icon: Icon(
                                          Icons.clear,
                                          color: Color(0xFF0B5E1C),
                                          size: 18,
                                        ),
                                        label: Text(
                                          'CLEAR',
                                          style: TextStyle(
                                            color: Color(0xFF0B5E1C),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            letterSpacing: 1.1,
                                          ),
                                        ),
                                        style:
                                            OutlinedButton.styleFrom(
                                              minimumSize: Size(90, 32),
                                              side: BorderSide(
                                                color: Color(0xFF0B5E1C),
                                                width: 1.5,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                vertical: 6,
                                                horizontal: 16,
                                              ),
                                              backgroundColor: Colors.white,
                                              textStyle: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ).copyWith(
                                              overlayColor:
                                                  MaterialStateProperty.resolveWith<
                                                    Color?
                                                  >((
                                                    Set<MaterialState> states,
                                                  ) {
                                                    if (states.contains(
                                                          MaterialState.pressed,
                                                        ) ||
                                                        states.contains(
                                                          MaterialState.hovered,
                                                        )) {
                                                      return Color(
                                                        0xFFB8D53D,
                                                      ).withOpacity(0.10);
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                        onPressed: _clearFilters,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              // Calendar on the right, two-tone styled
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // No SizedBox here, calendar is flush to the top
                                  Container(
                                    width: 320,
                                    height: 340,
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFFFFF9E5,
                                      ), // soft yellow
                                      borderRadius: BorderRadius.circular(18),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFFB8D53D,
                                          ).withOpacity(0.18),
                                          blurRadius: 12,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        // Header bar
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: Color(
                                              0xFF0D5B11,
                                            ), // dark green
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(18),
                                              topRight: Radius.circular(18),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              DateFormat('MMMM yyyy').format(
                                                selectedDate ?? DateTime.now(),
                                              ),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: const Color(
                                                  0xFF0B5E1C,
                                                ), // dark green for selected day circle
                                                onPrimary: Colors
                                                    .white, // white number inside the circle
                                                surface: const Color(
                                                  0xFFFFF9E5,
                                                ), // calendar bg
                                                onSurface: const Color(
                                                  0xFF0D5B11,
                                                ), // regular day
                                                secondary: const Color(
                                                  0xFF8DC71E,
                                                ), // today border
                                              ),
                                            ),
                                            child: CalendarDatePicker(
                                              initialDate:
                                                  selectedDate ??
                                                  DateTime.now(),
                                              firstDate: DateTime(2020),
                                              lastDate: DateTime(
                                                DateTime.now().year + 2,
                                              ),
                                              onDateChanged: (picked) {
                                                setState(
                                                  () => selectedDate = picked,
                                                );
                                              },
                                              currentDate: DateTime.now(),
                                              selectableDayPredicate: (date) =>
                                                  true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    width: 320,
                                    child: ElevatedButton.icon(
                                      icon: const Icon(
                                        Icons.download,
                                        color: Colors.white,
                                      ),
                                      label: const Text(
                                        'DOWNLOAD REPORT AS PDF',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF0D5B11,
                                        ),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                          horizontal: 20,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                        ),
                                        elevation: 2,
                                        shadowColor: const Color(
                                          0xFFB2E5B2,
                                        ).withOpacity(0.18),
                                      ),
                                      onPressed: () =>
                                          _showDownloadProgressDialog(context),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
    final now = DateTime.now();
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB2E5B2).withOpacity(0.10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: CalendarDatePicker(
        initialDate: selectedDate ?? now,
        firstDate: DateTime(2020),
        lastDate: DateTime(now.year + 2),
        onDateChanged: (picked) {
          setState(() => selectedDate = picked);
        },
        currentDate: now,
        selectableDayPredicate: (date) => true,
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      selectedType = 'Select Type';
      selectedDate = null;
      searchMemberController.clear();
      amountController.clear();
      selectedMember = null;
      branchAmount = null;
      if (selectedOption == 'Member') {
        // Only clear member-related fields
      } else if (selectedOption == 'Branch') {
        selectedBranch = 'Select Branch';
        selectedMonth = 'Select Month';
        selectedYear = 'Select Year';
      }
    });
  }

  void _showDownloadProgressDialog(BuildContext context) async {
    // Validation before download
    bool valid = true;
    String errorMsg = '';
    if (selectedOption == 'Member') {
      if (selectedMember == null ||
          selectedType == 'Select Type' ||
          selectedDate == null) {
        valid = false;
        errorMsg = 'Please select a member, type, and date before downloading.';
      }
    } else if (selectedOption == 'Branch') {
      if (selectedBranch == 'Select Branch' ||
          selectedType == 'Select Type' ||
          selectedMonth == 'Select Month' ||
          selectedYear == 'Select Year' ||
          selectedDate == null) {
        valid = false;
        errorMsg =
            'Please select a branch, type, month, year, and date before downloading.';
      }
    }
    if (!valid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: Color(0xFFB8D53D),
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                errorMsg,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF0B5E1C),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
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
      return;
    }
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
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Downloading file...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0B5E1C),
                    ),
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
        backgroundColor: const Color(0xFFE9EEF3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0B5E1C), Color(0xFF69B41E)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Icon(Icons.check_circle, color: Colors.white, size: 38),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: const Text(
                'Downloaded successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF0B5E1C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF0B5E1C),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconBg;
  final bool highlight;
  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconBg,
    this.highlight = false,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2), // Less line spacing
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: iconBg.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconBg, size: 18),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 120, // More space for label
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 18), // More space before value
          Expanded(
            child: Container(
              padding: highlight
                  ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
                  : null,
              decoration: highlight
                  ? BoxDecoration(
                      color: iconBg.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    )
                  : null,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
                  color: highlight ? iconBg : Colors.black87,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
