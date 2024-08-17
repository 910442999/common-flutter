// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_picker/picker.dart';
// import 'data/yq_ethnicity_data.dart';
// import 'data/yq_locations_data.dart';
// import 'data/yq_picker_data.dart';
// import 'data/yq_work_data.dart';
//
// const double kPickerHeight = 216.0;
// const double kItemHeight = 40.0;
// const Color kBtnColor = Color(0xFF323232); //50
// const Color kTitleColor = Color(0xFF787878); //120
// const double kTextFontSize = 17.0;
//
// class YQPickerUtils {
//   /** 日期选择器*/
//   static void showDatePicker(BuildContext context, {
//     YQDateType? dateType,
//     String? title,
//     DateTime? maxValue,
//     DateTime? minValue,
//     DateTime? value,
//     DateTimePickerAdapter? adapter,
//     String? cancelText,
//     VoidCallback? onCancel,
//     required Function(dynamic selectDateStr, dynamic selectDate) clickCallback,
//   }) {
//     int timeType;
//     if (dateType == YQDateType.YM) {
//       timeType = PickerDateTimeType.kYM;
//     } else if (dateType == YQDateType.YMD_HM) {
//       timeType = PickerDateTimeType.kYMDHM;
//     } else {
//       timeType = PickerDateTimeType.kYMD;
//     }
//
//     openModalPicker(context,
//         adapter: adapter ??
//             DateTimePickerAdapter(
//               type: timeType,
//               isNumberMonth: true,
//               yearSuffix: "年",
//               monthSuffix: "月",
//               daySuffix: "日",
//               // strAMPM: const ["上午", "下午"],
//               maxValue: maxValue ?? DateTime.now(),
//               minValue: minValue,
//               value: value ?? DateTime.now(),
//             ),
//         title: title,
//         cancelText: cancelText,
//         clickCallBack: (Picker picker, List<int> selecteds) {
//           var time = (picker.adapter as DateTimePickerAdapter).value;
//           var timeStr =
//               '${time!.year.toString()}-${time.month.toString().padLeft(
//               2, '0')}-${time.day.toString().padLeft(2, '0')}';
//           print(timeStr + "-------" + "------" + picker.adapter.text);
//           clickCallback(timeStr, picker.adapter.text);
//         },
//         onCancel: onCancel);
//   }
//
//   /**
//    * 地址
//    */
//   static void showAddressPicker(BuildContext context,
//       {required Function(List<dynamic> strData, List<
//           int> selecteds) clickCallBack}) async {
//     List<PickerItem> provinces2 = [];
//     for (var element in locations) {
//       List<PickerItem> city = [];
//       for (var element2 in element['children'] as List) {
//         city.add(PickerItem(text: null, value: element2['label']));
//       }
//       provinces2
//           .add(PickerItem(text: null, value: element['label'], children: city));
//     }
//     openModalPicker(context, adapter: PickerDataAdapter(data: provinces2),
//         clickCallBack: (Picker picker, List<int> selecteds) {
//           print(selecteds.toString());
//           print(picker.getSelectedValues());
//           clickCallBack(picker.getSelectedValues(), selecteds);
//         });
//   }
//
//   /** 职业 */
//   static void showWorkPicker(BuildContext context, {
//     String? title,
//     List<int>? normalIndex,
//     PickerDataAdapter? adapter,
//     required Function(List<dynamic> strData, List<int> selecteds) clickCallBack,
//   }) {
//     List<PickerItem> work1 = [];
//     for (var element in workData) {
//       List<PickerItem> work2 = [];
//       for (var element2 in element['children'] as List) {
//         work2.add(PickerItem(text: null, value: element2['label']));
//       }
//       work1.add(
//           PickerItem(text: null, value: element['label'], children: work2));
//     }
//     openModalPicker(context,
//         adapter: adapter ?? PickerDataAdapter(data: work1),
//         clickCallBack: (Picker picker, List<int> selecteds) {
//           print(selecteds.toString());
//           print(picker.getSelectedValues());
//           clickCallBack(picker.getSelectedValues(), selecteds);
//         }, selecteds: normalIndex, title: title);
//   }
//
//   /** 单列*/
//   static void showSinglePicker<T>(BuildContext context, {
//     required var data,
//     String? title,
//     int? normalIndex,
//     PickerDataAdapter? adapter,
//     required Function(int selectIndex, String selectStr) clickCallBack,
//   }) {
//     List mData = [];
//     if (data is YQPickerType) {
//       if (data == YQPickerType.sex) {
//         mData = singleData[YQPickerType.sex]!;
//       } else if (data == YQPickerType.education) {
//         mData = singleData[YQPickerType.education]!;
//       } else if (data == YQPickerType.subject) {
//         mData = singleData[YQPickerType.subject]!;
//       } else if (data == YQPickerType.constellation) {
//         mData = singleData[YQPickerType.constellation]!;
//       } else if (data == YQPickerType.zodiac) {
//         mData = singleData[YQPickerType.zodiac]!;
//       } else if (data == YQPickerType.ethnicity) {
//         mData = ethnicityData;
//       } else if (data == YQPickerType.emotion) {
//         mData = singleData[YQPickerType.emotion]!;
//       } else if (data == YQPickerType.living) {
//         mData = singleData[YQPickerType.living]!;
//       } else if (data == YQPickerType.buyHouse) {
//         mData = singleData[YQPickerType.buyHouse]!;
//       } else if (data == YQPickerType.buyCar) {
//         mData = singleData[YQPickerType.buyCar]!;
//       } else if (data == YQPickerType.income) {
//         mData = singleData[YQPickerType.income]!;
//       } else if (data == YQPickerType.height) {
//         mData.addAll(
//             List.generate(120, (index) => (100 + index).toString() + "cm"));
//         mData.add("220cm以上");
//       } else if (data == YQPickerType.weight) {
//         mData.addAll(
//             List.generate(100, (index) => (30 + index).toString() + "kg"));
//         mData.add("130kg以上");
//       }
//     } else if (data is List) {
//       mData.addAll(data);
//     }
//     openModalPicker(context,
//         adapter:
//         adapter ?? PickerDataAdapter(pickerData: mData, isArray: false),
//         clickCallBack: (Picker picker, List<int> selecteds) {
//           clickCallBack(selecteds[0], mData[selecteds[0]].toString());
//         }, selecteds: [normalIndex ?? 0], title: title);
//   }
//
//   /** 单列*/
//   static void showDialogPicker<T>(BuildContext context, {
//     required List<T> data,
//     String? title,
//     int? normalIndex,
//     PickerDataAdapter? adapter,
//     required Function(int selectIndex, Object? selectStr) clickCallBack,
//   }) {
//     openDialogPicker(context,
//         adapter: adapter ?? PickerDataAdapter(pickerData: data, isArray: false),
//         clickCallBack: (Picker picker, List<int> selecteds) {
//           clickCallBack(selecteds[0], data[selecteds[0]]);
//         }, selecteds: [normalIndex ?? 0], title: title);
//   }
//
//   /** 多列 */
//   static void showMultiPicker<T>(BuildContext context, {
//     required var data,
//     String? title,
//     List<int>? normalIndex,
//     PickerDataAdapter? adapter,
//     required Function(List<int> selecteds, List<dynamic> strData) clickCallBack,
//   }) {
//     openModalPicker(context,
//         adapter: adapter ?? PickerDataAdapter(pickerData: data, isArray: true),
//         clickCallBack: (Picker picker, List<int> selecteds) {
//           clickCallBack(selecteds, picker.getSelectedValues());
//         }, selecteds: normalIndex, title: title);
//   }
//
//   /** 自定义多列 */
//   static Widget showDataPicker<T>(BuildContext context, {
//     required List<T> data,
//     String? title,
//     List<int>? normalIndex,
//     PickerDataAdapter? adapter,
//     Function(List<int> selecteds, List<dynamic> strData)? clickCallBack,
//     Future<bool> Function(List<int> selecteds, List<dynamic> strData)?
//     clickBeforeCallBack,
//     Function(List<int> selecteds, List<dynamic> strData)? dataCallback,
//   }) {
//     Color primaryColor = Theme.of(context).primaryColor;
//     Picker picker = Picker(
//       title: Text(title ?? "请选择",
//           style: const TextStyle(color: kTitleColor, fontSize: kTextFontSize)),
//       adapter: PickerDataAdapter<String>(pickerData: data, isArray: true),
//       cancelText: '取消',
//       confirmText: '确定',
//       cancelTextStyle:
//       const TextStyle(color: kBtnColor, fontSize: kTextFontSize),
//       confirmTextStyle: TextStyle(color: primaryColor, fontSize: kTextFontSize),
//       itemExtent: kItemHeight,
//       height: kPickerHeight,
//       selecteds: normalIndex,
//       selectedTextStyle: const TextStyle(color: Colors.black),
//       onConfirm: clickCallBack == null
//           ? null
//           : (Picker picker, List<int> selecteds) {
//         clickCallBack(selecteds, picker.getSelectedValues());
//       },
//       onConfirmBefore: clickBeforeCallBack == null
//           ? null
//           : (picker, selected) async {
//         return clickBeforeCallBack(selected, picker.getSelectedValues());
//       },
//       onSelect: dataCallback == null
//           ? null
//           : (Picker picker, int index, List<int> selecteds) {
//         dataCallback(selecteds, picker.getSelectedValues());
//       },
//     );
//     return picker.makePicker();
//   }
//
//   static void openModalPicker(BuildContext context, {
//     required PickerAdapter adapter,
//     String? title,
//     String? cancelText,
//     List<int>? selecteds,
//     VoidCallback? onCancel,
//     required PickerConfirmCallback clickCallBack,
//   }) {
//     Picker(
//         adapter: adapter,
//         title: Text(title ?? "请选择",
//             style: TextStyle(color: kTitleColor, fontSize: kTextFontSize)),
//         selecteds: selecteds,
//         cancelText: cancelText ?? '取消',
//         confirmText: '确定',
//         cancelTextStyle:
//         TextStyle(color: kBtnColor, fontSize: kTextFontSize),
//         confirmTextStyle:
//         TextStyle(color: kBtnColor, fontSize: kTextFontSize),
//         textAlign: TextAlign.right,
//         itemExtent: kItemHeight,
//         height: kPickerHeight,
//         selectedTextStyle: TextStyle(color: Colors.black),
//         onCancel: onCancel,
//         onConfirm: clickCallBack)
//         .showModal(context);
//   }
//
//   static void openDialogPicker(BuildContext context, {
//     required PickerAdapter adapter,
//     String? title,
//     List<int>? selecteds,
//     required PickerConfirmCallback clickCallBack,
//   }) {
//     Picker(
//         hideHeader: true,
//         adapter: adapter,
//         title: new Text(title ?? "请选择",
//             style: TextStyle(color: kTitleColor, fontSize: kTextFontSize)),
//         selecteds: selecteds,
//         cancelText: '取消',
//         confirmText: '确定',
//         cancelTextStyle:
//         TextStyle(color: kBtnColor, fontSize: kTextFontSize),
//         confirmTextStyle:
//         TextStyle(color: kBtnColor, fontSize: kTextFontSize),
//         textAlign: TextAlign.right,
//         itemExtent: kItemHeight,
//         height: kPickerHeight,
//         selectedTextStyle: TextStyle(color: Colors.black),
//         onConfirm: clickCallBack)
//         .showDialog(context);
//   }
// }
