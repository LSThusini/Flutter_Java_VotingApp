import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_client/candidate_card.dart';

import 'package:flutter_client/data/CandidateModel.dart';

class CandidatesList extends StatefulWidget {
  const CandidatesList({super.key});

  @override
  State<CandidatesList> createState() => _CandidatesListState();
}

class _CandidatesListState extends State<CandidatesList> {
  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  List<CandidateModel> parseCandidates(String data) {
    List<CandidateModel> candidates = [];

    // Split the data into lines
    List<String> lines = data.split('\n');

    // Iterate over each line
    for (String line in lines) {
      // Split the line into fields using '#' as the delimiter

      List<String> fields = line.split('#');

      // Extract individual pieces of information
      int index = int.parse(fields[0]);
      String lastName = fields[1];
      String firstName = fields[2];
      String partyName = fields[3];
      String partyAbbreviation = fields[4];
      String candidateImage = fields[5];
      String logoImage = fields[6];

      // Create a Candidate object and add it to the list
      CandidateModel candidate = CandidateModel(
        index: index,
        lastName: lastName,
        firstName: firstName,
        partyName: partyName,
        partyAbbreviation: partyAbbreviation,
        candidateImage: candidateImage,
        logoImage: logoImage,
      );

      candidates.add(candidate);
    }

    return candidates;
  }

  Future<List<CandidateModel>> readCandidatesFromFile(String filePath) async {
    String data = await loadAsset(filePath);
    return parseCandidates(data);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return Center(
              child: Text('Error loading candidates'), // Show an error message
            );
          } else {
            List<CandidateModel> candidates = snapshot.data!;
            return ListView.builder(
              itemCount: candidates.length,
              itemBuilder: (context, index) {
                final cand = candidates[index];
                return CandidateCard(
                  name:
                      "${cand.firstName} ${cand.lastName}", // Fix typo in last name
                  party: "${cand.partyName} (${cand.partyAbbreviation})",
                  imageUrl: cand.candidateImage,
                );
              },
            );
          }
        },
      ),
    );
  }
}
