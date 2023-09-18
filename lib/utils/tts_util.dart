import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';

final TTSUtil ttsUtil = TTSUtil();

///
/// Title： Flutter 文字转语音工具类
/// Description：
/// 1. 单例模式
/// 2. 文件缓存管理优化
/// 3. 播放Flutter项目本地assets音频文件
/// 4. 播放网络音频文件
///
/// @version 1.0.0
/// @date 2021/12/31
///
class TTSUtil {
  late FlutterTts _tts;

  factory TTSUtil() => _getInstance();

  static TTSUtil get instance => _getInstance();

  static TTSUtil? _instance;

  static TTSUtil _getInstance() {
    return _instance ??= TTSUtil.internal();
  }

  TTSUtil.internal() {
    _tts = FlutterTts();
  }

  Future speak(String data) async {
    var result = await _tts.speak(data);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  ///暂停
  Future pause() async {
    var result = await _tts.pause();
    // if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  Future stop() async {
    var result = await _tts.stop();
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }
}
