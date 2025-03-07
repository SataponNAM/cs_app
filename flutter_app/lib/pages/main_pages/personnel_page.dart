import 'package:flutter/material.dart';
import 'package:flutter_app/models/crew_model.dart';
import 'package:flutter_app/pages/main_pages/home_page.dart';
import 'package:flutter_app/pages/personnel/professor/professor_detail.dart';
import 'package:flutter_app/services/crew_service.dart';

class PersonnelPage extends StatefulWidget {
  const PersonnelPage({super.key});

  @override
  State<PersonnelPage> createState() => _PersonnelPageState();
}

class _PersonnelPageState extends State<PersonnelPage> {
  late Future<CrewCollection> _crewCollection;

  @override
  void initState() {
    super.initState();
    _crewCollection = CrewService().fetchCrewCollection(
        strUrl: 'http://202.44.40.179/Data_From_Chiab/json/crew.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CrewCollection>(
        future: _crewCollection,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection('ผู้บริหารภาค', data.executive),
                _buildSection('คณาจารย์', data.professor),
                _buildSection('บุคลากรสายสนับสนุน', data.support),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Crew> crewList) {
    if (crewList.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.8,
            ),
            itemCount: crewList.length,
            itemBuilder: (context, index) {
              final crew = crewList[index];
              return _buildCrewCard(crew);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCrewCard(Crew crew) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfessorDetail(crewDetail: crew),
          ),
        )
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        // shape: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(15),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                'http://' + crew.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, size: 100);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                crew.name,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
