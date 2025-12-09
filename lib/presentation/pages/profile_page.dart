import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),

          Expanded(
            child: Container(
              color: const Color(0xFFF8F9FA),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.zero,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildAccountSettingsSection(),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Divider(height: 1, color: Colors.grey[300]),
                          ),

                          _buildOtherSection(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: Get.mediaQuery.padding.top + 16,
        left: 20,
        right: 20,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2196F3),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Departemen A',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettingsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          _buildMenuItem(
            icon: Icons.person_outline,
            title: 'Personal Information',
            onTap: () => _showPersonalInfoDialog(),
          ),

          const SizedBox(height: 12),

          _buildMenuItem(
            icon: Icons.lock_outline,
            title: 'Password & Security',
            onTap: () => _showPasswordDialog(),
          ),

          const SizedBox(height: 12),

          _buildMenuItem(
            icon: Icons.payment_outlined,
            title: 'Salary Slip Summary',
            onTap: () => _showSalaryDialog(),
          ),

          const SizedBox(height: 12),

          _buildMenuItem(
            icon: Icons.calendar_today_outlined,
            title: 'Leave Summary',
            onTap: () => _showLeaveDialog(),
          ),

          const SizedBox(height: 12),

          _buildMenuItem(
            icon: Icons.access_time_outlined,
            title: 'Overtime Summary',
            onTap: () => _showOvertimeDialog(),
          ),

          const SizedBox(height: 12),

          _buildMenuItem(
            icon: Icons.receipt_outlined,
            title: 'Annual Tax Return',
            onTap: () => _showTaxDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Other',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          _buildMenuItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => _showLogoutDialog(),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = const Color(0xFF2196F3),
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: color == Colors.red ? color : Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: color == Colors.red
                  ? Colors.red.withOpacity(0.7)
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void _showPersonalInfoDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Personal Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: Color(0xFF2196F3)),
              title: const Text('Full Name'),
              subtitle: const Text('John Doe'),
              trailing: IconButton(
                icon: const Icon(Icons.edit, size: 18),
                onPressed: () {},
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.email, color: Color(0xFF2196F3)),
              title: const Text('Email'),
              subtitle: const Text('john.doe@company.com'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phone, color: Color(0xFF2196F3)),
              title: const Text('Phone'),
              subtitle: const Text('+1 (555) 123-4567'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_on, color: Color(0xFF2196F3)),
              title: const Text('Department'),
              subtitle: const Text('Departemen A'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showPasswordDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Password & Security'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Change your password and security settings'),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Success',
                'Password updated successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showSalaryDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Salary Slip Summary'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Monthly Salary Summary'),
              const SizedBox(height: 16),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Month')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Status')),
                ],
                rows: const [
                  DataRow(
                    cells: [
                      DataCell(Text('January 2024')),
                      DataCell(Text('\$5,000')),
                      DataCell(
                        Text('Paid', style: TextStyle(color: Colors.green)),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('December 2023')),
                      DataCell(Text('\$5,000')),
                      DataCell(
                        Text('Paid', style: TextStyle(color: Colors.green)),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('November 2023')),
                      DataCell(Text('\$4,800')),
                      DataCell(
                        Text('Paid', style: TextStyle(color: Colors.green)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showLeaveDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Leave Summary'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Your leave balance'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLeaveCard('Annual Leave', '12', 'days'),
                _buildLeaveCard('Sick Leave', '8', 'days'),
                _buildLeaveCard('Emergency', '3', 'days'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
        ],
      ),
    );
  }

  Widget _buildLeaveCard(String title, String value, String unit) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2196F3),
          ),
        ),
        Text(unit, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          title,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showOvertimeDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Overtime Summary'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Total overtime hours this month'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2196F3).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Text(
                    '24.5',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                  Text(
                    'hours',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Estimated overtime pay: \$612.50',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showTaxDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Annual Tax Return'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tax year: 2023'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.description, color: Color(0xFF2196F3)),
              title: const Text('Form 16'),
              subtitle: const Text('Download PDF'),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {},
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.description, color: Color(0xFF2196F3)),
              title: const Text('ITR Form'),
              subtitle: const Text('Download PDF'),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {},
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment, color: Color(0xFF2196F3)),
              title: const Text('Total Tax Paid'),
              subtitle: const Text('\$12,500'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout, size: 40, color: Colors.red),
              ),

              const SizedBox(height: 20),

              const Text(
                'LOGOUT?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Are you sure want to logout?',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.red),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: _performLogout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performLogout() {
    Get.back();

    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    Future.delayed(const Duration(seconds: 1), () {
      Get.back();

      Get.snackbar(
        'Success',
        'You have been logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      Get.offAll(
        () => LoginPage(),
        transition: Transition.fade,
        duration: const Duration(milliseconds: 500),
      );
    });
  }

  Future<void> _clearUserData() async {
    print('User data cleared');
  }
}
