import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: camel_case_types
class courseDetailsScreen extends StatefulWidget {
  const courseDetailsScreen({super.key});

  @override
  State<courseDetailsScreen> createState() => courseDetailsScreenState();
}

// ignore: camel_case_types
class courseDetailsScreenState extends State<courseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Details'),
        leading: const Icon(
          Icons.arrow_back,
        ),
        actions: const [
          Icon(FontAwesomeIcons.bookmark),
          SizedBox(width: 16),
          Icon(FontAwesomeIcons.bars),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.network(
                      "https://img.freepik.com/free-vector/gradient-ui-ux-background_23-2149024129.jpg?uid=R165238776&ga=GA1.1.626475936.1733358216&semt=ais_hybrid"),
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complete UX/UI & App Design',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'About Course : In today\'s digital age, having a strong online presence is essential for businesses and individuals alike.With the increasing use of our daily lives.....',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Instructor Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 35, // Size of the avatar
                    backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/lovely-good-natured-afro-american-man-white-shirt-having-charming-smile-friendly-expression_273609-14102.jpg', // Replace with your image URL
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tim Marshall',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'UI/UX Designer in Pixency',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    '5 Courses',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Course Progress
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),
                    child: const Center(
                      child: Text(
                        'Courses',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Complete 45%',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Lessons
            const Row(
              children: [
                Icon(Icons.play_arrow),
                SizedBox(width: 10),
                Text(
                  '24 Lesson',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: const [
                  LessonTile(
                    number: '1',
                    title: 'Introducing UI/UX Design',
                    duration: '43:30',
                  ),
                  LessonTile(
                    number: '2',
                    title: 'Figma Fundamentals',
                    duration: '22:40',
                  ),
                  LessonTile(
                    number: '3',
                    title: 'Designer Career Path',
                    duration: '34:30',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Continue Learning Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Continue Learning',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LessonTile extends StatelessWidget {
  final String number;
  final String title;
  final String duration;

  const LessonTile({
    super.key,
    required this.number,
    required this.title,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),
              const SizedBox(height: 4),
              Text(
                duration,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
