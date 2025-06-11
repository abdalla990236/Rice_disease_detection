import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/disease_data.dart';
import 'ReportDetailsScreen.dart';

class ReportsScreen extends StatefulWidget {
  static const String id = 'ReportsScreen';

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List<Map<String, dynamic>> _reports = [];
  List<Map<String, dynamic>> _filteredReports = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('reports') ?? [];

    final decoded = stored
        .map((e) => json.decode(e) as Map<String, dynamic>)
        .toList();

    final uniqueReportsMap = <String, Map<String, dynamic>>{};
    for (var report in decoded) {
      uniqueReportsMap[report['imagePath']] = report;
    }

    final uniqueReports = uniqueReportsMap.values.toList();

    setState(() {
      _reports = uniqueReports;
      _filteredReports = uniqueReports;
    });
  }

  void _filterReports(String query) {
    final filtered = _reports.where((report) {
      String title = '';
      try {
        final diag = json.decode(report['diagnosis']);
        title = diag['predictions on'] ?? '';
      } catch (_) {}
      return title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredReports = filtered;
    });
  }

  Future<void> _deleteReport(Map<String, dynamic> reportToDelete) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('reports') ?? [];

    stored.removeWhere((e) {
      final decoded = json.decode(e);
      return decoded['imagePath'] == reportToDelete['imagePath'];
    });

    await prefs.setStringList('reports', stored);
    await _loadReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Past Report & Treatment'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: _filterReports,
              decoration: InputDecoration(
                hintText: 'Search by disease name...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _filteredReports.isEmpty
                ? Center(child: Text('No reports found.'))
                : ListView.builder(
              itemCount: _filteredReports.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final report = _filteredReports[index];
                String title = '';
                try {
                  final diag = json.decode(report['diagnosis']);
                  title = diag['predictions on'] ?? '';
                } catch (_) {}

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text('Delete Report'),
                                  content: Text('Are you sure you want to delete this report?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(ctx).pop();
                                        await _deleteReport(report);
                                      },
                                      child: Text('Delete', style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(report['imagePath']),
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            final diagnosis = json.decode(report['diagnosis']);
                            final diseaseName = diagnosis['predictions on'] ?? 'Unknown';
                            final diseaseInfo = diseaseDetails[diseaseName] ?? {
                              "symptoms": ["No specific symptoms available."],
                              "recommendation": "No recommendations available."
                            };

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReportDetailsScreen(
                                  title: diseaseName,
                                  imageUrl: report['imagePath'],
                                  diagnosis: report['diagnosis'],
                                  symptoms: List<String>.from(diseaseInfo['symptoms']),
                                  additionalText: '',
                                  recommendation: diseaseInfo['recommendation'],
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text('See Reports'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
