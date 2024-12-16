import 'package:flutter/material.dart';

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
        centerTitle: true,
        elevation: 0,
        title: const Text('Details'),
        leading: const Icon(
          Icons.arrow_back,
        ),
        actions: const [
          Icon(Icons.bookmark),
          SizedBox(width: 16),
          Icon(Icons.menu),
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
                SizedBox(
                  width: 80,
                  height: 60,
                  child: Image.network(
                      "https://img.freepik.com/free-vector/gradient-ui-ux-background_23-2149024129.jpg?uid=R165238776&ga=GA1.1.626475936.1733358216&semt=ais_hybrid"),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complete UX/UI &',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'App Design',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'About Course :',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' In today\'s digital age, having a strong online presence is essential for businesses and individuals alike.With the increasing use of our daily lives.....',
                        style: TextStyle(fontSize: 14),
                      )
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
                    radius: 25, // Size of the avatar
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
                  Icon(Icons.arrow_forward)
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
                CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.play_arrow_rounded)),
                SizedBox(width: 10),
                Text(
                  '24 Lesson',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: const [
                  LessonTile(
                    icon: Icon(Icons.play_arrow_rounded),
                    title: '1. Introducing UI/UX Design',
                    duration: '43:30',
                  ),
                  LessonTile(
                    icon: Icon(Icons.play_arrow_rounded),
                    title: '2. Figma Fundamentals',
                    duration: '22:40',
                  ),
                  LessonTile(
                    icon: Icon(Icons.play_arrow_rounded),
                    title: '3. Designer Career Path',
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
  final Widget icon;
  final String title;
  final String duration;

  const LessonTile({
    super.key,
    required this.icon,
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
            child: const Center(
              child: Icon(Icons.play_arrow),
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
