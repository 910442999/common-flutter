import 'dart:io';

import 'yq_file_suffix.dart';

class YQFileUtil {
  static int kilobyte = 1024;
  static int megabyte = 1024 * 1024;
  static int gigabyte = 1024 * 1024 * 1024;
  static String formatFileSize(int size) {
    if (size < kilobyte) {
      return "$size B";
    } else if (size < megabyte) {
      String sizeStr = (size / kilobyte).toStringAsFixed(2);
      return "$sizeStr KB";
    } else if (size < gigabyte) {
      String sizeStr = (size / megabyte).toStringAsFixed(2);
      return "$sizeStr MB";
    } else {
      String sizeStr = (size / gigabyte).toStringAsFixed(2);
      return "$sizeStr G";
    }
  }

  // 根据文件类型选择对应图片
  static String fileTypeImagePath(String fileName) {
    String imagePath;
    if (checkSuffix(fileName, YQFileSuffix.ImageFileSuffix))
      imagePath = "assets/images/file_message_icon_picture.png";
    else if (checkSuffix(fileName, YQFileSuffix.FileFileSuffix))
      imagePath = "assets/images/file_message_icon_file.png";
    else if (checkSuffix(fileName, YQFileSuffix.VideoFileSuffix))
      imagePath = "assets/images/file_message_icon_video.png";
    else if (checkSuffix(fileName, YQFileSuffix.AudioFileSuffix))
      imagePath = "assets/images/file_message_icon_audio.png";
    else if (checkSuffix(fileName, YQFileSuffix.WordFileSuffix))
      imagePath = "assets/images/file_message_icon_word.png";
    else if (checkSuffix(fileName, YQFileSuffix.ExcelFileSuffix))
      imagePath = "assets/images/file_message_icon_excel.png";
    else if (checkSuffix(fileName, YQFileSuffix.PptFileSuffix))
      imagePath = "assets/images/file_message_icon_ppt.png";
    else if (checkSuffix(fileName, YQFileSuffix.PdfFileSuffix))
      imagePath = "assets/images/file_message_icon_pdf.png";
    else if (checkSuffix(fileName, YQFileSuffix.ApkFileSuffix))
      imagePath = "assets/images/file_message_icon_apk.png";
    else if (checkSuffix(fileName, YQFileSuffix.KeyFileSuffix))
      imagePath = "assets/images/file_message_icon_key.png";
    else if (checkSuffix(fileName, YQFileSuffix.NumbersFileSuffix))
      imagePath = "assets/images/file_message_icon_numbers.png";
    else if (checkSuffix(fileName, YQFileSuffix.PagesFileSuffix))
      imagePath = "assets/images/file_message_icon_pages.png";
    else
      imagePath = "assets/images/file_message_icon_else.png";
    return imagePath;
  }

  static bool checkSuffix(String fileName, List fileSuffix) {
    for (String suffix in fileSuffix as Iterable<String>) {
      if (fileName != null) {
        if (fileName.toLowerCase().endsWith(suffix)) {
          return true;
        }
      }
    }
    return false;
  }

  static Future<File> writeStringToFile(
      String filePath, String fileName, String content) async {
    Directory file = Directory(filePath);
    if (!file.existsSync()) {
      file.create();
    }
    return File("$filePath/$fileName").writeAsString(content);
  }
}
