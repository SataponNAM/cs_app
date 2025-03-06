import 'package:flutter/material.dart';
import 'package:flutter_app/models/crew_model.dart';

class ProfessorDetail extends StatefulWidget {
  final Crew crewDetail;
  const ProfessorDetail({super.key, required this.crewDetail});

  @override
  State<ProfessorDetail> createState() => _ProfessorDetailState();
}

class _ProfessorDetailState extends State<ProfessorDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[500],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'http://' + widget.crewDetail.image,
                          width: 250,
                          height: 300,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person, size: 100);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.crewDetail.name,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      Text(
                        widget.crewDetail.englishName,
                        style:
                            TextStyle(fontSize: 18, color: Colors.deepPurple),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: Colors.deepPurple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(widget.crewDetail.email,
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.deepPurple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(widget.crewDetail.phone,
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Column(children: [
                      Text('วุฒิการศึกษา',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.crewDetail.education,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Column(children: [
                      Text('ผลงานทางวิชาการ',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.crewDetail.research,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
