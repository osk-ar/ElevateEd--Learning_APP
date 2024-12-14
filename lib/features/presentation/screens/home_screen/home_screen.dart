import 'package:e_learning_app_gp/features/presentation/screens/course_details/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hallo, Affandi',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          Text(
            "Let's Learn Now!",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        _buildNotificationIcon(),
        IconButton(
          icon:
              const Icon(FontAwesomeIcons.magnifyingGlass, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildNotificationIcon() {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(FontAwesomeIcons.bell, color: Colors.black),
          onPressed: () {},
        ),
        Positioned(
          right: 11,
          top: 11,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
            child: const Text(
              '4',
              style: TextStyle(color: Colors.white, fontSize: 8),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildCard(
                  icon: FontAwesomeIcons.graduationCap,
                  iconColor: Colors.green,
                  title: 'Enrollment',
                  subtitle: '14 Video',
                  progress: 0.5,
                  progressColor: Colors.green,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildCard(
                  icon: FontAwesomeIcons.clock,
                  iconColor: Colors.orange,
                  title: 'Learning Time',
                  subtitle: '88h 31m',
                  progress: 0.75,
                  progressColor: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildProgressCard(),
          const SizedBox(height: 16),
          _buildCourseSection(),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required double progress,
    required Color progressColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: progressColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recently Progress',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Last 3 Days',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '25h 12m',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Track your progress here',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProgressBar(
                    day: 'Mon', progress: 0.3, progressText: '+6'),
                _buildProgressBar(
                    day: 'Tue', progress: 0.5, progressText: '+10'),
                _buildProgressBar(
                    day: 'Today', progress: 0.4, progressText: '+9'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(
      {required String day,
      required double progress,
      required String progressText}) {
    return Column(
      children: [
        Text(progressText, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 4),
        Container(
          width: 20,
          height: 100 * progress,
          decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 4),
        Text(day, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildCourseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Course',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'See More',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CourseCard(
                  imageUrl: 'https://www.cdmi.in/courses@2x/Web-design.webp',
                  title: 'Web Design'),
              SizedBox(width: 16),
              CourseCard(
                  imageUrl:
                      'https://www.filepicker.io/api/file/weOnv3ocS0uZd45WSCrO',
                  title: 'Flutter && Dart'),
              SizedBox(width: 16),
              CourseCard(
                  imageUrl:
                      'https://www.pcilearning.com/wp-content/uploads/2015/11/graphic_small_banner-3.jpg',
                  title: 'Graphic Design'),
              SizedBox(width: 16),
              CourseCard(
                  imageUrl:
                      'https://computertrainingschoolnigeria.com.ng/wp-content/uploads/2021/08/Data-Analysis-Training-In-Abuja-Nigeria-1.jpg',
                  title: 'Data Analytics')
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Product Design Expert Class',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: 0.5,
                backgroundColor: Colors.grey[200],
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(FontAwesomeIcons.play, color: Colors.blue),
          ],
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.house, color: Colors.blue),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.book, color: Colors.grey),
          label: 'Course',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.star, color: Colors.blue),
          label: 'Progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user, color: Colors.grey),
          label: 'Profile',
        ),
      ],
    );
  }
}
