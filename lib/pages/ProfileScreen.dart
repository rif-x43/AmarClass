import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showAcademicHistory = false;
  bool showSavedResources = false;
  bool showAccountSettings = true;
  bool showAppSettings = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            20,
            24,
            20,
            30,
          ),
          children: [

            // Profile Head
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // Profile pic
                const CircleAvatar(
                  radius: 36,
                  backgroundColor: Color(0xFF5B9BF8),
                  child: Text(
                    'JD',
                    style: TextStyle(
                      fontFamily: 'Inter Display',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontFamily: 'Inter Display',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      'Computer Science & Engineering',
                      style: TextStyle(
                        fontFamily: 'Inter Display',
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      '3.7 CGPA     5 Courses     Year 3',
                      style: TextStyle(
                        fontFamily: 'Inter Display',
                        fontSize: 10,
                        color: Color(0xFF2F8DF6),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 25),

            //Personal info

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.black12,
                  width: 0.5,
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      const Text(
                        'Personal Information',
                        style: TextStyle(
                          fontFamily: 'Inter Display',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      //svae button

                      TextButton(
                        onPressed: () {

                        },
                        child: const Text(
                          'Svae',
                          style: TextStyle(
                            fontFamily: 'Inter Display',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF35A853),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _buildField(
                    'FULL NAME',
                    'John Doe',
                  ),

                  const SizedBox(height: 15),
                  _buildField(
                    'DEPARTMENT',
                    'Computer Science & Engineering',
                  ),

                  const SizedBox(height: 15),
                  _buildField(
                    'STUDENT ID',
                    'CS-2021-0042',
                  ),

                  const SizedBox(height: 15),
                  _buildField(
                    'EMAIL',
                    'j.doe@university.edu',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Academic History Card

            _buildExpandableCard(
              title: 'Academic History',
              icon: Icons.school,
              isOpen: showAcademicHistory,
              onTap: () {
                setState(() {
                  showAcademicHistory = !showAcademicHistory;
                });
              },
            ),

            if (showAcademicHistory)
              _buildSmallContent(
                'No academic history added yet.',
              ),

            const SizedBox(height: 10),

            // Saved resource card

            _buildExpandableCard(
              title: 'Saved Resources',
              icon: Icons.bookmark,
              isOpen: showSavedResources,
              onTap: () {
                setState(() {
                  showSavedResources = !showSavedResources;
                });
              },
            ),

            if (showSavedResources)
              _buildSmallContent(
                'No saved resources yet.',
              ),

            const SizedBox(height: 10),

            // Settings card for account

            _buildExpandableCard(
              title: 'Account Settings',
              icon: Icons.settings,
              isOpen: showAccountSettings,
              onTap: () {
                setState(() {
                  showAccountSettings = !showAccountSettings;
                });
              },
            ),

            if (showAccountSettings)
              Container(
                margin: const EdgeInsets.only(top: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black12,
                    width: 0.5,
                  ),
                ),

                child: Column(
                  children: [

                    _buildSetting(
                      'Update Password',
                    ),

                    _buildSetting(
                      'Notification Preferences',
                    ),

                    _buildSetting(
                      'Privacy & Security',
                    ),

                    _buildSetting(
                      'Connected Accounts',
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 10),

            // Settings for app

            _buildExpandableCard(
              title: 'App Settings',
              icon: Icons.phone_android,
              isOpen: showAppSettings,
              onTap: () {
                setState(() {
                  showAppSettings = !showAppSettings;
                });
              },
            ),

            if (showAppSettings)
              _buildSmallContent(
                'None currently',
              ),

            const SizedBox(height: 16),

            // sign out

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {},

                icon: const Icon(
                  Icons.logout,
                  color: Color(0xFFE55353),
                ),

                label: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontFamily: 'Inter Display',
                    color: Color(0xFFE55353),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFF0F0),
                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  //feild
  Widget _buildField(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 9,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 6),

        Container(
          width: double.infinity,

          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),

          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFF9DC8FF),
            ),
            borderRadius: BorderRadius.circular(10),
          ),

          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  // expandable card.
  Widget _buildExpandableCard({
    required String title,
    required IconData icon,
    required bool isOpen,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(17),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black12,
            width: 0.5,
          ),
        ),

        child: Row(
          children: [

            Icon(
              icon,
              size: 20,
              color: const Color(0xFF4B426D),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            Icon(
              isOpen
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  // settings account

  Widget _buildSetting(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),

      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 15,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFF8F8FC),
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        children: [

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),

          const Icon(
            Icons.chevron_right,
            size: 18,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  // placeholder
  Widget _buildSmallContent(String text) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(top: 6),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter Display',
          fontSize: 12,
          color: Colors.black54,
        ),
      ),
    );
  }
}