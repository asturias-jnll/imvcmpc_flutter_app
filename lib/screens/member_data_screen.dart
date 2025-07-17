import 'package:flutter/material.dart';
import '../widgets/user_profile_bar.dart';
import '../widgets/filter_button.dart';
import '../widgets/mobile_member_list.dart';
import '../widgets/desktop_member_table.dart';
import '../widgets/member_form_dialog.dart';
import '../widgets/delete_confirmation_dialog.dart';

class MemberDataScreen extends StatefulWidget {
  const MemberDataScreen({super.key});
  @override
  State<MemberDataScreen> createState() => _MemberDataScreenState();
}

class _MemberDataScreenState extends State<MemberDataScreen> {
  List<Map<String, dynamic>> allContributors = [
    // Branch 1: IBAAN
    {
      'avatar': null,
      'name': 'Rita Helera',
      'branch': 'IMVCMPC - BRANCH 1',
      'location': 'IBAAN',
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
      'name': 'Alvin Aquino',
      'branch': 'IMVCMPC - BRANCH 1',
      'location': 'IBAAN',
      'savings': 50000.0,
      'disbursement': 40000.0,
    },
    {
      'avatar': null,
      'name': 'Mia Santos',
      'branch': 'IMVCMPC - BRANCH 1',
      'location': 'IBAAN',
      'savings': 21000.0,
      'disbursement': 12000.0,
    },
    // Branch 2: BAUAN
    {
      'avatar': null,
      'name': 'Liza Dela Cruz',
      'branch': 'IMVCMPC - BRANCH 2',
      'location': 'BAUAN',
      'savings': 37000.0,
      'disbursement': 25000.0,
    },
    {
      'avatar': null,
      'name': 'Carlos Mendoza',
      'branch': 'IMVCMPC - BRANCH 2',
      'location': 'BAUAN',
      'savings': 18000.0,
      'disbursement': 8000.0,
    },
    {
      'avatar': null,
      'name': 'Anna Lim',
      'branch': 'IMVCMPC - BRANCH 2',
      'location': 'BAUAN',
      'savings': 29000.0,
      'disbursement': 15000.0,
    },
    {
      'avatar': null,
      'name': 'Rico Tan',
      'branch': 'IMVCMPC - BRANCH 2',
      'location': 'BAUAN',
      'savings': 32000.0,
      'disbursement': 21000.0,
    },
    // Branch 3: SAN JOSE
    {
      'avatar': null,
      'name': 'Grace Uy',
      'branch': 'IMVCMPC - BRANCH 3',
      'location': 'SAN JOSE',
      'savings': 41000.0,
      'disbursement': 39000.0,
    },
    {
      'avatar': null,
      'name': 'Benjie Ramos',
      'branch': 'IMVCMPC - BRANCH 3',
      'location': 'SAN JOSE',
      'savings': 27000.0,
      'disbursement': 17000.0,
    },
    {
      'avatar': null,
      'name': 'Cathy Chua',
      'branch': 'IMVCMPC - BRANCH 3',
      'location': 'SAN JOSE',
      'savings': 35000.0,
      'disbursement': 25000.0,
    },
    {
      'avatar': null,
      'name': 'Dino Cruz',
      'branch': 'IMVCMPC - BRANCH 3',
      'location': 'SAN JOSE',
      'savings': 22000.0,
      'disbursement': 12000.0,
    },
    // Branch 4: ROSARIO
    {
      'avatar': null,
      'name': 'Ella Villanueva',
      'branch': 'IMVCMPC - BRANCH 4',
      'location': 'ROSARIO',
      'savings': 26000.0,
      'disbursement': 16000.0,
    },
    {
      'avatar': null,
      'name': 'Francis Go',
      'branch': 'IMVCMPC - BRANCH 4',
      'location': 'ROSARIO',
      'savings': 33000.0,
      'disbursement': 23000.0,
    },
    {
      'avatar': null,
      'name': 'Gina Sy',
      'branch': 'IMVCMPC - BRANCH 4',
      'location': 'ROSARIO',
      'savings': 28000.0,
      'disbursement': 18000.0,
    },
    {
      'avatar': null,
      'name': 'Henry Lee',
      'branch': 'IMVCMPC - BRANCH 4',
      'location': 'ROSARIO',
      'savings': 39000.0,
      'disbursement': 29000.0,
    },
    // Branch 5: SAN JUAN
    {
      'avatar': null,
      'name': 'Ivy Santos',
      'branch': 'IMVCMPC - BRANCH 5',
      'location': 'SAN JUAN',
      'savings': 25000.0,
      'disbursement': 15000.0,
    },
    {
      'avatar': null,
      'name': 'Jake Dizon',
      'branch': 'IMVCMPC - BRANCH 5',
      'location': 'SAN JUAN',
      'savings': 34000.0,
      'disbursement': 24000.0,
    },
    {
      'avatar': null,
      'name': 'Karen Lim',
      'branch': 'IMVCMPC - BRANCH 5',
      'location': 'SAN JUAN',
      'savings': 31000.0,
      'disbursement': 21000.0,
    },
    {
      'avatar': null,
      'name': 'Leo Cruz',
      'branch': 'IMVCMPC - BRANCH 5',
      'location': 'SAN JUAN',
      'savings': 20000.0,
      'disbursement': 10000.0,
    },
    // Branch 6: PADRE GARCIA
    {
      'avatar': null,
      'name': 'Mona Reyes',
      'branch': 'IMVCMPC - BRANCH 6',
      'location': 'PADRE GARCIA',
      'savings': 42000.0,
      'disbursement': 32000.0,
    },
    {
      'avatar': null,
      'name': 'Nico dela Cruz',
      'branch': 'IMVCMPC - BRANCH 6',
      'location': 'PADRE GARCIA',
      'savings': 37000.0,
      'disbursement': 27000.0,
    },
    {
      'avatar': null,
      'name': 'Olive Tan',
      'branch': 'IMVCMPC - BRANCH 6',
      'location': 'PADRE GARCIA',
      'savings': 39000.0,
      'disbursement': 29000.0,
    },
    {
      'avatar': null,
      'name': 'Paul Sy',
      'branch': 'IMVCMPC - BRANCH 6',
      'location': 'PADRE GARCIA',
      'savings': 31000.0,
      'disbursement': 21000.0,
    },
    // Branch 7: LIPA CITY
    {
      'avatar': null,
      'name': 'Josie Calmarez',
      'branch': 'IMVCMPC - BRANCH 7',
      'location': 'LIPA CITY',
      'savings': 25000.0,
      'disbursement': 34000.0,
    },
    {
      'avatar': null,
      'name': 'Quinn Garcia',
      'branch': 'IMVCMPC - BRANCH 7',
      'location': 'LIPA CITY',
      'savings': 36000.0,
      'disbursement': 26000.0,
    },
    {
      'avatar': null,
      'name': 'Rhea Lim',
      'branch': 'IMVCMPC - BRANCH 7',
      'location': 'LIPA CITY',
      'savings': 28000.0,
      'disbursement': 18000.0,
    },
    {
      'avatar': null,
      'name': 'Sam Cruz',
      'branch': 'IMVCMPC - BRANCH 7',
      'location': 'LIPA CITY',
      'savings': 32000.0,
      'disbursement': 22000.0,
    },
    // Branch 8: BATANGAS CITY
    {
      'avatar': null,
      'name': 'Tina Uy',
      'branch': 'IMVCMPC - BRANCH 8',
      'location': 'BATANGAS CITY',
      'savings': 27000.0,
      'disbursement': 17000.0,
    },
    {
      'avatar': null,
      'name': 'Ulysses Go',
      'branch': 'IMVCMPC - BRANCH 8',
      'location': 'BATANGAS CITY',
      'savings': 35000.0,
      'disbursement': 25000.0,
    },
    {
      'avatar': null,
      'name': 'Vera Sy',
      'branch': 'IMVCMPC - BRANCH 8',
      'location': 'BATANGAS CITY',
      'savings': 30000.0,
      'disbursement': 20000.0,
    },
    {
      'avatar': null,
      'name': 'Wendy Lee',
      'branch': 'IMVCMPC - BRANCH 8',
      'location': 'BATANGAS CITY',
      'savings': 26000.0,
      'disbursement': 16000.0,
    },
    // Branch 9: MABINI LIPA
    {
      'avatar': null,
      'name': 'Xander Cruz',
      'branch': 'IMVCMPC - BRANCH 9',
      'location': 'MABINI LIPA',
      'savings': 33000.0,
      'disbursement': 23000.0,
    },
    {
      'avatar': null,
      'name': 'Yana Lim',
      'branch': 'IMVCMPC - BRANCH 9',
      'location': 'MABINI LIPA',
      'savings': 29000.0,
      'disbursement': 19000.0,
    },
    {
      'avatar': null,
      'name': 'Zack Tan',
      'branch': 'IMVCMPC - BRANCH 9',
      'location': 'MABINI LIPA',
      'savings': 31000.0,
      'disbursement': 21000.0,
    },
    {
      'avatar': null,
      'name': 'Ariel Sy',
      'branch': 'IMVCMPC - BRANCH 9',
      'location': 'MABINI LIPA',
      'savings': 27000.0,
      'disbursement': 17000.0,
    },
    // Branch 10: CALAMIAS
    {
      'avatar': null,
      'name': 'Bella Cruz',
      'branch': 'IMVCMPC - BRANCH 10',
      'location': 'CALAMIAS',
      'savings': 35000.0,
      'disbursement': 25000.0,
    },
    {
      'avatar': null,
      'name': 'Cesar Lim',
      'branch': 'IMVCMPC - BRANCH 10',
      'location': 'CALAMIAS',
      'savings': 32000.0,
      'disbursement': 22000.0,
    },
    {
      'avatar': null,
      'name': 'Daisy Go',
      'branch': 'IMVCMPC - BRANCH 10',
      'location': 'CALAMIAS',
      'savings': 28000.0,
      'disbursement': 18000.0,
    },
    {
      'avatar': null,
      'name': 'Evan Lee',
      'branch': 'IMVCMPC - BRANCH 10',
      'location': 'CALAMIAS',
      'savings': 26000.0,
      'disbursement': 16000.0,
    },
    // Branch 11: LEMERY
    {
      'avatar': null,
      'name': 'Faye Sy',
      'branch': 'IMVCMPC - BRANCH 11',
      'location': 'LEMERY',
      'savings': 31000.0,
      'disbursement': 21000.0,
    },
    {
      'avatar': null,
      'name': 'Gino Tan',
      'branch': 'IMVCMPC - BRANCH 11',
      'location': 'LEMERY',
      'savings': 27000.0,
      'disbursement': 17000.0,
    },
    {
      'avatar': null,
      'name': 'Hannah Cruz',
      'branch': 'IMVCMPC - BRANCH 11',
      'location': 'LEMERY',
      'savings': 35000.0,
      'disbursement': 25000.0,
    },
    {
      'avatar': null,
      'name': 'Ivan Lim',
      'branch': 'IMVCMPC - BRANCH 11',
      'location': 'LEMERY',
      'savings': 29000.0,
      'disbursement': 19000.0,
    },
    // Branch 12: MATAAS NA KAHOY
    {
      'avatar': null,
      'name': 'Jade Go',
      'branch': 'IMVCMPC - BRANCH 12',
      'location': 'MATAAS NA KAHOY',
      'savings': 33000.0,
      'disbursement': 23000.0,
    },
    {
      'avatar': null,
      'name': 'Kurt Sy',
      'branch': 'IMVCMPC - BRANCH 12',
      'location': 'MATAAS NA KAHOY',
      'savings': 31000.0,
      'disbursement': 21000.0,
    },
    {
      'avatar': null,
      'name': 'Lara Lee',
      'branch': 'IMVCMPC - BRANCH 12',
      'location': 'MATAAS NA KAHOY',
      'savings': 27000.0,
      'disbursement': 17000.0,
    },
    {
      'avatar': null,
      'name': 'Mitch Cruz',
      'branch': 'IMVCMPC - BRANCH 12',
      'location': 'MATAAS NA KAHOY',
      'savings': 35000.0,
      'disbursement': 25000.0,
    },
  ];

