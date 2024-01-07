import 'package:audioplayers/audioplayers.dart';

// 单例模式
final AudioPlayerUtil audioPlayerUtil = AudioPlayerUtil();

///
/// Title： Flutter提示声音工具类
/// Description：
/// 1. 单例模式
/// 2. 文件缓存管理优化
/// 3. 播放Flutter项目本地assets音频文件
/// 4. 播放网络音频文件
///
/// @version 1.0.0
/// @date 2021/12/31
///
class AudioPlayerUtil {
  late AudioPlayer _audioPlayer;
  late AudioCache _audioCache;

  // 工厂方法构造函数
  factory AudioPlayerUtil() => _getInstance();

  // instance的getter方法，singletonManager.instance获取对象
  static AudioPlayerUtil get instance => _getInstance();

  // 静态变量_instance，存储唯一对象
  static AudioPlayerUtil _instance = AudioPlayerUtil.internal();

  // 获取对象
  static AudioPlayerUtil _getInstance() {
    if (_instance == null) {
      // 使用私有的构造方法来创建对象
      _instance = AudioPlayerUtil.internal();
    }
    return _instance;
  }

  // 私有命名式构造方法，通过它实现一个类 可以有多个构造函数，
  // 子类不能继承internal
  // 不是关键字，可定义其他名字
  AudioPlayerUtil.internal() {
    // 初始化...
    _audioCache = AudioCache();
    _audioPlayer = AudioPlayer();
  }

  ///播放
  loadAudioCache(String fileName) {}

  /// 本地音乐文件播放
  playLocal(String file) async {
    if (file != null) {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(file));
    } else {
      print('play failed path empty');
    }
  }

  /// 远程音乐文件播放，localPath类似http://xxx/xxx.mp3
  playRemote(String url) async {
    await _audioPlayer.play(UrlSource(url));
  }

  ///暂停
  pause() async {
    // 暂停当前播放的音频。
    // 如果你稍后调用[resume]，音频将从它的点恢复
    // 已暂停。
    _audioPlayer.pause();
  }

  /// 调整进度 - 跳转指定时间
  /// milliseconds 毫秒
  seek(int milliseconds) async {
    await _audioPlayer.seek(Duration(milliseconds: milliseconds));
  }

  ///调整音量
  ///double volume 音量 0-1 0表示静音，1表示最大音量。0到1之间的值
  setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  ///释放资源
  release() async {
    // 释放与该媒体播放器关联的资源。
    // 当你需要重新获取资源时，你需要重新获取资源
    // 调用[play]或[setUrl]。
    await _audioPlayer.release();
  }
}
