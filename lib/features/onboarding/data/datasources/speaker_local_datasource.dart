import '../models/speaker_model.dart';

abstract class SpeakerLocalDataSource {
  Future<List<SpeakerModel>> getSpeakers();
}

class SpeakerLocalDataSourceImpl implements SpeakerLocalDataSource {
  @override
  Future<List<SpeakerModel>> getSpeakers() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      const SpeakerModel(
        id: '1',
        name: 'Levi Lusko',
        imageUrl: 'assets/abae2c0b2dcb58a90ec4fb849880ea875800d690.png',
      ),
      const SpeakerModel(
        id: '2',
        name: 'Craig Groeschel',
        imageUrl: 'assets/e1149742aad2e6341ee9fbe3adabd509d324714b.png',
      ),
      const SpeakerModel(
        id: '3',
        name: 'John Piper',
        imageUrl: 'assets/4bddcd30715d5974642f6175380865d9ce2a4beb.png',
      ),
      const SpeakerModel(
        id: '4',
        name: 'Christine Caine',
        imageUrl: 'assets/ed8cd1c9d1d0f7488ceb2c8eedaa76f8f957c777.png',
      ),
      const SpeakerModel(
        id: '5',
        name: 'Jackie Hill Perry',
        imageUrl: 'assets/c572b9a961a85c938c4eb86abcbbf4a39411efb4.png',
      ),
      const SpeakerModel(
        id: '6',
        name: 'Priscilla Shirer',
        imageUrl: 'assets/e6cbd9a83606daac373af83eb7ba46743724cd40.png',
      ),
      const SpeakerModel(
        id: '7',
        name: 'Timothy Keller',
        imageUrl: 'assets/c37c6a12c7707f564ea62a96428bc69ddad46d14.png',
      ),
      const SpeakerModel(
        id: '8',
        name: 'John McArthur',
        imageUrl: 'assets/2020dd88fc696356bd502a0956060e1469ac501f.png',
      ),
      const SpeakerModel(
        id: '9',
        name: 'Tim Mackie',
        imageUrl: 'assets/e9f2867b8c23e7e74dadebd7cf22e22c4fd6261d.png',
      ),
      const SpeakerModel(
        id: '10',
        name: 'Francis Chan',
        imageUrl: 'assets/adfd29003f400e07b9aadaa710daf256387d5fb3.png',
      ),
      const SpeakerModel(
        id: '11',
        name: 'Beth Moore',
        imageUrl: 'assets/7e8cd3f2a111c3a4e8de82968687f493ed14a1d8.png',
      ),
      const SpeakerModel(
        id: '12',
        name: 'Rick Warren',
        imageUrl: 'assets/4a1609d5124d7742a03a31f64657cc9f42832c71.png',
      ),
      const SpeakerModel(
        id: '13',
        name: 'Derwin Gray',
        imageUrl: 'assets/38142a7668814d293e539a504ba8679e10056071.png',
      ),
      const SpeakerModel(
        id: '14',
        name: 'Andy Stanley',
        imageUrl: 'assets/c6f961e1a0868d552936927ed1c338c6f009f242.png',
      ),
      const SpeakerModel(
        id: '15',
        name: 'Steven Furtick',
        imageUrl: 'assets/a0e07cc0cccc4660c1854b8a34ad6e7f634d892f.png',
      ),
    ];
  }
}
