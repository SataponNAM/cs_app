import 'package:flutter/material.dart';
import 'package:cs_app/models/course_model.dart';
import 'package:cs_app/services/course_service.dart';
import '../../assets/constants.dart' as constants;

class CoursePage extends StatefulWidget {
  const CoursePage({
    super.key,
  });

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final CourseHttp _courseHttp = CourseHttp();
  List<Course> _courses = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final courses = await _courseHttp.fetchAllCourse(
          strUrl: constants.COURSE_DATA);
      //print(courses);
      setState(() {
        _courses = courses;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load courses. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            SizedBox(height: 16),
            Text(
              _errorMessage,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchCourses,
              child: Text('Retry'),
            )
          ],
        ),
      );
    }

    if (_courses.isEmpty) {
      return Center(
        child: Text(
          'No courses available',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _courses.length,
      itemBuilder: (context, index) {
        final course = _courses[index];
        return _buildCourseCard(course);
      },
    );
  }

  Widget _buildCourseCard(Course course) {
    return InkWell(
      onTap: () {
        // Handle the tap event here
        print('Card tapped: ${course.courseTitle}');
        // You can navigate to another page or perform any action you want
        if (course.courseTitle == "ปริญญาตรี ภาคปกติ") {
          Navigator.pushNamed(context, '/bachelorNormal');
        } else if (course.courseTitle == "ปริญญาตรี โครงการพิเศษ สองภาษา") {
          Navigator.pushNamed(context, '/bachelorCsb');
        } else if (course.courseTitle == "ปริญญาโท สาขาวิชาวิทยาการคอมพิวเตอร์"){
          Navigator.pushNamed(context, '/masterCs');
        }else if(course.courseTitle == "ปริญญาโท สาขาวิศวกรรมซอฟต์แวร์"){
          Navigator.pushNamed(context, '/masterSe');
        }else if(course.courseTitle == "ปริญญาเอก"){
          Navigator.pushNamed(context, '/phd');
        } else {
          print('click');
        }
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Course Image
            course.imageUrl != "No imageUrl"
                ? ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      'http://' + course.imageUrl,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: Icon(Icons.image_not_supported, size: 50),
                        );
                      },
                    ),
                  )
                : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported, size: 50),
                  ),

            // Course Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.courseTitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    course.courseDescription,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
