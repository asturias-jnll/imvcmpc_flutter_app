import 'package:flutter/material.dart';

class MemberFormDialog extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? member;
  const MemberFormDialog({Key? key, required this.isEdit, this.member})
    : super(key: key);

  @override
  State<MemberFormDialog> createState() => _MemberFormDialogState();
}

class _MemberFormDialogState extends State<MemberFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController savingsController;
  late TextEditingController disbursementController;
  late String selectedBranch;
  late String selectedLocation;

  final List<String> branches = [
    'IMVCMPC - BRANCH 1',
    'IMVCMPC - BRANCH 2',
    'IMVCMPC - BRANCH 3',
    'IMVCMPC - BRANCH 4',
    'IMVCMPC - BRANCH 5',
    'IMVCMPC - BRANCH 6',
    'IMVCMPC - BRANCH 7',
    'IMVCMPC - BRANCH 8',
    'IMVCMPC - BRANCH 9',
    'IMVCMPC - BRANCH 10',
    'IMVCMPC - BRANCH 11',
    'IMVCMPC - BRANCH 12',
  ];
  final Map<String, String> branchToLocation = const {
    'IMVCMPC - BRANCH 1': 'IBAAN',
    'IMVCMPC - BRANCH 2': 'BAUAN',
    'IMVCMPC - BRANCH 3': 'SAN JOSE',
    'IMVCMPC - BRANCH 4': 'ROSARIO',
    'IMVCMPC - BRANCH 5': 'SAN JUAN',
    'IMVCMPC - BRANCH 6': 'PADRE GARCIA',
    'IMVCMPC - BRANCH 7': 'LIPA CITY',
    'IMVCMPC - BRANCH 8': 'BATANGAS CITY',
    'IMVCMPC - BRANCH 9': 'MABINI LIPA',
    'IMVCMPC - BRANCH 10': 'CALAMIAS',
    'IMVCMPC - BRANCH 11': 'LEMERY',
    'IMVCMPC - BRANCH 12': 'MATAAS NA KAHOY',
  };

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.member?['name']?.toString() ?? '',
    );
    savingsController = TextEditingController(
      text: widget.member?['savings']?.toString() ?? '',
    );
    disbursementController = TextEditingController(
      text: widget.member?['disbursement']?.toString() ?? '',
    );
    selectedBranch = widget.isEdit
        ? (widget.member?['branch']?.toString() ?? branches[0])
        : branches[0];
    selectedLocation = branchToLocation[selectedBranch]!;
  }

  @override
  void dispose() {
    nameController.dispose();
    savingsController.dispose();
    disbursementController.dispose();
    super.dispose();
  }

  void updateLocation(String branch) {
    setState(() {
      selectedLocation = branchToLocation[branch]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    return AlertDialog(
      backgroundColor: const Color(0xFFE9EEF3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width < 600 ? 320 : 400,
          maxWidth: MediaQuery.of(context).size.width > 900 ? 520 : 400,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
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
                  child: Center(
                    child: Text(
                      widget.isEdit ? 'Update Record' : 'Add Member',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                // Name
                TextFormField(
                  controller: nameController,
                  enabled: !widget.isEdit,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person, color: Color(0xFF0B5E1C)),
                    filled: true,
                    fillColor: widget.isEdit ? Colors.grey[100] : Colors.white,
                    labelStyle: TextStyle(
                      color: widget.isEdit
                          ? Colors.grey
                          : const Color(0xFF0B5E1C),
                      fontStyle: widget.isEdit
                          ? FontStyle.italic
                          : FontStyle.normal,
                      fontWeight: FontWeight.normal,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 22,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xFF0B5E1C)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xFF0B5E1C)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xFF0B5E1C),
                        width: 2.0,
                      ),
                    ),
                  ),
                  cursorColor: const Color(0xFF0B5E1C),
                  style: TextStyle(
                    color: widget.isEdit
                        ? Colors.grey
                        : const Color(0xFF0B5E1C),
                    fontWeight: FontWeight.normal,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Branch Dropdown (add only)
                widget.isEdit
                    ? TextField(
                        enabled: false,
                        controller: TextEditingController(text: selectedBranch),
                        decoration: InputDecoration(
                          labelText: 'Branch',
                          prefixIcon: Icon(
                            Icons.account_tree,
                            color: Color(0xFF0B5E1C),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.normal,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color(0xFF0B5E1C),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color(0xFF0B5E1C),
                              width: 2.0,
                            ),
                          ),
                        ),
                        cursorColor: const Color(0xFF0B5E1C),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : DropdownButtonFormField<String>(
                        value: selectedBranch,
                        isExpanded: true,
                        items: branches
                            .map(
                              (b) => DropdownMenuItem(
                                value: b,
                                child: Text(b, overflow: TextOverflow.ellipsis),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedBranch = val!;
                            updateLocation(selectedBranch);
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Branch',
                          prefixIcon: Icon(
                            Icons.account_tree,
                            color: Color(0xFF0B5E1C),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(color: Color(0xFF0B5E1C)),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 22,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color(0xFF0B5E1C),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color(0xFF0B5E1C),
                              width: 2.0,
                            ),
                          ),
                        ),
                        dropdownColor: Colors.white,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xFF0B5E1C),
                        ),
                        borderRadius: BorderRadius.circular(22),
                        style: const TextStyle(color: Color(0xFF0B5E1C)),
                        menuMaxHeight: 260,
                        // Limit dropdown width for desktop, use full width for mobile
                        alignment: AlignmentDirectional.centerStart,
                        // For Flutter 3.7+, you can use constraints:
                        // constraints: BoxConstraints(maxWidth: 320),
                      ),
                const SizedBox(height: 16),
                // Location (auto, not editable)
                TextField(
                  enabled: false,
                  controller: TextEditingController(text: selectedLocation),
                  decoration: InputDecoration(
                    labelText: 'Location',
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Color(0xFF0B5E1C),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 22,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xFF0B5E1C)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xFF0B5E1C),
                        width: 2.0,
                      ),
                    ),
                  ),
                  cursorColor: const Color(0xFF0B5E1C),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 16),
                // Savings
                TextFormField(
                  controller: savingsController,
                  decoration: InputDecoration(
                    labelText: 'Savings',
                    prefixIcon: Icon(Icons.savings, color: Color(0xFF0B5E1C)),
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: const TextStyle(
                      color: Color(0xFF0B5E1C),
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 22,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xFF0B5E1C)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xFF0B5E1C),
                        width: 2.0,
                      ),
                    ),
                  ),
                  cursorColor: const Color(0xFF0B5E1C),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Color(0xFF0B5E1C),
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Savings is required';
                    }
                    final num? val = num.tryParse(value.trim());
                    if (val == null) {
                      return 'Enter a valid number';
                    }
                    if (val < 0) {
                      return 'Savings cannot be negative';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Disbursement
                TextFormField(
                  controller: disbursementController,
                  decoration: InputDecoration(
                    labelText: 'Disbursement',
                    prefixIcon: Icon(Icons.money_off, color: Color(0xFF0B5E1C)),
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: const TextStyle(
                      color: Color(0xFF0B5E1C),
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 22,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xFF0B5E1C)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color(0xFF0B5E1C),
                        width: 2.0,
                      ),
                    ),
                  ),
                  cursorColor: const Color(0xFF0B5E1C),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Color(0xFF0B5E1C),
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Disbursement is required';
                    }
                    final num? val = num.tryParse(value.trim());
                    if (val == null) {
                      return 'Enter a valid number';
                    }
                    if (val < 0) {
                      return 'Disbursement cannot be negative';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
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
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0B5E1C),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            elevation: 2,
            shadowColor: Color(0xFF69B41E).withOpacity(0.18),
          ),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final memberData = {
                'avatar': null,
                'name': nameController.text.trim(),
                'branch': selectedBranch,
                'location': selectedLocation,
                'savings':
                    double.tryParse(savingsController.text.trim()) ?? 0.0,
                'disbursement':
                    double.tryParse(disbursementController.text.trim()) ?? 0.0,
              };
              Navigator.of(context).pop(memberData);
            }
          },
          child: Text(widget.isEdit ? 'Save' : 'Add'),
        ),
      ],
    );
  }
}
