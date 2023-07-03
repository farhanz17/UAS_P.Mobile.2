import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class HeroData {
  final String name;
  final String birthYear;
  final String deathYear;
  final String description;

  HeroData(
      {required this.name,
      required this.birthYear,
      required this.deathYear,
      required this.description});

  factory HeroData.fromJson(Map<String, dynamic> json) {
    return HeroData(
      name: json['name'],
      birthYear: json['birth_year'].toString(),
      deathYear: json['death_year'].toString(),
      description: json['description'],
    );
  }
}

class HeroListScreen extends StatefulWidget {
  @override
  _HeroListScreenState createState() => _HeroListScreenState();
}

class _HeroListScreenState extends State<HeroListScreen> {
  late Future<List<HeroData>> futureHeroData;

  @override
  void initState() {
    super.initState();
    futureHeroData = fetchHeroData();
  }

  Future<List<HeroData>> fetchHeroData() async {
    final response = await http.get(
        Uri.parse('https://indonesia-public-static-api.vercel.app/api/heroes'));

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      List<HeroData> heroDataList = [];

      for (var item in responseData) {
        HeroData heroData = HeroData.fromJson(item);
        heroDataList.add(heroData);
      }

      return heroDataList;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Biodata Pahlawan',
          style: TextStyle(color: Colors.yellow[800],
            ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: FutureBuilder<List<HeroData>>(
          future: futureHeroData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<HeroData>? heroDataList = snapshot.data;

              return ListView.builder(
                itemCount: heroDataList!.length,
                itemBuilder: (context, index) {
                  HeroData heroData = heroDataList[index];

                  return ListTile(
                    title: Text(heroData.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Birth Year: ${heroData.birthYear}'),
                        Text('Death Year: ${heroData.deathYear}'),
                        Text('Description: ${heroData.description}'),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HeroListScreen(),
  ));
}
