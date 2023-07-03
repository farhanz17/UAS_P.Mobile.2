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
buka aplikasi 'Visual Studio Code' , kemudian buat project baru dengan mengklik 'Ctrl + Shift + P'
```

- Lalu, pada direktori lib > main.dart hapus semua kode, kemudian ubah dengan kode ini:

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatefulWidget {
  @override
  _NewsAppState createState() => _NewsAppState();
}

class NewsDetailScreen extends StatelessWidget {
  final dynamic article;

  const NewsDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article['urlToImage'] != null)
                Image.network(
                  article['urlToImage'],
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 16),
              Text(
                article['title'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                article['description'] != null
                    ? article['description']
                    : 'No description available',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Published At: ${article['publishedAt']}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Source: ${article['source']['name']}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Read More: ${article['url']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsAppState extends State<NewsApp> {
  List<dynamic> articles = [];

  Future<void> fetchNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=id&apiKey="APIKEY ANDA"';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        articles = jsonData['articles'];
      });
    } else {
      print('Error fetching news.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('News App'),
        ),
        body: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: articles[index]['urlToImage'] != null
                    ? Image.network(
                        articles[index]['urlToImage'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : SizedBox.shrink(),
                title: Text(articles[index]['title']),
                subtitle: Text(articles[index]['description'] ??
                    'No description available'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailScreen(
                        article: articles[index],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
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



