import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client/connection/handler.dart';
import 'package:flutter_client/data/CandidateModel.dart';
import 'package:flutter_client/data/candidates_data.dart';

class ResultsPage extends StatefulWidget {
  final ServerConnection serverConnection;
  const ResultsPage({Key? key, required this.serverConnection});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late Future<List<CandidateModel>> candidatesFuture =
      readCandidatesFromFile("assets/data/candidates.txt");

  late Future<String> resultsFuture;

  @override
  void initState() {
    super.initState();
    //_serverConnection.connectToServer();
    _initializeServerConnection();
  }

  Future<void> _initializeServerConnection() async {
    resultsFuture = widget.serverConnection.sendRequest("RESULTS");
  }

  List<String> parseVotes(String results) {
    List<String> candVotes = results.split("\n");
    List<String> votes = [];
    for (String can in candVotes) {
      List<String> fields = can.split('#');
      votes.add(fields[0]);
    }
    return votes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Statistics",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<String>(
            future: resultsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                String results = snapshot.data!;
                List<String> votes = parseVotes(results);

                return FutureBuilder<List<CandidateModel>>(
                  future: candidatesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<CandidateModel> candidates = snapshot.data!;

                      return Card(
                        elevation: 5,
                        child: DataTable2(
                          dataRowHeight: 100,
                          columnSpacing: 6,
                          horizontalMargin: 2,
                          minWidth: 300,
                          columns: [
                            DataColumn2(
                              label: Text(
                                'Candidate',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              size: ColumnSize.L,
                            ),
                            DataColumn(
                              label: Text(
                                'Party',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Votes',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            candidates.length,
                            (index) => DataRow(
                              cells: [
                                DataCell(
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                        candidates[index].candidateImage,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                    Text(candidates[index].partyAbbreviation)),
                                DataCell(Text(votes[index])),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Text('No data available');
                    }
                  },
                );
              } else {
                return const Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }
}
