import 'package:flutter/material.dart';
import 'package:flutter_dust/air_result.dart';
import 'package:flutter_dust/bloc/air_bloc.dart';

void main() {
  runApp(const MyApp());
}

final airBloc = AirBloc();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: StreamBuilder<AirResult>(
              stream: airBloc.airResult,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _buildBody(snapshot.data!);
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }

  Widget _buildBody(AirResult result) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '현재 위치 미세먼지',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 16,
            ),
            Card(
              color: Colors.white,
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Text('얼굴사진'),
                        Text(
                          '${result.data?.current?.pollution?.aqius}',
                          style: const TextStyle(fontSize: 40),
                        ),
                        const Text(
                          '보통',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: [
                            const Text('이미지'),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              '${result.data?.current?.weather?.tp}º',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Text('습도 ${result.data?.current?.weather?.hu}%'),
                        Text('풍속 ${result.data?.current?.weather?.ws}m/s'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ClipRRect(
              // 사각형 둥글게 만들기
              borderRadius: BorderRadius.circular(30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 50)),
                onPressed: () {
                  airBloc.fetch();
                },
                child: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
