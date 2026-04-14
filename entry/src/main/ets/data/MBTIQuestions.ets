import { MBTIQuestion } from '../model/MBTIModel';

// 恋爱性格测试题目集合
export const mbtiQuestions: MBTIQuestion[] = [
  // E-I 维度题目（外向-内向）- 恋爱场景
  {
    id: 1,
    question: '约会时，你更喜欢怎样的氛围？',
    optionA: '去热闹的餐厅或酒吧，享受人群的活力',
    optionB: '找一家安静的咖啡馆，享受二人世界',
    dimension: 'EI',
    direction: 'A'
  },
  {
    id: 2,
    question: '认识新朋友时，你通常会：',
    optionA: '主动搭话，很快就能聊起来',
    optionB: '等对方先开口，慢慢熟悉后再打开心扉',
    dimension: 'EI',
    direction: 'A'
  },
  {
    id: 3,
    question: '和恋人吵架后，你更倾向于：',
    optionA: '立刻找对方沟通，把话说清楚',
    optionB: '先自己冷静思考，想好再说',
    dimension: 'EI',
    direction: 'A'
  },
  {
    id: 4,
    question: '你理想的周末约会是：',
    optionA: '和朋友一起聚会、K歌或参加派对',
    optionB: '和恋人窝在家看电影、做饭或散步',
    dimension: 'EI',
    direction: 'A'
  },

  // S-N 维度题目（感觉-直觉）- 恋爱场景
  {
    id: 5,
    question: '选择伴侣时，你更看重：',
    optionA: '对方的具体条件：外貌、收入、家庭背景',
    optionB: '和对方在一起的感觉：默契、心动、灵魂共鸣',
    dimension: 'SN',
    direction: 'A'
  },
  {
    id: 6,
    question: '回忆恋爱经历时，你更记得：',
    optionA: '具体的细节：那天穿了什么、吃了什么、去了哪里',
    optionB: '当时的感受和氛围：那种心跳加速的感觉',
    dimension: 'SN',
    direction: 'A'
  },
  {
    id: 7,
    question: '对于未来的感情生活，你更关注：',
    optionA: '务实的规划：买房、结婚时间、经济基础',
    optionB: '浪漫的想象：两个人一起环游世界、共同成长',
    dimension: 'SN',
    direction: 'A'
  },
  {
    id: 8,
    question: '恋人送你礼物，你更希望收到：',
    optionA: '实用贴心的东西：你正好需要的物品',
    optionB: '有特殊意义的物品：手工制作或象征回忆的东西',
    dimension: 'SN',
    direction: 'A'
  },

  // T-F 维度题目（思考-情感）- 恋爱场景
  {
    id: 9,
    question: '恋人向你倾诉烦恼时，你的第一反应是：',
    optionA: '帮TA分析问题，给出解决方案',
    optionB: '先抱抱TA，让TA知道你一直在',
    dimension: 'TF',
    direction: 'A'
  },
  {
    id: 10,
    question: '面对感情中的分歧，你更倾向于：',
    optionA: '理性讨论，找出最合理的解决方案',
    optionB: '照顾彼此的感受，寻找双方都能接受的方式',
    dimension: 'TF',
    direction: 'A'
  },
  {
    id: 11,
    question: '你觉得好的爱情应该是：',
    optionA: '两个人互相成就，共同进步',
    optionB: '两个人互相温暖，彼此依靠',
    dimension: 'TF',
    direction: 'A'
  },
  {
    id: 12,
    question: '分手后，你更可能：',
    optionA: '理性分析原因，总结经验教训',
    optionB: '先让自己好好哭一场，慢慢疗伤',
    dimension: 'TF',
    direction: 'A'
  },

  // J-P 维度题目（判断-知觉）- 恋爱场景
  {
    id: 13,
    question: '约会时，你更喜欢：',
    optionA: '提前规划好行程，按计划进行',
    optionB: '随心所欲，走到哪算哪',
    dimension: 'JP',
    direction: 'A'
  },
  {
    id: 14,
    question: '在恋爱关系中，你更希望：',
    optionA: '有明确的承诺和稳定的节奏',
    optionB: '保持新鲜感和灵活性，顺其自然',
    dimension: 'JP',
    direction: 'A'
  },
  {
    id: 15,
    question: '恋人的突然惊喜，你的反应是：',
    optionA: '虽然开心，但会担心打乱了原有安排',
    optionB: '非常惊喜，享受这种意料之外的快乐',
    dimension: 'JP',
    direction: 'A'
  },
  {
    id: 16,
    question: '对于感情的未来，你更倾向于：',
    optionA: '设定明确的目标和时间节点',
    optionB: '走一步看一步，享受当下的甜蜜',
    dimension: 'JP',
    direction: 'A'
  }
];
