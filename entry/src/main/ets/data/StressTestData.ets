/**
 * 心事述说馆 - 心理压力测试数据
 */
import { StressQuestion, StressResult } from '../model/HeartTalkModel';

/** 10 道压力测评题 */
export const stressQuestions: StressQuestion[] = [
  {
    id: 1,
    question: '你最近的睡眠质量如何？',
    options: [
      { text: '很好，躺下就能睡着', score: 0 },
      { text: '还行，偶尔会醒', score: 1 },
      { text: '不太好，入睡困难或早醒', score: 2 },
      { text: '很差，经常失眠', score: 3 }
    ]
  },
  {
    id: 2,
    question: '你最近感到紧张或焦虑的频率是？',
    options: [
      { text: '几乎没有', score: 0 },
      { text: '偶尔会感到', score: 1 },
      { text: '经常感到紧张', score: 2 },
      { text: '几乎每天都焦虑', score: 3 }
    ]
  },
  {
    id: 3,
    question: '你对日常活动的兴趣如何？',
    options: [
      { text: '对什么都很有兴趣', score: 0 },
      { text: '和以前差不多', score: 1 },
      { text: '提不起太大兴趣', score: 2 },
      { text: '对什么都没兴趣了', score: 3 }
    ]
  },
  {
    id: 4,
    question: '你最近的精力水平？',
    options: [
      { text: '精力充沛', score: 0 },
      { text: '一般，没什么特别', score: 1 },
      { text: '很容易感到疲劳', score: 2 },
      { text: '几乎没精力做任何事情', score: 3 }
    ]
  },
  {
    id: 5,
    question: '你对自己生活和工作的掌控感？',
    options: [
      { text: '尽在掌握之中', score: 0 },
      { text: '基本可控，偶尔手忙脚乱', score: 1 },
      { text: '感到有些吃力', score: 2 },
      { text: '完全失控的感觉', score: 3 }
    ]
  },
  {
    id: 6,
    question: '你最近与人交往的意愿？',
    options: [
      { text: '很愿意社交', score: 0 },
      { text: '还行，看心情', score: 1 },
      { text: '不太想理人', score: 2 },
      { text: '完全不想跟任何人说话', score: 3 }
    ]
  },
  {
    id: 7,
    question: '你有身体不适症状吗（头痛、胃痛、心慌等）？',
    options: [
      { text: '没有', score: 0 },
      { text: '偶尔有一点', score: 1 },
      { text: '经常出现不适', score: 2 },
      { text: '持续存在，影响生活', score: 3 }
    ]
  },
  {
    id: 8,
    question: '你觉得自己应对困难的能力怎样？',
    options: [
      { text: '完全能应付', score: 0 },
      { text: '基本可以应对', score: 1 },
      { text: '有时觉得应付不了', score: 2 },
      { text: '完全应付不过来', score: 3 }
    ]
  },
  {
    id: 9,
    question: '你对未来的感觉是？',
    options: [
      { text: '充满希望和期待', score: 0 },
      { text: '说不上来，顺其自然', score: 1 },
      { text: '有些担心和不安', score: 2 },
      { text: '感到很悲观', score: 3 }
    ]
  },
  {
    id: 10,
    question: '你在休息放松时，能真正放松下来吗？',
    options: [
      { text: '完全可以，休息完充满电', score: 0 },
      { text: '基本可以放松', score: 1 },
      { text: '脑子里还是很多事，难以放松', score: 2 },
      { text: '完全无法放松，不停在操心', score: 3 }
    ]
  }
];

/** 压力等级与建议 */
export const stressResults: Record<string, StressResult> = {
  'low': {
    level: '低压区',
    emoji: '🌿',
    scoreRange: '0 ~ 8 分',
    description: '你目前的压力水平较低，心理状态良好。生活中的小挑战对你来说都在可控范围内。',
    signals: ['情绪稳定', '睡眠良好', '精力充沛', '社交意愿正常'],
    advice: [
      '继续保持当前的生活节奏',
      '可以适当增加一些挑战，提升自己',
      '多关注周围人的情绪，成为他人的支持力量',
      '每周留出固定时间做自己喜欢的事'
    ],
    color: '#7CB342'
  },
  'moderate': {
    level: '轻度压力',
    emoji: '☀️',
    scoreRange: '9 ~ 16 分',
    description: '你正经历一些轻度压力，这其实是正常的——适度的压力可以推动我们前进。但也要注意适时放松。',
    signals: ['偶尔失眠或入睡困难', '有时会莫名烦躁', '对某些事失去耐心', '比平时更容易累'],
    advice: [
      '每天留出 10 分钟做深呼吸或冥想',
      '把让你焦虑的事情用纸笔列出来，逐个分析',
      '适当减少社交媒体的使用',
      '每周至少运动 2-3 次，哪怕只是散步'
    ],
    color: '#E67A3C'
  },
  'high': {
    level: '中度压力',
    emoji: '⛅',
    scoreRange: '17 ~ 24 分',
    description: '你的压力水平偏高，需要认真关注自己的心理健康了。很多身体的不适可能都源于这段时间的持续压力。',
    signals: ['睡眠质量明显下降', '经常感到疲劳和疲惫', '社交意愿显著降低', '可能出现身体不适症状'],
    advice: [
      '尝试建立规律的作息，尤其是固定的睡眠时间',
      '找一个信任的人聊聊天，把压力说出来',
      '暂时放下一些不必要的事情，学会说"不"',
      '如果持续两周以上没有好转，建议寻求专业心理帮助'
    ],
    color: '#FF9800'
  },
  'severe': {
    level: '高压区',
    emoji: '🌧️',
    scoreRange: '25 ~ 30 分',
    description: '你目前正在承受很大的压力，这已经对你的生活产生了明显影响。请务必重视并采取行动，你不需要一个人扛着。',
    signals: ['严重失眠或睡眠紊乱', '持续的心慌、胸闷等身体反应', '对几乎所有事情失去兴趣', '可能有无助感或绝望感'],
    advice: [
      '请务必给自己放个假，哪怕只有半天',
      '强烈建议找专业心理咨询师聊一聊',
      '不要独自承受，告诉身边亲近的人你的状态',
      '暂时减少工作负荷，健康永远是第一位的',
      '每天从一件小事开始重建掌控感，比如打扫房间'
    ],
    color: '#E53935'
  }
};

/** 根据总分获取压力等级 key */
export function getStressLevel(totalScore: number): string {
  if (totalScore <= 8) {
    return 'low';
  }
  if (totalScore <= 16) {
    return 'moderate';
  }
  if (totalScore <= 24) {
    return 'high';
  }
  return 'severe';
}
