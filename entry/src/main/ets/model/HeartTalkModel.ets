/**
 * 心事述说馆 - 数据模型
 */

/** 心事类别卡片 */
export interface FeelingCard {
  id: number;
  category: string;     // 类别名，如 "最近有点焦虑"
  emoji: string;        // 对应 emoji
  prompt: string;       // 引导书写提示
  curatedResponses: CuratedResponse[];
}

/** 温暖回信 */
export interface CuratedResponse {
  title: string;        // 回信标题
  body: string;         // 回信正文
  followUp: string;     // 结尾语
}

/** 压力测试题 */
export interface StressQuestion {
  id: number;
  question: string;
  options: StressOption[];
}

/** 压力测试选项 */
export interface StressOption {
  text: string;
  score: number;
}

/** 压力测试结果 */
export interface StressResult {
  level: string;
  emoji: string;
  scoreRange: string;
  description: string;
  signals: string[];
  advice: string[];
  color: string;
}

/** 治愈内容 */
export interface HealingItem {
  id: number;
  type: 'quote' | 'task';
  emoji: string;
  title: string;
  content: string;
  secondaryText: string;
}

/** 心情签 */
export interface MoodFortune {
  id: number;
  keyword: string;
  fortune: string;
  emoji: string;
}

/** 数据库记录：用户心事 */
export interface ConfessionRecord {
  id: number;
  date: string;
  categoryId: number;
  categoryName: string;
  content: string;
  responseTitle: string;
  responseBody: string;
}

/** 数据库记录：阅读历史 */
export interface ReadingHistory {
  id: number;
  storyId: number;
  readDate: string;
}

/** 数据库记录：任务完成 */
export interface TaskCompletion {
  id: number;
  date: string;
  taskId: number;
  isCompleted: number;
}
