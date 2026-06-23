/**
 * 心事述说馆 - 治愈内容数据（每日一言 / 小任务 / 心情签）
 */
import { HealingItem, MoodFortune } from '../model/HeartTalkModel';

/** 每日一言 */
export const healingQuotes: HealingItem[] = [
  {
    id: 1,
    type: 'quote',
    emoji: '✨',
    title: '每日一言',
    content: '你不需要变得完美才值得被爱。',
    secondaryText: '—— 未知'
  },
  {
    id: 2,
    type: 'quote',
    emoji: '🌸',
    title: '每日一言',
    content: '温柔地对待自己，你不是机器，你是一个正在努力的人。',
    secondaryText: '—— 村上春树'
  },
  {
    id: 3,
    type: 'quote',
    emoji: '🌿',
    title: '每日一言',
    content: '不必匆忙，不必火花四溅。不必成为别人，只需做自己。',
    secondaryText: '—— 弗吉尼亚·伍尔夫'
  },
  {
    id: 4,
    type: 'quote',
    emoji: '☕',
    title: '每日一言',
    content: '生活不是要战胜别人，而是每天比昨天的自己好一点点。',
    secondaryText: '—— 未知'
  },
  {
    id: 5,
    type: 'quote',
    emoji: '🕯️',
    title: '每日一言',
    content: '你远比你想象的更坚强，也比你相信的更温柔。',
    secondaryText: '—— 未知'
  },
  {
    id: 6,
    type: 'quote',
    emoji: '🐚',
    title: '每日一言',
    content: '海边的贝壳有破碎的也有完整的，但每一片都有它自己的美。',
    secondaryText: '—— 未知'
  },
  {
    id: 7,
    type: 'quote',
    emoji: '🌻',
    title: '每日一言',
    content: '向日葵永远面向太阳，但它的根深深扎在土里。美好和坚韧可以共存。',
    secondaryText: '—— 未知'
  }
];

/** 每日小任务 */
export const dailyTasks: HealingItem[] = [
  {
    id: 1,
    type: 'task',
    emoji: '📝',
    title: '今日小任务',
    content: '写下今天让你感到开心的三件小事。',
    secondaryText: '哪怕是"今天天气很好"也值得记下来'
  },
  {
    id: 2,
    type: 'task',
    emoji: '🫂',
    title: '今日小任务',
    content: '给一个好久没联系的朋友发一条消息，不用很长，一句"最近好吗"就够了。',
    secondaryText: '连接会让人感到温暖'
  },
  {
    id: 3,
    type: 'task',
    emoji: '🧘',
    title: '今日小任务',
    content: '找一个安静的地方，闭上眼睛，深呼吸十次。',
    secondaryText: '什么都不用想，只感受呼吸'
  },
  {
    id: 4,
    type: 'task',
    emoji: '🎵',
    title: '今日小任务',
    content: '听一首能让你心情变好的歌，然后单曲循环三遍。',
    secondaryText: '音乐是最好的情绪药方之一'
  },
  {
    id: 5,
    type: 'task',
    emoji: '🚶',
    title: '今日小任务',
    content: '出去走十分钟，不用去哪，就从家门口走到街角再回来。',
    secondaryText: '换个环境，有时候心态就换了'
  },
  {
    id: 6,
    type: 'task',
    emoji: '🍵',
    title: '今日小任务',
    content: '给自己泡一杯热饮，慢慢喝，不要一边喝一边做别的事。',
    secondaryText: '你的生活值得被认真对待'
  }
];

/** 心情签 */
export const moodFortunes: MoodFortune[] = [
  {
    id: 1,
    keyword: '温柔',
    fortune: '今天，允许自己脆弱，也允许自己坚强。温柔地对待每一个情绪。',
    emoji: '🌸'
  },
  {
    id: 2,
    keyword: '勇气',
    fortune: '你比自己想象的更勇敢。今天迈出一小步，哪怕只是说了一句真心话。',
    emoji: '🦋'
  },
  {
    id: 3,
    keyword: '释怀',
    fortune: '有些事不需要答案。今天试着放下一个纠结了很久的念头。',
    emoji: '🍃'
  },
  {
    id: 4,
    keyword: '等待',
    fortune: '好事需要时间。今天，耐心地等一等，别急着下结论。',
    emoji: '⏳'
  },
  {
    id: 5,
    keyword: '感恩',
    fortune: '今天找三件你感谢的事情，它们会像灯笼一样照亮你的心情。',
    emoji: '🏮'
  },
  {
    id: 6,
    keyword: '放松',
    fortune: '今天不给自己设任何目标。存在的本身就足够有意义。',
    emoji: '☁️'
  },
  {
    id: 7,
    keyword: '希望',
    fortune: '不管昨天怎样，今天都是新的。你永远可以重新开始。',
    emoji: '🌟'
  },
  {
    id: 8,
    keyword: '真诚',
    fortune: '对别人真诚很难，对自己真诚更难。今天至少对自己说一句实话。',
    emoji: '💎'
  }
];
