## Ujian AKhir Semester Pemograman Mobile 2

## API daftar pahlawan Indonesia

## Profil
| #               | Biodata              |
| --------------- | -------------------- |
| **Nama**        | Muhammad Farhan      |
| **NIM**         | 312110128            |
| **Kelas**       | TI.21.A.1            |
| **Mata Kuliah** | Pemrograman Mobile 2 |

A new Flutter project.

# Tutorial
buka aplikasi `Visual Studio Code`  , kemudian buat project baru dengan mengklik `Ctrl + Shift + P`  
```

- Lalu, pada direktori lib > main.dart hapus semua kode, kemudian ubah dengan kode ini:

```
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

```

- Kemudian, tambahkan `APIKEY` kalian dalam url.

```dart
       Uri.parse('https://indonesia-public-static-api.vercel.app/api/heroes'));
```

- Dan jangan lupa menambahkan Library http pada file `pubspec.yaml`.

```dart
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.3
```

- Buka terminal, Kemudian run command `flutter run`.
- Maka hasilnya akan seperti ini :>

## Berikut adalah hasilnya

![Screenshot (224)](https://github.com/farhanz17/UAS_P.Mobile.2/assets/92637117/319caac3-6638-446a-a8af-6b64d7fae0fd)

- Kode diatas dapat kalian improvisasi dengan kreasi kalian sendiri.

## Terima Kasih!



