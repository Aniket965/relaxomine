import 'package:rxdart/rxdart.dart';
class SystemVolume {
  BehaviorSubject _volSys =BehaviorSubject.seeded(0.75);
  Observable get stream$ => _volSys.stream;
  int get current => _volSys.value;
 change(double val) {
    _volSys.value = val;
  }
}

class StopPlayer {
  BehaviorSubject _stopPlayers = BehaviorSubject.seeded(0);
  Observable get stream$ => _stopPlayers.stream;
  int get current => _stopPlayers.value;
  stop() {
    _stopPlayers.value = 1;
  }
}

 // Observer for system Volume
 SystemVolume systemVolume = SystemVolume();
 
// Observer for stoping all Players simultaneously
 StopPlayer stopPlayer = StopPlayer();