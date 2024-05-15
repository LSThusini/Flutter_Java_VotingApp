import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_client/candidate_card.dart';
import 'package:flutter_client/connection/handler.dart';
import 'package:flutter_client/data/CandidateModel.dart';
import 'package:flutter_client/data/candidates_data.dart';

class CandidatesList extends StatefulWidget {
  final ServerConnection serverConnection;
  const CandidatesList({super.key, required this.serverConnection});

  @override
  State<CandidatesList> createState() => _CandidatesListState();
}

class _CandidatesListState extends State<CandidatesList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.table_view_rounded),
          label: '',
        )
      ]),
      appBar: AppBar(
        title: Text(
          "National Candidates",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CandidateModel>>(
        future: readCandidatesFromFile('assets/data/candidates.txt'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(), // Show a loading indicator
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading candidates'), // Show an error message
            );
          } else {
            List<CandidateModel> candidates = snapshot.data!;
            return ListView.builder(
              itemCount: candidates.length,
              itemBuilder: (context, index) {
                final cand = candidates[index];
                return CandidateCard(
                    serverConnection: widget.serverConnection,
                    name:
                        "${cand.firstName} ${cand.lastName}", // Fix typo in last name
                    party: "${cand.partyName} (${cand.partyAbbreviation})",
                    imageUrl: cand.candidateImage,
                    id: cand.index);
              },
            );
          }
        },
      ),
    );
  }
}
