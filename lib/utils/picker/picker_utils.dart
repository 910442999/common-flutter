import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickers/more_pickers/init_data.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:intl/intl.dart';

const double kPickerHeight = 216.0;
const double kItemHeight = 40.0;
const Color kBtnColor = Color(0xFF323232); //50
const Color kTitleColor = Color(0xFF787878); //120
const double kTextFontSize = 17.0;

typedef DateCallback = void Function(dynamic selectDate);

typedef AddressCallback(String province, String city, String? town);

typedef SingleCallback(var data, int position);
typedef MultipleLinkCallback(List<dynamic> res, List<dynamic> position);

enum DateType {
  YM, // y ,m
  YMD, // y, m, d
  YMD_HM, // y, m, d, hh, mm
}
enum PickerType {
  sex, // 性别
  education, // 学历
  subject, // 学科
  constellation, // 星座
  zodiac, // 生肖
  ethnicity, // 名族
  height, // 身高
  weight, // 体重
  emotion, // 情感状态
  living, // 居住情况
  buyHouse, // 住房
  buyCar, // 购车
  income, // 年收入
  work, // 职业
}

var dataList = {
  PickerType.emotion: ['单身', '恋爱中', '离异', '丧偶', '已婚'],
  PickerType.living: ['租房自住', '与人合租', '住宿舍', '与父母同住', '住自己的房子'],
  PickerType.buyHouse: ['计划购房中', '已购房', '暂未购房'],
  PickerType.buyCar: ['已购车（豪华型）', '已购车（中档）', '已购车（经济性）', '暂未购车'],
  PickerType.income: [
    '5万以下',
    '5～10万',
    '10～20万',
    '20～30万',
    '30～40万',
    '40～50万',
    '50～60万',
    '60～70万',
    '70～80万',
    '80～90万',
    '90～100万',
    '100万以上'
  ],
};
var multiDataList = {
  PickerType.work: {
    "IT服务": ["计算机软件", "计算机硬件", "信息服务", "互联网和相关服务", "程序员", "其他"],
    "制造业": [
      "机械/电子",
      "服装/纺织",
      "汽车",
      "金属制品",
      "食品/饮料",
      "家具/家纺",
      "重工制造",
      "家电/数码",
      "橡胶/塑料",
      "日用品/化妆品",
      "化学原料制品",
      "文教/工美/体育/娱乐用品",
      "烟酒/茶",
      "非金属矿物",
      "其他"
    ],
    "批发/零售": ["批发", "零售", "超市/便利店/百货商场", "进出口", "其他"],
    "生活服务": ["餐饮", "居民服务", "租赁和商务服务", "酒店/住宿", "其他"],
    "文化/体育/娱乐业": ["文化/体育", "娱乐/旅游", "新闻传媒", "其他"],
    "建筑/房地产": ["建筑业", "建材装修", "房地产", "其他"],
    "教育": ["学前教育", "初中等教育", "高等教育", "培训机构", "其他"],
    "运输/物流/仓储": ["物流/仓储", "道路/铁路运输", "邮政/快递", "航空运输", "水上运输", "其他"],
    "医疗": ["医院/医疗机构", "医疗器械", "医药制造", "医药流通", "其他"],
    "政府": [
      "党政机关",
      "国家权力/行政机构",
      "检察院/法院/公安",
      "民政/人社/交通/卫生",
      "发改委/经信委/商务局/统计局",
      "国土/规划",
      "税务/海关/工商/环保/物价/药品",
      "政协/民主党派",
      "地方政府",
      "其他"
    ],
    "金融": ["保险", "银行", "证券/投资/基金", "其他"],
    "能源/采矿": ["电力/热力/燃气/水供应业", "石油/天然气", "煤炭", "有色金属", "钢铁", "其他"],
    "农林渔牧": ["农林渔牧"],
    "其他行业": ["科学研究和技术服务业", "社会组织", "水利和环境管理"],
  }
};

