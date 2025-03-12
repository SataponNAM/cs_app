import 'package:flutter/material.dart';
import 'package:cs_app/models/crew_model.dart';
import 'package:cs_app/pages/personnel/professor/professor_detail.dart';
import 'package:cs_app/services/crew_service.dart';

class DepartmentStructure extends StatefulWidget {
  const DepartmentStructure({super.key});

  @override
  State<DepartmentStructure> createState() => _DepartmentStructureState();
}

class _DepartmentStructureState extends State<DepartmentStructure> {
  final CrewService crewService = CrewService();
  static const String baseUrl =
      'http://202.44.40.179/Data_From_Chiab/json/crew.json';
  late Future<CrewCollection> _crewCollection;

  void initState() {
    super.initState();
    _crewCollection = crewService.fetchCrewCollection(strUrl: baseUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.deepPurple.shade800),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'ผู้บริหารภาควิชา',
            style: TextStyle(
              color: Colors.deepPurple.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
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
                _buildSection(data.executive),
              ],
            ));
          },
        ));
  }

  Widget _buildSection(List<Crew> crewList) {
    if (crewList.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: crewList.length,
            itemBuilder: (context, index) {
              final crew = crewList[index];
              return _buildCrewListItem(crew);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCrewListItem(Crew crew) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfessorDetail(crewDetail: crew),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Image section
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.network(
                    'http://' + crew.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 50);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Text section
              Expanded(
                child: Text(
                  crew.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              // Add arrow icon to indicate it's tappable
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.deepPurple,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
