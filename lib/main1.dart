import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(MyLockScreen());

class MyLockScreen extends StatelessWidget {
  const MyLockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LockScreenUI(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LockScreenUI extends StatelessWidget {
  const LockScreenUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/home0.jpeg',
            fit: BoxFit.cover,
          ),

          // Blur layer
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Fri Jun 13',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.orange.shade300,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '12:10',
                  style: TextStyle(
                    fontSize: 80,
                    color: Colors.amber.shade200,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),

                // Circular icons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCircleIcon(Icons.do_not_disturb_on, 'None'),
                    _buildCircleIcon(Icons.cake, ''),
                    _buildCircleIcon(Icons.alarm, '7:00\nAM'),
                    _buildCircleIcon(Icons.pets, ''),
                  ],
                ),

                SizedBox(height: 20),

                // Notifications
                Expanded(child: ListView(children: [
                  _buildNotificationCard(
                    icon: Icons.mail,
                    title: 'Udemy Instructor: Frank Ane...',
                    subtitle:
                    'Crack the code, passwords, and hidden data!\nThis ethical hacking course dives deep into network...',
                  ),
                  _buildNotificationCard(
                    icon: Icons.work,
                    title: 'Top Applicant',
                    subtitle:
                    'You\'re a top applicant for Backend Developer at WING and 20+ other jobs.',
                  ),
                  _buildNotificationCard(
                    icon: Icons.video_library,
                    title: 'YouTube',
                    subtitle: '🔴 Watch live now: Flutter: Tricksy Projects | Observable Flutter #64',
                  ),
                  _buildNotificationCard(
                    icon: Icons.person,
                    title: 'Sovu_Anki • Friend',
                    subtitle: 'reposted a video',
                  ),_buildNotificationCard(
                    icon: Icons.work,
                    title: 'Top Applicant',
                    subtitle:
                    'You\'re a top applicant for Backend Developer at WING and 20+ other jobs.',
                  ),
                  _buildNotificationCard(
                    icon: Icons.video_library,
                    title: 'YouTube',
                    subtitle: '🔴 Watch live now: Flutter: Tricksy Projects | Observable Flutter #64',
                  ),
                  _buildNotificationCard(
                    icon: Icons.person,
                    title: 'Sovu_Anki • Friend',
                    subtitle: 'reposted a video',
                  ),_buildNotificationCard(
                    icon: Icons.work,
                    title: 'Top Applicant',
                    subtitle:
                    'You\'re a top applicant for Backend Developer at WING and 20+ other jobs.',
                  ),
                  _buildNotificationCard(
                    icon: Icons.video_library,
                    title: 'YouTube',
                    subtitle: '🔴 Watch live now: Flutter: Tricksy Projects | Observable Flutter #64',
                  ),
                  _buildNotificationCard(
                    icon: Icons.person,
                    title: 'Sovu_Anki • Friend',
                    subtitle: 'reposted a video',
                  ),
                ],))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.amber.withOpacity(0.3),
            child: Icon(icon, color: Colors.white),
          ),
          if (label.isNotEmpty)
            SizedBox(height: 4),
          if (label.isNotEmpty)
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withOpacity(.1), width: 1)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: 4),
                Text(subtitle,
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
