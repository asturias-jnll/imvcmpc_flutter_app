import 'package:flutter/material.dart';
import '../widgets/user_profile_bar.dart';
import '../widgets/filter_button.dart';
import '../widgets/mobile_member_list.dart';
import '../widgets/desktop_member_table.dart';

class MemberDataScreen extends StatefulWidget {
  const MemberDataScreen({super.key});
  @override
  State<MemberDataScreen> createState() => _MemberDataScreenState();
}

class _MemberDataScreenState extends State<MemberDataScreen> {
  List<Map<String, dynamic>> allContributors = [
    {
      'avatar': null,
      'name': 'Rita Helera',
      'branch': 'IMVCMPC - BRANCH 7',
      'location': 'ROSARIO',
      'savings': 34000.0,
      'disbursement': 33000.0,
    },
    {
      'avatar': null,
      'name': 'Jom Cortez',
      'branch': 'IMVCMPC - BRANCH 1',
      'location': 'IBAAN',
      'savings': 40000.0,
      'disbursement': 23000.0,
    },
    {
      'avatar': null,
      'name': 'Josie Calmarez',
      'branch': 'IMVCMPC - BRANCH 9',
      'location': 'CALAMIAS',
      'savings': 25000.0,
      'disbursement': 34000.0,
    },
    {
      'avatar': null,
      'name': 'Alvin Aquino',
      'branch': 'IMVCMPC - BRANCH 1',
      'location': 'IBAAN',
      'savings': 50000.0,
      'disbursement': 40000.0,
    },
  ];

  String? selectedBranch;
  String sortBy = 'Total';
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  List<String> get branchOptions {
    final branches = allContributors
        .map((c) => c['branch'] ?? '')
        .toSet()
        .toList();
    branches.sort();
    return ['All Branches', ...branches];
  }

  List<Map<String, dynamic>> get filteredContributors {
    var list = (selectedBranch == null || selectedBranch == 'All Branches')
        ? allContributors
        : allContributors.where((c) => c['branch'] == selectedBranch).toList();
    if (searchQuery.isNotEmpty) {
      list = list
          .where(
            (c) => c['name'].toString().toLowerCase().contains(
              searchQuery.toLowerCase(),
            ),
          )
          .toList();
    }
    list.sort((a, b) {
      switch (sortBy) {
        case 'Branch':
          return a['branch'].toString().compareTo(b['branch'].toString());
        case 'Savings':
          return (b['savings'] as num).compareTo(a['savings'] as num);
        case 'Disbursement':
          return (b['disbursement'] as num).compareTo(a['disbursement'] as num);
        case 'Total':
        default:
          final at = (a['savings'] as num) - (a['disbursement'] as num);
          final bt = (b['savings'] as num) - (b['disbursement'] as num);
          return bt.compareTo(at);
      }
    });
    return list;
  }

  void _showMemberDialog({Map<String, dynamic>? member, int? index}) {
    // ... (same as before, omitted for brevity)
  }

  void _showSuccessDialog(String message) {
    // ... (same as before, omitted for brevity)
  }

  void _confirmDeleteMember(int index) {
    // ... (same as before, omitted for brevity)
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            if (isMobile) {
              // --- MOBILE LAYOUT ---
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Top Row: Finance Officer Bar on the right in white container
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
                      child: Row(children: [const Spacer(), const UserProfileBar()]),
                    ),
                    const SizedBox(height: 18),
                    // 2. Title
                    const Text(
                      'Member Contributors',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B5E1C),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // 3. Search (full width)
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by name',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF0B5E1C),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF0B5E1C),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF0B5E1C),
                            width: 2.0,
                          ),
                        ),
                      ),
                      cursorColor: Color(0xFF0B5E1C),
                      onChanged: (val) => setState(() => searchQuery = val),
                    ),
                    const SizedBox(height: 10),
                    // 4. Sort and Branch Filter Row
                    Row(
                      children: [
                        // Sort
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0B5E1C),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: sortBy,
                              dropdownColor: const Color(0xFF0B5E1C),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Total',
                                  child: Text('Total'),
                                ),
                                DropdownMenuItem(
                                  value: 'Branch',
                                  child: Text('Branch'),
                                ),
                                DropdownMenuItem(
                                  value: 'Savings',
                                  child: Text('Savings'),
                                ),
                                DropdownMenuItem(
                                  value: 'Disbursement',
                                  child: Text('Disbursement'),
                                ),
                              ],
                              onChanged: (val) => setState(() => sortBy = val!),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Branch Filter
                        Expanded(
                          child: FilterButton(
                            label: selectedBranch ?? 'Filter by branch',
                            options: branchOptions,
                            onSelected: (value) {
                              setState(() {
                                selectedBranch = value;
                              });
                            },
                            noRightMargin: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Green header edge-to-edge with rounded corners
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Color(0x800B5E1C),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'MEMBER CONTRIBUTORS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Member List inside white container (no header)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 0,
                      ),
                      child: MobileMemberList(
                        contributors: filteredContributors,
                        onEdit: (member, idx) =>
                            _showMemberDialog(member: member, index: idx),
                        onDelete: (idx) => _confirmDeleteMember(idx),
                        edgeToEdgeHeader: false,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // --- DESKTOP/TABLET LAYOUT (filter left, profile bar right) ---
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 40,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Top bar: white container with filter (left) and profile bar (right)
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FilterButton(
                            label: selectedBranch ?? 'Filter by branch',
                            options: branchOptions,
                            onSelected: (value) {
                              setState(() {
                                selectedBranch = value;
                              });
                            },
                            noRightMargin: true,
                          ),
                          const Spacer(),
                          const UserProfileBar(),
                        ],
                      ),
                    ),
                    // 2. Title and search/sort row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Title on the left
                        const Text(
                          'Member Contributors',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B5E1C),
                          ),
                        ),
                        const Spacer(),
                        // Search and sort on the right
                        SizedBox(
                          width: 220,
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search by name',
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0B5E1C),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0B5E1C),
                                  width: 2.0,
                                ),
                              ),
                            ),
                            cursorColor: Color(0xFF0B5E1C),
                            style: const TextStyle(fontSize: 16),
                            onChanged: (val) =>
                                setState(() => searchQuery = val),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 48,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF0B5E1C),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: sortBy,
                                dropdownColor: const Color(0xFF0B5E1C),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Total',
                                    child: Text('Total'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Branch',
                                    child: Text('Branch'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Savings',
                                    child: Text('Savings'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Disbursement',
                                    child: Text('Disbursement'),
                                  ),
                                ],
                                onChanged: (val) =>
                                    setState(() => sortBy = val!),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // 3. Member List Table
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 0,
                      ),
                      child: DesktopMemberTable(
                        contributors: filteredContributors,
                        onEdit: (member, idx) =>
                            _showMemberDialog(member: member, index: idx),
                        onDelete: (idx) => _confirmDeleteMember(idx),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        // Floating Action Button for Add
        Positioned(
          bottom: 24,
          right: 24,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF0B5E1C),
            foregroundColor: Colors.white,
            onPressed: () => _showMemberDialog(),
            child: const Icon(Icons.add),
            tooltip: 'Add Member',
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
} 