  String? selectedBranch;
  String sortBy = 'Total';
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  List<String> get branchOptions {
    // Always return: All Branches, IMVCMPC - BRANCH 1, ..., IMVCMPC - BRANCH 12
    List<String> branches = List.generate(
      12,
      (i) => 'IMVCMPC - BRANCH ${i + 1}', // Fixed: only one space
    );
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

  void _showMemberDialog({Map<String, dynamic>? member, int? index}) async {
    final isEdit = member != null && index != null;
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => MemberFormDialog(isEdit: isEdit, member: member),
    );
    if (result != null) {
      setState(() {
        if (isEdit) {
          allContributors[index!] = result;
          _showSuccessDialog('Updated successfully!');
        } else {
          allContributors.add(result);
          _showSuccessDialog('Added successfully!');
        }
      });
    }
  }

  void _confirmDeleteMember(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const DeleteConfirmationDialog(),
    );
    if (confirmed == true) {
      setState(() {
        allContributors.removeAt(index);
      });
      _showSuccessDialog('Deleted successfully!');
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFE9EEF3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        content: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF0B5E1C),
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
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

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      backgroundColor: const Color(0xFFE9EEF3),
      body: Stack(
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
                        child: Row(
                          children: [const Spacer(), const UserProfileBar()],
                        ),
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
                                onChanged: (val) =>
                                    setState(() => sortBy = val!),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0B5E1C),
        foregroundColor: Colors.white,
        onPressed: () => _showMemberDialog(),
        child: const Icon(Icons.add),
        tooltip: 'Add Member',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