class PickerUtils {
  // /** 单列*/
  // static void showModalPicker<T>(BuildContext context, {
  //   @required List<T>? data,
  //   String? title,
  //   int? normalIndex,
  //   PickerDataAdapter? adapter,
  //   @required StringClickCallback? clickCallBack,
  // }) {
  //   openModalPicker(context,
  //       adapter: adapter ?? PickerDataAdapter(pickerdata: data, isArray: false),
  //       clickCallBack: (Picker picker, List<int> selecteds) {
  //         //          print(picker.adapter.text);
  //         clickCallBack!(selecteds[0], data![selecteds[0]]!);
  //       }, selecteds: [normalIndex ?? 0], title: title!);
  // }
  //
  // /** 单列*/
  // static void showDialogPicker<T>(BuildContext context, {
  //   @required List<T>? data,
  //   String? title,
  //   int? normalIndex,
  //   PickerDataAdapter? adapter,
  //   @required StringClickCallback? clickCallBack,
  // }) {
  //   openDialogPicker(context,
  //       adapter: adapter ?? PickerDataAdapter(pickerdata: data, isArray: false),
  //       clickCallBack: (Picker picker, List<int> selecteds) {
  //         clickCallBack!(selecteds[0], data![selecteds[0]]!);
  //       }, selecteds: [normalIndex ?? 0], title: title!);
  // }
  //
  // /** 多列 */
  // static void showMultipleModalPicker<T>(BuildContext context, {
  //   @required List<T>? data,
  //   String? title,
  //   List<int>? normalIndex,
  //   PickerDataAdapter? adapter,
  //   @required ArrayClickCallback? clickCallBack,
  // }) {
  //   openModalPicker(context,
  //       adapter: adapter ??
  //           PickerDataAdapter<T>(pickerdata: data, isArray: true),
  //       clickCallBack: (Picker picker, List<int> selecteds) {
  //         clickCallBack!(selecteds, picker.getSelectedValues());
  //       }, selecteds: normalIndex!, title: title!);
  // }
  //
  // /** 自定义多列 */
  // static Widget showDataPicker<T>(BuildContext context, {
  //   @required List<T>? data,
  //   String? title,
  //   List<int>? normalIndex,
  //   PickerDataAdapter? adapter,
  //   @required ArrayClickCallback? clickCallBack,
  //   @required DataCallback? dataCallback,
  // }) {
  //   Picker picker = new Picker(
  //     title: new Text(title ?? "请选择",
  //         style: TextStyle(color: kTitleColor, fontSize: kTextFontSize)),
  //     adapter: PickerDataAdapter<String>(pickerdata: data, isArray: true),
  //     cancelText: '取消',
  //     confirmText: '确定',
  //     cancelTextStyle: TextStyle(color: kBtnColor, fontSize: kTextFontSize),
  //     confirmTextStyle:
  //     TextStyle(color: Colours.app_main, fontSize: kTextFontSize),
  //     itemExtent: kItemHeight,
  //     height: kPickerHeight,
  //     selecteds: normalIndex,
  //     selectedTextStyle: TextStyle(color: Colors.black),
  //     onConfirm: (Picker picker, List<int> selecteds) {
  //       clickCallBack!(selecteds, picker.getSelectedValues());
  //     },
  //     onSelect: (Picker picker, int index, List<int> selecteds) {
  //       dataCallback!(selecteds, picker.getSelectedValues());
  //     },
  //   );
  //   return picker.makePicker();
  // }
  //
  // static void openModalPicker(BuildContext context, {
  //   @required PickerAdapter? adapter,
  //   String? title,
  //   List<int>? selecteds,
  //   @required PickerConfirmCallback? clickCallBack,
  // }) {
  //   new Picker(
  //       adapter: adapter!,
  //       title: new Text(title ?? "请选择",
  //           style: TextStyle(color: kTitleColor, fontSize: kTextFontSize)),
  //       selecteds: selecteds,
  //       cancelText: '取消',
  //       confirmText: '确定',
  //       cancelTextStyle:
  //       TextStyle(color: kBtnColor, fontSize: kTextFontSize),
  //       confirmTextStyle:
  //       TextStyle(color: kBtnColor, fontSize: kTextFontSize),
  //       textAlign: TextAlign.right,
  //       itemExtent: kItemHeight,
  //       height: kPickerHeight,
  //       selectedTextStyle: TextStyle(color: Colors.black),
  //       onConfirm: clickCallBack)
  //       .showModal(context);
  // }
  //
  // static void openDialogPicker(BuildContext context, {
  //   @required PickerAdapter? adapter,
  //   String? title,
  //   List<int>? selecteds,
  //   @required PickerConfirmCallback? clickCallBack,
  // }) {
  //   new Picker(
  //       hideHeader: true,
  //       adapter: adapter!,
  //       title: new Text(title ?? "请选择",
  //           style: TextStyle(color: kTitleColor, fontSize: kTextFontSize)),
  //       selecteds: selecteds,
  //       cancelText: '取消',
  //       confirmText: '确定',
  //       cancelTextStyle:
  //       TextStyle(color: kBtnColor, fontSize: kTextFontSize),
  //       confirmTextStyle:
  //       TextStyle(color: kBtnColor, fontSize: kTextFontSize),
  //       textAlign: TextAlign.right,
  //       itemExtent: kItemHeight,
  //       height: kPickerHeight,
  //       selectedTextStyle: TextStyle(color: Colors.black),
  //       onConfirm: clickCallBack)
  //       .showDialog(context);
  // }

