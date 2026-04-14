// MBTI测试题目数据模型
export interface MBTIQuestion {
  id: number;
  question: string;
  optionA: string;
  optionB: string;
  dimension: 'EI' | 'SN' | 'TF' | 'JP'; // 四个维度
  direction: 'A' | 'B'; // A选项对应维度的哪个方向
}

// MBTI测试结果
export interface MBTIResult {
  type: string; // 如 "INTJ"
  description: string;
  characteristics: string[];
  strengths: string[];
  weaknesses: string[];
  careers: string[];
}

// 维度得分
export interface DimensionScores {
  E: number; // 外向
  I: number; // 内向
  S: number; // 感觉
  N: number; // 直觉
  T: number; // 思考
  F: number; // 情感
  J: number; // 判断
  P: number; // 知觉
}

// 恋爱建议数据模型
export interface LoveAdvice {
  type: string; // MBTI类型
  loveStyle: string; // 恋爱风格
  idealPartner: string[]; // 理想伴侣特质
  bestMatch: string[]; // 最佳匹配类型
  avoidMatch: string[]; // 需要注意的类型
  datingTips: string[]; // 约会建议
  communicationStyle: string; // 沟通方式
  loveLanguage: string[]; // 爱的语言
  challenges: string[]; // 恋爱中的挑战
}
