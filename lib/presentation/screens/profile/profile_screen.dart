import 'package:elysian_user/features/auth/logic/bloc/profile/profile_bloc.dart';
import 'package:elysian_user/features/auth/logic/bloc/profile/profile_event.dart';
import 'package:elysian_user/features/auth/logic/bloc/profile/profile_state.dart';
import 'package:elysian_user/presentation/screens/profile/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial) {
            // Use addPostFrameCallback to avoid state change during build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<ProfileBloc>().add(LoadProfile());
            });
          }

          String name = 'Your Name';
          String? photoUrl;

          if (state is ProfileLoaded) {
            name = state.user.name;
            photoUrl = state.user.photoURL;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Profile Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[200],
                            backgroundImage:
                                photoUrl != null
                                    ? NetworkImage(photoUrl)
                                    : null,
                            child:
                                photoUrl == null
                                    ? const Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    )
                                    : null,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Menu Items
                _buildMenuItem(
                  icon: Icons.chat_bubble_outline,
                  title: 'My Requests',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.info_outline,
                  title: 'About Us',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.thumb_up_outlined,
                  title: 'Rate Us',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.work_outline,
                  title: 'Careers',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.headset_mic_outlined,
                  title: 'Contact Us',
                  onTap: () {},
                ),
                _buildDivider(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 28, color: Colors.black87),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey[300]);
  }
}
