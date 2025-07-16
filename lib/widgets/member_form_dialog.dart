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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width < 600 ? 320 : 400,
          maxWidth: MediaQuery.of(context).size.width > 900 ? 520 : 400,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B5E1C),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    widget.isEdit ? 'Edit Member' : 'Add Member',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Name
              TextField(
                controller: nameController,
                enabled: !widget.isEdit,
                decoration: InputDecoration(
                  labelText: 'Name',
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
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF0B5E1C)),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF0B5E1C)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFF0B5E1C),
                      width: 2.0,
                    ),
                  ),
                ),
                cursorColor: const Color(0xFF0B5E1C),
                style: TextStyle(
                  color: widget.isEdit ? Colors.grey : const Color(0xFF0B5E1C),
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 12),
              // Branch Dropdown (add only)
              widget.isEdit
                  ? TextField(
                      enabled: false,
                      controller: TextEditingController(text: selectedBranch),
                      decoration: InputDecoration(
                        labelText: 'Branch',
                        filled: true,
                        fillColor: Colors.grey[100],
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                        ),
                        disabledBorder: OutlineInputBorder(
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
                      cursorColor: const Color(0xFF0B5E1C),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  : DropdownButtonFormField<String>(
                      value: selectedBranch,
                      items: branches
                          .map(
                            (b) => DropdownMenuItem(value: b, child: Text(b)),
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
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: const TextStyle(color: Color(0xFF0B5E1C)),
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
                      dropdownColor: Colors.white,
                      style: const TextStyle(color: Color(0xFF0B5E1C)),
                    ),
              const SizedBox(height: 12),
              // Location (auto, not editable)
              TextField(
                enabled: false,
                controller: TextEditingController(text: selectedLocation),
                decoration: InputDecoration(
                  labelText: 'Location',
                  filled: true,
                  fillColor: Colors.grey[100],
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF0B5E1C)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
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
              const SizedBox(height: 12),
              // Savings
              TextField(
                controller: savingsController,
                decoration: InputDecoration(
                  labelText: 'Savings',
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: const TextStyle(
                    color: Color(0xFF0B5E1C),
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF0B5E1C)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
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
              ),
              const SizedBox(height: 12),
              // Disbursement
              TextField(
                controller: disbursementController,
                decoration: InputDecoration(
                  labelText: 'Disbursement',
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: const TextStyle(
                    color: Color(0xFF0B5E1C),
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF0B5E1C)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
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
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF0B5E1C),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0B5E1C),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            final memberData = {
              'avatar': null,
              'name': nameController.text.trim(),
              'branch': selectedBranch,
              'location': selectedLocation,
              'savings': double.tryParse(savingsController.text.trim()) ?? 0.0,
              'disbursement':
                  double.tryParse(disbursementController.text.trim()) ?? 0.0,
            };
            Navigator.of(context).pop(memberData);
          },
          child: Text(widget.isEdit ? 'Save' : 'Add'),
        ),
      ],
    );
  }
}
