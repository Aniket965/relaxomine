import 'package:rxdart/rxdart.dart';

class SystemVolume {
  BehaviorSubject _volSys = BehaviorSubject.seeded(0.75);
  Stream get stream$ => _volSys.stream;
  int get current => _volSys.value;
  change(double val) {
    _volSys.value = val;
  }
}

class StopPlayer {
  BehaviorSubject _stopPlayers = BehaviorSubject.seeded(0);
  Stream get stream$ => _stopPlayers.stream;
  int get current => _stopPlayers.value;
  stop() {
    _stopPlayers.value = 1;
  }
}
class StartPlayer {
  BehaviorSubject _startPlayer = BehaviorSubject.seeded(0);
  Stream get stream$ => _startPlayer.stream;
  int get current => _startPlayer.value;
  play() {
    _startPlayer.value = 1;
  }
}


// Observer for system Volume
SystemVolume systemVolume = SystemVolume();

// Observer for stoping all Players simultaneously
StopPlayer stopPlayer = StopPlayer();

StartPlayer startPlayer = StartPlayer();