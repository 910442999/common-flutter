class YQHtmlUtil {
  /**
   * 过滤所有html中的标签仅保留文字
   */
  static RegExp REG_HTML = RegExp("<.*?>");

  /**
   * 去除img标签
   */

  static String delHtmlTags(String htmlStr) {
    htmlStr = htmlStr.replaceAll(REG_HTML, "");
    return htmlStr; // 返回文本字符串
  }

  /**
   * @param htmlStr
   * @return 删除Html标签
   */
  static String delImgTag(String htmlStr) {
    // 过滤html标签
   htmlStr = htmlStr.replaceAll("/<img\s*[^>]*>/i", "");
    return htmlStr;
  }
}
