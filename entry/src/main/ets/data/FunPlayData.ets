export interface FunQuizItem {
  question: string;
  optionA: string;
  optionB: string;
  answerA: string;
  answerB: string;
}

export interface FunTaskItem {
  title: string;
  subtitle: string;
  detail: string;
  emoji: string;
}

export interface FunMatchHintMap {
  INTJ: string;
  INTP: string;
  ENTJ: string;
  ENTP: string;
  INFJ: string;
  INFP: string;
  ENFJ: string;
  ENFP: string;
  ISTJ: string;
  ISFJ: string;
  ESTJ: string;
  ESFJ: string;
  ISTP: string;
  ISFP: string;
  ESTP: string;
  ESFP: string;
}

export const funTaskItems: FunTaskItem[] = [
  {
    title: '今天的恋爱小任务',
    subtitle: '主动表达一次心意',
    detail: '给喜欢的人发一句具体的夸奖，越真诚越好。',
    emoji: '💌'
  },
  {
    title: '今天的恋爱小任务',
    subtitle: '安排一个轻松约会',
    detail: '找一个不会太吵的地方，认真聊一次最近的生活。',
    emoji: '☕'
  },
  {
    title: '今天的恋爱小任务',
    subtitle: '制造一个小惊喜',
    detail: '准备一个对方会喜欢的小细节，不需要贵，但要有心。',
    emoji: '🎁'
  },
  {
    title: '今天的恋爱小任务',
    subtitle: '认真听完一次倾诉',
    detail: '今天只负责倾听，不急着给建议，先让对方被理解。',
    emoji: '👂'
  }
];

export const funQuizItems: FunQuizItem[] = [
  {
    question: '如果约会时间只剩 30 分钟，你更想做什么？',
    optionA: '找个安静角落慢慢聊天',
    optionB: '直接去一个有趣的地方冲一波',
    answerA: '你更看重情绪连接和稳定氛围。',
    answerB: '你更适合制造记忆点和新鲜感。'
  },
  {
    question: '对方临时改计划，你会更在意什么？',
    optionA: '提前说清楚，别让我措手不及',
    optionB: '只要最后好玩，临时变动也可以',
    answerA: '你需要可预期的安全感。',
    answerB: '你更擅长顺势而为。'
  },
  {
    question: '收到一个小礼物时，你最先注意的是？',
    optionA: '它实不实用，能不能派上用场',
    optionB: '它有没有心意，够不够特别',
    answerA: '你偏向务实型的表达和回应。',
    answerB: '你更容易被情绪价值打动。'
  }
];

export const funMoodTips: string[] = [
  '今天适合慢热型互动，别急着下结论。',
  '今天适合主动一点，先发出邀请再说。',
  '今天适合轻松相处，别把气氛搞太正式。',
  '今天适合做一个小惊喜，效果会比你想的大。'
];

export const funFortunes: string[] = [
  '今天的恋爱关键词是：主动。先开口的人，往往更容易拿到故事的下一页。',
  '今天的恋爱关键词是：松弛。把节奏放慢一点，反而更容易听到对方的真心。',
  '今天的恋爱关键词是：惊喜。一个小小的反转，会让关系突然变亮。',
  '今天的恋爱关键词是：理解。先接住情绪，再讨论对错，效果会更好。',
  '今天的恋爱关键词是：边界。保留一点空间，反而更有吸引力。'
];

export const funMatchHints: FunMatchHintMap = {
  INTJ: '你今天适合高质量对话，不适合无意义寒暄。',
  INTP: '你今天适合轻松玩梗，但别忘了回应对方的感受。',
  ENTJ: '你今天适合先听后说，别把互动变成安排会。',
  ENTP: '你今天适合制造新鲜感，也要记得收住节奏。',
  INFJ: '你今天适合安静表达，真诚比华丽更重要。',
  INFP: '你今天适合浪漫一点，但别只停在想象里。',
  ENFJ: '你今天适合照顾场面，也要留一点给自己。',
  ENFP: '你今天适合放大乐趣，但记得把承诺说清楚。',
  ISTJ: '你今天适合稳一点，稳定感会让你更舒服。',
  ISFJ: '你今天适合温柔回应，细节会加分。',
  ESTJ: '你今天适合直接一点，但别忘了留空间。',
  ESFJ: '你今天适合热情一点，气氛会被你带起来。',
  ISTP: '你今天适合用行动表达，比解释更有用。',
  ISFP: '你今天适合做一点有美感的小事。',
  ESTP: '你今天适合玩点刺激的，但别太冲动。',
  ESFP: '你今天适合快乐输出，注意别忽略对方节奏。'
};

export function getFunMatchHint(type: string): string {
  if (type === 'INTJ') {
    return funMatchHints.INTJ;
  }
  if (type === 'INTP') {
    return funMatchHints.INTP;
  }
  if (type === 'ENTJ') {
    return funMatchHints.ENTJ;
  }
  if (type === 'ENTP') {
    return funMatchHints.ENTP;
  }
  if (type === 'INFJ') {
    return funMatchHints.INFJ;
  }
  if (type === 'INFP') {
    return funMatchHints.INFP;
  }
  if (type === 'ENFJ') {
    return funMatchHints.ENFJ;
  }
  if (type === 'ENFP') {
    return funMatchHints.ENFP;
  }
  if (type === 'ISTJ') {
    return funMatchHints.ISTJ;
  }
  if (type === 'ISFJ') {
    return funMatchHints.ISFJ;
  }
  if (type === 'ESTJ') {
    return funMatchHints.ESTJ;
  }
  if (type === 'ESFJ') {
    return funMatchHints.ESFJ;
  }
  if (type === 'ISTP') {
    return funMatchHints.ISTP;
  }
  if (type === 'ISFP') {
    return funMatchHints.ISFP;
  }
  if (type === 'ESTP') {
    return funMatchHints.ESTP;
  }
  if (type === 'ESFP') {
    return funMatchHints.ESFP;
  }
  return '还没测过也没关系，先玩一个小彩蛋热热身。';
}