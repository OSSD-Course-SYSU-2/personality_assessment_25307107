import { LoveAdvice } from '../model/MBTIModel';

// 16种MBTI类型的恋爱建议
export const loveAdviceData: Record<string, LoveAdvice> = {
  'INTJ': {
    type: 'INTJ',
    loveStyle: '理性而深沉的恋爱风格，追求精神层面的深度连接',
    idealPartner: ['智力相当', '独立自主', '有远见', '诚实可靠', '尊重个人空间'],
    bestMatch: ['ENFP', 'ENTP'],
    avoidMatch: ['ESFP', 'ISFP'],
    datingTips: [
      '选择有深度的活动，如博物馆、讲座或深度对话',
      '给对方足够的独立空间，也表达你的关心',
      '分享你的想法和计划，让对方参与你的世界',
      '学会表达情感，不要总是理性分析'
    ],
    communicationStyle: '直接、逻辑性强，需要学会表达情感',
    loveLanguage: ['高质量时间', '肯定的话语', '服务的行动'],
    challenges: ['过度理性', '情感表达困难', '高标准要求', '难以妥协']
  },
  'INTP': {
    type: 'INTP',
    loveStyle: '好奇而独立的恋爱风格，享受智力碰撞和精神交流',
    idealPartner: ['思想开放', '理解力强', '给予自由', '有共同兴趣', '不强迫社交'],
    bestMatch: ['ENTJ', 'ENFJ'],
    avoidMatch: ['ESFJ', 'ISFJ'],
    datingTips: [
      '选择轻松的活动，避免过度正式的约会',
      '分享你的想法和理论，寻找共同话题',
      '主动关心对方的感受，不要只顾思考',
      '承诺的事情要兑现，建立信任'
    ],
    communicationStyle: '分析性强，需要更直接和情感化',
    loveLanguage: ['高质量时间', '智力交流', '尊重空间'],
    challenges: ['情感疏离', '承诺困难', '过度分析', '忽视细节']
  },
  'ENTJ': {
    type: 'ENTJ',
    loveStyle: '自信而直接的恋爱风格，喜欢主导和规划关系发展',
    idealPartner: ['独立自信', '有野心', '支持目标', '直接坦诚', '有共同愿景'],
    bestMatch: ['INFP', 'INTP'],
    avoidMatch: ['ISFP', 'INFP'],
    datingTips: [
      '规划有意义的约会，展现你的用心',
      '倾听对方的想法，不要总是主导',
      '表达你的关心，不只是行动',
      '学会妥协，关系不是工作项目'
    ],
    communicationStyle: '直接、目标导向，需要学会倾听',
    loveLanguage: ['服务的行动', '高质量时间', '肯定的话语'],
    challenges: ['控制欲强', '缺乏耐心', '情感表达不足', '工作优先']
  },
  'ENTP': {
    type: 'ENTP',
    loveStyle: '充满活力和创意的恋爱风格，喜欢新鲜感和智力挑战',
    idealPartner: ['思想开放', '适应力强', '有幽默感', '独立思考', '喜欢辩论'],
    bestMatch: ['INFJ', 'INTJ'],
    avoidMatch: ['ISFJ', 'ISTJ'],
    datingTips: [
      '尝试新颖有趣的约会活动',
      '保持新鲜感，避免关系变得无聊',
      '认真对待承诺，不要只顾新奇',
      '学会倾听和关注对方的情感需求'
    ],
    communicationStyle: '机智、辩论性强，需要学会温柔',
    loveLanguage: ['智力交流', '高质量时间', '惊喜'],
    challenges: ['承诺困难', '容易厌倦', '情感不深', '过度辩论']
  },
  'INFJ': {
    type: 'INFJ',
    loveStyle: '深沉而理想主义的恋爱风格，追求灵魂伴侣般的连接',
    idealPartner: ['理解力强', '有深度', '真诚善良', '支持理想', '情感细腻'],
    bestMatch: ['ENFP', 'ENTP'],
    avoidMatch: ['ESTP', 'ESTJ'],
    datingTips: [
      '选择安静有深度的约会环境',
      '分享你的内心世界和理想',
      '给对方情感支持，也要接受关心',
      '不要过度理想化，接受对方的不完美'
    ],
    communicationStyle: '深刻、隐喻性强，需要更直接表达',
    loveLanguage: ['高质量时间', '肯定的话语', '情感支持'],
    challenges: ['过度理想化', '情感敏感', '难以表达需求', '自我牺牲']
  },
  'INFP': {
    type: 'INFP',
    loveStyle: '浪漫而理想主义的恋爱风格，追求真挚的情感连接',
    idealPartner: ['真诚善良', '理解力强', '尊重价值观', '有创造力', '情感细腻'],
    bestMatch: ['ENFJ', 'ENTJ'],
    avoidMatch: ['ESTJ', 'ESTP'],
    datingTips: [
      '选择有意义和浪漫的约会',
      '分享你的感受和价值观',
      '主动表达爱意，不要总是等待',
      '接受现实的不完美，不要过度理想化'
    ],
    communicationStyle: '温和、情感化，需要更直接表达需求',
    loveLanguage: ['肯定的话语', '高质量时间', '情感支持'],
    challenges: ['过度理想化', '情感脆弱', '回避冲突', '难以决定']
  },
  'ENFJ': {
    type: 'ENFJ',
    loveStyle: '热情而关怀的恋爱风格，致力于让对方幸福',
    idealPartner: ['欣赏关心', '有共同价值观', '愿意成长', '情感开放', '支持他人'],
    bestMatch: ['INFP', 'ISFP'],
    avoidMatch: ['ISTP', 'INTP'],
    datingTips: [
      '规划浪漫有意义的约会',
      '关注对方的需求，也要表达自己的',
      '不要过度付出，保持平衡',
      '接受对方的不同，不要试图改变'
    ],
    communicationStyle: '温暖、鼓励性强，需要学会接受',
    loveLanguage: ['肯定的话语', '高质量时间', '服务的行动'],
    challenges: ['过度付出', '忽视自己需求', '控制欲', '过度理想化']
  },
  'ENFP': {
    type: 'ENFP',
    loveStyle: '热情而浪漫的恋爱风格，充满创意和惊喜',
    idealPartner: ['思想开放', '有创造力', '支持梦想', '情感丰富', '喜欢冒险'],
    bestMatch: ['INFJ', 'INTJ'],
    avoidMatch: ['ISTJ', 'ISFJ'],
    datingTips: [
      '创造有趣和惊喜的约会体验',
      '分享你的想法和梦想',
      '保持专注，不要分心',
      '认真对待承诺，建立信任'
    ],
    communicationStyle: '热情、富有感染力，需要学会专注',
    loveLanguage: ['肯定的话语', '高质量时间', '惊喜'],
    challenges: ['容易分心', '承诺困难', '过度理想化', '情感波动']
  },
  'ISTJ': {
    type: 'ISTJ',
    loveStyle: '可靠而传统的恋爱风格，重视承诺和责任',
    idealPartner: ['可靠稳定', '尊重传统', '有责任感', '直接坦诚', '重视承诺'],
    bestMatch: ['ESFP', 'ESTP'],
    avoidMatch: ['ENFP', 'ENTP'],
    datingTips: [
      '规划传统而稳定的约会活动',
      '表达你的关心，不只是行动',
      '尝试新事物，保持关系新鲜感',
      '学会表达情感，不要只靠行动'
    ],
    communicationStyle: '直接、事实导向，需要学会表达情感',
    loveLanguage: ['服务的行动', '高质量时间', '礼物'],
    challenges: ['情感表达困难', '过度传统', '难以适应变化', '固执己见'],
  },
  'ISFJ': {
    type: 'ISFJ',
    loveStyle: '温柔而体贴的恋爱风格，默默付出和关心',
    idealPartner: ['感恩付出', '稳定可靠', '重视家庭', '情感细腻', '尊重传统'],
    bestMatch: ['ESFP', 'ENFP'],
    avoidMatch: ['ENTP', 'ENTJ'],
    datingTips: [
      '创造温馨舒适的约会环境',
      '表达你的需求，不要总是付出',
      '尝试新事物，不要过度保守',
      '接受对方的帮助和关心'
    ],
    communicationStyle: '温和、体贴，需要学会表达需求',
    loveLanguage: ['服务的行动', '肯定的话语', '高质量时间'],
    challenges: ['过度付出', '忽视自己需求', '难以表达需求', '抗拒变化']
  },
  'ESTJ': {
    type: 'ESTJ',
    loveStyle: '直接而传统的恋爱风格，重视家庭和责任',
    idealPartner: ['尊重传统', '有责任感', '直接坦诚', '重视家庭', '稳定可靠'],
    bestMatch: ['ISFP', 'ISTP'],
    avoidMatch: ['INFP', 'INTP'],
    datingTips: [
      '规划传统而有意义的约会',
      '表达你的关心，不只是提供物质',
      '倾听对方的想法，不要总是主导',
      '尝试理解对方的情感需求'
    ],
    communicationStyle: '直接、事实导向，需要学会情感表达',
    loveLanguage: ['服务的行动', '高质量时间', '礼物'],
    challenges: ['情感表达困难', '过度传统', '控制欲强', '难以妥协']
  },
  'ESFJ': {
    type: 'ESFJ',
    loveStyle: '温暖而关怀的恋爱风格，致力于创造和谐关系',
    idealPartner: ['感恩关心', '重视家庭', '社交活跃', '情感开放', '稳定可靠'],
    bestMatch: ['ISFP', 'INFP'],
    avoidMatch: ['INTP', 'INTJ'],
    datingTips: [
      '创造温馨社交的约会体验',
      '关注对方需求，也要表达自己的',
      '不要过度付出，保持平衡',
      '接受对方的不同，不要试图改变'
    ],
    communicationStyle: '温暖、关怀性强，需要学会接受不同',
    loveLanguage: ['肯定的话语', '服务的行动', '高质量时间'],
    challenges: ['过度付出', '忽视自己需求', '过度在意他人看法', '难以接受不同']
  },
  'ISTP': {
    type: 'ISTP',
    loveStyle: '独立而实际的恋爱风格，重视自由和行动',
    idealPartner: ['给予自由', '独立自主', '实际理性', '喜欢冒险', '不过度情感'],
    bestMatch: ['ESTJ', 'ESFJ'],
    avoidMatch: ['ENFJ', 'INFJ'],
    datingTips: [
      '选择活动性强的约会，如运动或探险',
      '用行动表达关心，不只是言语',
      '学会表达情感，不要总是沉默',
      '承诺的事情要兑现，建立信任'
    ],
    communicationStyle: '简洁、行动导向，需要学会情感表达',
    loveLanguage: ['服务的行动', '高质量时间', '身体接触'],
    challenges: ['情感表达困难', '承诺困难', '过度独立', '难以沟通']
  },
  'ISFP': {
    type: 'ISFP',
    loveStyle: '温柔而浪漫的恋爱风格，用行动表达爱意',
    idealPartner: ['欣赏艺术', '给予自由', '情感细腻', '理解力强', '不强迫表达'],
    bestMatch: ['ENFJ', 'ESFJ'],
    avoidMatch: ['ENTJ', 'ESTJ'],
    datingTips: [
      '创造浪漫有美感的约会体验',
      '用行动表达爱意，不要只靠言语',
      '学会表达你的需求和感受',
      '尝试更直接地沟通'
    ],
    communicationStyle: '温和、行动导向，需要学会直接表达',
    loveLanguage: ['服务的行动', '高质量时间', '礼物'],
    challenges: ['表达困难', '过度敏感', '难以决定', '回避冲突']
  },
  'ESTP': {
    type: 'ESTP',
    loveStyle: '充满活力和冒险的恋爱风格，享受当下',
    idealPartner: ['喜欢冒险', '适应力强', '直接坦诚', '享受当下', '不过度计划'],
    bestMatch: ['ISFJ', 'ISTJ'],
    avoidMatch: ['INFJ', 'INTJ'],
    datingTips: [
      '选择刺激有趣的约会活动',
      '享受当下，也要考虑未来',
      '认真对待承诺，建立信任',
      '学会倾听和关注对方的情感需求'
    ],
    communicationStyle: '直接、行动导向，需要学会倾听',
    loveLanguage: ['高质量时间', '身体接触', '惊喜'],
    challenges: ['承诺困难', '难以深入', '冲动行为', '忽视情感']
  },
  'ESFP': {
    type: 'ESFP',
    loveStyle: '热情而有趣的恋爱风格，让关系充满欢乐',
    idealPartner: ['喜欢社交', '享受生活', '适应力强', '有幽默感', '支持他人'],
    bestMatch: ['ISFJ', 'ISTJ'],
    avoidMatch: ['INTJ', 'INFJ'],
    datingTips: [
      '创造有趣社交的约会体验',
      '享受当下，也要考虑未来',
      '认真对待承诺，建立信任',
      '学会倾听和深度交流'
    ],
    communicationStyle: '热情、活泼，需要学会深度交流',
    loveLanguage: ['高质量时间', '肯定的话语', '惊喜'],
    challenges: ['承诺困难', '难以深入', '过度享乐', '忽视未来']
  }
};