  /** 日期选择器*/
  static void showDatePicker(
    BuildContext context, {
    DateType? dateType,
    String? title,
    DateTime? maxValue,
    DateTime? minValue,
    DateTime? value,
    @required DateCallback? callback,
  }) {
    DateMode mode;
    if (dateType == DateType.YM) {
      mode = DateMode.YM;
    } else if (dateType == DateType.YMD_HM) {
      mode = DateMode.YMDH;
    } else {
      mode = DateMode.YMD;
    }
    Pickers.showDatePicker(context,
        mode: mode,
        suffix: Suffix.normal(),
        selectDate: value == null ? null : PDuration.parse(value),
        minDate: minValue == null ? null : PDuration.parse(minValue),
        maxDate: maxValue == null ? null : PDuration.parse(maxValue),
        onConfirm: (time) {
      if (callback != null) {
        var timeStr = time.year.toString() +
            "-" +
            time.month.toString() +
            "-" +
            time.day.toString() +
            "-" +
            time.hour.toString() +
            ":" +
            time.minute.toString() +
            ":" +
            time.second.toString();
        var _dateTime = DateFormat("yyyy-MM-dd").parse(timeStr);
        callback(
            '${_dateTime.year}-${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.day.toString().padLeft(2, '0')}');
      }
    });
  }

  static void showAddressPicker(BuildContext context,
      {String initProvince = '',
      String initCity = '',
      String? initTown,
      AddressCallback? clickCallback}) {
    Pickers.showAddressPicker(
      context,
      initProvince: initProvince,
      initCity: initCity,
      initTown: initTown,
      addAllItem: false,
      onConfirm: (province, city, town) {
        if (clickCallback != null) {
          clickCallback(province, city, town);
        }
      },
    );
  }

  static void showSinglePicker(BuildContext context, var data, var selectData,
      {String? label, SingleCallback? callback}) {
    List mData = [];
    if (data is PickerType) {
      if (data == PickerType.sex) {
        mData = pickerData[PickerDataType.sex]!;
      } else if (data == PickerType.education) {
        mData = pickerData[PickerDataType.education]!;
      } else if (data == PickerType.subject) {
        mData = pickerData[PickerDataType.subject]!;
      } else if (data == PickerType.constellation) {
        mData = pickerData[PickerDataType.constellation]!;
      } else if (data == PickerType.zodiac) {
        mData = pickerData[PickerDataType.zodiac]!;
      } else if (data == PickerType.ethnicity) {
        mData = pickerData[PickerDataType.ethnicity]!;
      } else if (data == PickerType.emotion) {
        mData = dataList[PickerType.emotion]!;
      } else if (data == PickerType.living) {
        mData = dataList[PickerType.living]!;
      } else if (data == PickerType.buyHouse) {
        mData = dataList[PickerType.buyHouse]!;
      } else if (data == PickerType.buyCar) {
        mData = dataList[PickerType.buyCar]!;
      } else if (data == PickerType.income) {
        mData = dataList[PickerType.income]!;
      } else if (data == PickerType.height) {
        mData.addAll(
            List.generate(120, (index) => (100 + index).toString() + "cm"));
        mData.add("220cm以上");
      } else if (data == PickerType.weight) {
        mData.addAll(
            List.generate(100, (index) => (30 + index).toString() + "kg"));
        mData.add("130kg以上");
      }
    } else if (data is List) {
      mData.addAll(data);
    }

    Pickers.showSinglePicker(
      context,
      data: mData,
      selectData: selectData,
      pickerStyle: DefaultPickerStyle(),
      suffix: label,
      onConfirm: (p, position) {
        if (callback != null) {
          callback(p, position);
        }
      },
    );
  }

  static Future<void> showMultiLinkPicker(
      BuildContext context, var data, var selectData, var columeNum,
      {var label, MultipleLinkCallback? callback}) async {
    Map mData = Map();
    if (data is PickerType) {
      if (data == PickerType.work) {
        // mData = multiDataList[PickerType.work]!;
        var jsonStr = await rootBundle.loadString('assets/data/job1.json');
        Map<String, dynamic> map = json.decode(jsonStr) as Map<String, dynamic>;
        var level0 = map["level0"];
        var level1 = map["level1"];
        level0.forEach((key, value) {
          print("--key, value--${key} ${value}");
          List list = [];
          level1.forEach((v) {
            var pid = v['pid'];
            if (pid == key) {
              var title = v['title'];
              list.add(title);
            }
          });
          mData[value] = list;
        });
      }
    } else if (data is Map) {
      mData.addAll(data);
    }
    Pickers.showMultiLinkPicker(
      context,
      data: mData,
      // 注意数据类型要对应 比如 44442 写成字符串类型'44442'，则找不到
      // selectData: ['c', 'cc', 'cccc33', 'ccc4-2', 44442],
      selectData: selectData,
      columeNum: columeNum,
      // suffix: ['', '', '', '', ''],
      suffix: label,
      onConfirm: (List p, List<int> position) {
        print('longer >>> 返回数据：$p');
        print('longer >>> 返回数据：${p.join('、')}');
        print('longer >>> 返回数据下标：${position.join('、')}');
        if (callback != null) {
          callback(p, position);
        }
      },
    );
  }
}
