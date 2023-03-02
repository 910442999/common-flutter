// To parse this JSON data, do
//
//     final locationsData = locationsDataFromJson(jsonString);

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

const singleData = {
  PickerType.sex: ['不限', '男', '女'],
  PickerType.education: ["高中以下", "高中", "大专", "本科", "硕士", "博士", "博士后", '其它'],
  PickerType.subject: ["语文", "数学", "英语", "物理", "化学", "生物", "政治", "地理", "历史"],
  PickerType.constellation: ["水瓶座", "双鱼座", "白羊座", "金牛座", "双子座", "巨蟹座", "狮子座", "处女座", "天秤座", "天蝎座", "射手座", "摩羯座"],
  PickerType.zodiac: ['鼠', '牛', '虎', '兔', '龙', '蛇', '马', '羊', '猴', '鸡', '狗', '猪'],
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
const multiData = {

};
