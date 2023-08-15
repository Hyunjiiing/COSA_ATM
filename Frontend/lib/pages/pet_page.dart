import 'dart:typed_data';
import 'package:cosa_atm/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_share/flutter_share.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => PetBloc(),
        child: PetScreen(),
      ),
    );
  }
}

class PetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double containerStartingHeight = screenHeight * 0.3;
    double paddingTop = 10.0;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Top grey container
          Positioned(
            top: screenHeight * 0.01,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Color.fromRGBO(50, 50, 50, 0.67),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: IntrinsicWidth(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/dollar.png',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 7),
                    Text(
                      '1,240',
                      style: TextStyle(fontSize: 13.0, color: Colors.white, fontFamily: 'Bit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: containerStartingHeight,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: screenHeight - screenHeight * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(85),
                  topRight: Radius.circular(85),
                ),
              ),
            ),
          ),
          // Bottom grey container
          Positioned(
            top: screenHeight * 0.065,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Color.fromRGBO(50, 50, 50, 0.67),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: IntrinsicWidth(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/level.png',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 7),
                    Text(
                      'Level 3',
                      style: TextStyle(fontSize: 13.0, color: Colors.white, fontFamily: 'Bit'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: containerStartingHeight + 115, // 위젯의 위치 조정
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<PetBloc, PetState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: TextFormField(
                                initialValue: state.pet.name,
                                onChanged: (newName) {
                                  context
                                      .read<PetBloc>()
                                      .add(UpdateNameEvent(newName: newName));
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                style: TextStyle(fontSize: 50, fontFamily: 'Bit'), // 글씨 크기 변경
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              size: 30,
                              color: Color(0xff626161),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        ElevatedButton(
                          child: Text(
                            'Rare',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Bit'
                            ),
                          ),
                          onPressed: () {
                            // 동작을 추가해주세요
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffA5C8FD), // 버튼 색상을 변경합니다.
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'LEVEL 3/20',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Bit'),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(0.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 10),
                                buildLinearPercentIndicator(
                                    0.8, Color(0xffFFCD4A), "60%"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 55,
                                  height: 55,
                                  child: Image.asset(
                                    "assets/images/inventory.png",
                                  ),
                                ),
                                Text(
                                  '인벤토리',
                                  style: TextStyle(fontSize: 18, fontFamily: 'Bit'),
                                ),
                              ],
                            ),
                            /*ElevatedButton(
                                child: Text('인벤토리'),
                                onPressed: () {
                                  // 인벤토리 열기 동작을 추가해주세요
                                },
                              ),*/
                            GestureDetector(
                              onTap: () => sharePet(context), // 여기에 공유 기능
                              child: Column(
                                children: [
                                  Container(
                                    width: 55,
                                    height: 55,
                                    child: Image.asset(
                                      "assets/images/insta.png",
                                    ),
                                  ),
                                  Text(
                                    '공유하기',
                                    style: TextStyle(fontSize: 18, fontFamily: 'Bit'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // Dog image
          Positioned(
            top: containerStartingHeight / 2,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/dog.png',
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

Future<String> _localPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> _writeImageFile(String imagePath) async {
  final imageName = 'dog_share_image.png';
  final path = await _localPath();
  final imageFilePath = '$path/$imageName';
  final File file = File(imageFilePath);

  final data = await rootBundle.load(imagePath);
  final bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  return file.writeAsBytes(bytes);
}

Future<void> sharePet(BuildContext context) async {
  final dogName = context.read<PetBloc>().state.pet.name;
  final imagePath = 'assets/images/dog.png';

  try {
    final imageFile = await _writeImageFile(imagePath);
    await FlutterShare.shareFile(
      title: 'Pet Sharing',
      text: 'Check out my awesome pet, $dogName!',
      filePath: imageFile.path,
      chooserTitle: 'Sharing with',
    );
  } catch (e) {
    print('Error while sharing: $e');
  }
}

// Remaining classes from the original code
abstract class PetEvent extends Equatable {}

class IncrementMoneyEvent extends PetEvent {
  @override
  List<Object> get props => [];
}

class IncrementLevelEvent extends PetEvent {
  @override
  List<Object> get props => [];
}

class UpdateNameEvent extends PetEvent {
  final String newName;

  UpdateNameEvent({required this.newName});

  @override
  List<Object> get props => [newName];
}

class Pet {
  int money;
  int level;
  String name;

  Pet({required this.money, required this.level, required this.name});
}

class PetState {
  Pet pet;

  PetState({required this.pet});
}

class PetBloc extends Bloc<PetEvent, PetState> {
  PetBloc() : super(PetState(pet: Pet(money: 0, level: 0, name: '또리')));

  @override
  Stream<PetState> mapEventToState(PetEvent event) async* {
    if (event is IncrementMoneyEvent) {
      state.pet.money += 1;
      yield PetState(pet: state.pet);
    } else if (event is IncrementLevelEvent) {
      state.pet.level += 1;
      yield PetState(pet: state.pet);
    } else if (event is UpdateNameEvent) {
      state.pet.name = event.newName;
      yield PetState(pet: state.pet);
    }
  }
}

LinearPercentIndicator buildLinearPercentIndicator(
    double percent, Color color, String label) {
  return LinearPercentIndicator(
    lineHeight: 30.0,
    percent: percent,
    backgroundColor: Colors.grey[300],
    progressColor: color,
    center: Text(
      label,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    ),
    barRadius: const Radius.circular(16), // 막대 끝을 둥글게 설정
    animation: true,
    animationDuration: 1000,
  );
}
