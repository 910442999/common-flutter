import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'log_utils.dart';
import 'permission_util.dart';
import 'picker/picker_method.dart';
import 'text_util.dart';

///媒体工具，选照片，拍照，录音，播放语音
class MediaUtil {
  String pageName = "MediaUtil";

  factory MediaUtil() => _getInstance();

  static MediaUtil get instance => _getInstance();
  static MediaUtil? _instance;

  MediaUtil._internal() {
    // 初始化
  }

  static MediaUtil _getInstance() {
    _instance ??= MediaUtil._internal();
    return _instance!;
  }

  //请求权限：相册，相机，麦克风
  void requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.camera,
      Permission.microphone,
      Permission.storage
    ].request();
    for (var status in statuses.keys) {}
  }

  ///请求视频通话权限
  Future<bool> requestVideoCall(BuildContext context) async {
    return PermissionUtils.requestVideoCall(context);
  }

  ///请求语音通话权限
  Future<bool> requestAudioCall(BuildContext context) async {
    return PermissionUtils.requestAudioCall(context);
  }

  Future<Map<String, dynamic>> pickImage(BuildContext context,
      {int aspectRatio = 1,
      int cropStyle = 0,
      int imageSize = 500,
      bool compress = false,
      bool cropper = false}) async {
    String? filePath;
    Map<String, dynamic> map = {"code": 0, "message": "", "data": ""};
    try {
      bool permission = await PermissionUtils.requestStorage(context);
      if (permission) {
        //      =================选择图片======================
        final List<AssetEntity>? result =
            await PickMethod.image(1).method(context, <AssetEntity>[]);
        //      =================剪辑和压缩图片======================
        if (result != null) {
          File file = (await result[0].file)!;
          filePath = file.path;
          //是否需要裁剪 ,不需要直接返回文件路径
          if (!cropper) {
            map["code"] = 200;
            map["data"] = filePath;
            return map;
          }

          if (TargetPlatform.android == defaultTargetPlatform) {
            filePath = filePath.replaceFirst("file://", "");
          }
          List<CropAspectRatioPreset> aspectRatioPresets = [];
          if (aspectRatio == 1) {
            aspectRatioPresets.add(CropAspectRatioPreset.square);
          } else if (aspectRatio == 2) {
            aspectRatioPresets.add(CropAspectRatioPreset.ratio4x3);
          }
          CropStyle style = CropStyle.rectangle;
          if (cropStyle == 1) {
            style = CropStyle.circle;
          }
          CroppedFile? croppedFile = await ImageCropper().cropImage(
              sourcePath: filePath,
              aspectRatioPresets: aspectRatioPresets,
              cropStyle: style,
              uiSettings: [
                AndroidUiSettings(
                    // toolbarTitle: '编辑图片',
                    toolbarColor: Colors.white,
                    // toolbarWidgetColor: Colors.white,
                    initAspectRatio: aspectRatioPresets[0],
                    hideBottomControls: true,
                    lockAspectRatio: true),
                IOSUiSettings(
                  minimumAspectRatio: 1.0,
                  aspectRatioLockEnabled: true,
                )
              ]);
          if (croppedFile == null) {
            map["code"] = 201;
            // map["message"] = "图片未裁剪！";
            return map;
          } else {
            filePath = croppedFile.path;
          }
          // Log.e(
          //     "剪辑后大小 ：${croppedFile?.lengthSync() == null ? '' : PeanutiCommonUtils.getRollupSize(croppedFile?.lengthSync())}");

          //是否需要压缩 ,不需要压缩直接返回文件路径
          if (!compress) {
            map["code"] = 200;
            map["data"] = filePath;
            return map;
          }
          try {
            String? tempPath = await compressImage(File(filePath));
            if (!TextUtil.isEmpty(tempPath)) {
              File tempFile = File(tempPath!);
              if (tempFile.lengthSync() != null &&
                  tempFile.lengthSync() < imageSize * 1024) {
                filePath = tempFile.path;
                map["code"] = 200;
                map["data"] = filePath;
                return map;
              } else {
                map["code"] = 202;
                map["message"] = "图片太大，请裁剪后重新选择！";
                return map;
              }
            } else {
              map["code"] = 203;
              map["message"] = "图片格式不正确！";
              return map;
            }
          } catch (e) {
            map["code"] = 204;
            // map["message"] = "图片压缩异常！";
            return map;
          }
        } else {
          Log.d("从选择相册页面返回未选择图片");
          map["code"] = 205;
          // map["message"] = "从选择相册页面返回未选择图片！";
          return map;
        }
      } else {
        map["code"] = 206;
        map["message"] = "您暂未授权访问相册权限，请打开设置页授权";
        return map;
      }
    } catch (e) {
      map["code"] = 207;
      map["message"] = "图片处理异常";
      return map;
    }
  }

  //开始录音
  void startRecordAudio() async {
    // developer.log("debug 准备录音并检查权限", name: pageName);
    // bool hasPermission = await FlutterAudioRecorder.hasPermissions;
    // if (hasPermission) {
    //   developer.log("debug 录音权限已开启", name: pageName);
    //   Directory tempDir = await getTemporaryDirectory();
    //   String tempPath = tempDir.path +
    //       "/" +
    //       DateTime.now().millisecondsSinceEpoch.toString() +
    //       ".aac";
    //   _recorder = FlutterAudioRecorder(tempPath,
    //       audioFormat: AudioFormat.AAC); // or AudioFormat.WAV
    //   await _recorder.initialized;
    //   await _recorder.start();
    //   developer.log("debug 开始录音", name: pageName);
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "录音权限未开启",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIos: 1,
    //       backgroundColor: Colors.grey[800],
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }
  }

  //录音结束，通过 finished 返回本地路径和语音时长，注：Android 必须要加 file:// 头
  void stopRecordAudio(Function(String path, int duration) finished) async {
    // var result = await _recorder.stop();
    // developer.log(
    //     "Stop recording: path = ${result.path}，duration = ${result.duration}",
    //     name: pageName);
    // developer.log("Stop recording: duration = ${result.duration}",
    //     name: pageName);
    // if (result.duration.inSeconds > 0) {
    //   String path = result.path;
    //   if (path == null) {
    //     if (finished != null) {
    //       finished(null, 0);
    //     }
    //   }
    //   if (TargetPlatform.android == defaultTargetPlatform) {
    //     path = "file://" + path;
    //   }
    //   if (finished != null) {
    //     finished(path, result.duration.inSeconds);
    //   }
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "说话时间太短",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIos: 1,
    //       backgroundColor: Colors.grey[800],
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }
  }

  //播放语音
  void startPlayAudio(String path) {
    // if (flutterSound.isPlaying) {
    //   stopPlayAudio();
    // }
    // flutterSound.startPlayer(path);
  }

  //停止播放语音
  void stopPlayAudio() {
    // flutterSound.stopPlayer();
  }

  String getCorrectedLocalPath(String localPath) {
    String path = localPath;
    //Android 本地路径需要删除 file:// 才能被 File 对象识别
    if (TargetPlatform.android == defaultTargetPlatform) {
      path = localPath.replaceFirst("file://", "");
    }
    return path;
  }

  Future<String?> compressImage(File? imageFile, {int imageSize = 500}) async {
    if (imageFile != null) {
      //不足时 无需压缩
      // if (imageFile != null &&
      //     imageFile.lengthSync() != null &&
      //     imageFile.lengthSync() < imageSize * 1024) {
      //   return imageFile.path;
      // }
      var time_start = DateTime.now().millisecondsSinceEpoch;
      final tempDir = await getTemporaryDirectory();
      CompressObject compressObject = CompressObject(
        imageFile: imageFile, //image
        path: tempDir.path, //compress to path
        // quality: 100, //first compress quality, default 80
//      step: 9, //compress quality step, The bigger the fast, Smaller is more accurate, default 6
//      mode: CompressMode.LARGE2SMALL,//default AUTO
      );
      String? _path = await Luban.compressImage(compressObject);
      var time = DateTime.now().millisecondsSinceEpoch - time_start;
      Log.e("用时 ： " + time.toString());
      return _path;
    }
    return null;
  }

  Future<List<String?>?> compressImageList(List<File>? imageFile) async {
    if (imageFile != null) {
      var time_start = DateTime.now().millisecondsSinceEpoch;
      final tempDir = await getTemporaryDirectory();

      List<String?> results = [];
      for (int i = 0; i < imageFile.length; i++) {
        CompressObject compressObject = CompressObject(
          imageFile: imageFile[i], //image
          path: tempDir.path, //compress to path
          // quality: 100, //first compress quality, default 80
//      step: 9, //compress quality step, The bigger the fast, Smaller is more accurate, default 6
//      mode: CompressMode.LARGE2SMALL,//default AUTO
        );
        String? _path = await Luban.compressImage(compressObject);
        results.add(_path);
      }

      var time = DateTime.now().millisecondsSinceEpoch - time_start;
      Log.e("用时 ： " + time.toString());
      return results;
    }
    return null;
  }
}
