/**
 * 心事述说馆 - 本地关系型数据库辅助类
 * 用于持久化用户心事、阅读历史和任务完成状态
 */
import { relationalStore } from '@kit.ArkData';
import { common } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

const DOMAIN = 0x0000;
const DB_NAME = 'HeartTalk.db';
const DB_VERSION = 1;

// 建表 SQL
const SQL_CREATE_CONFESSIONS = `
  CREATE TABLE IF NOT EXISTS confessions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    categoryId INTEGER NOT NULL,
    categoryName TEXT NOT NULL,
    content TEXT NOT NULL,
    responseTitle TEXT NOT NULL,
    responseBody TEXT NOT NULL
  )`;

const SQL_CREATE_READING_HISTORY = `
  CREATE TABLE IF NOT EXISTS reading_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    storyId INTEGER NOT NULL,
    readDate TEXT NOT NULL
  )`;

const SQL_CREATE_TASK_COMPLETIONS = `
  CREATE TABLE IF NOT EXISTS task_completions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    taskId INTEGER NOT NULL,
    isCompleted INTEGER NOT NULL DEFAULT 0,
    UNIQUE(date, taskId)
  )`;

class DatabaseHelper {
  private store: relationalStore.RdbStore | null = null;
  private initPromise: Promise<void> | null = null;

  static instance: DatabaseHelper = new DatabaseHelper();

  /**
   * 初始化数据库（在 EntryAbility.onCreate 中调用）
   */
  init(context: common.Context): void {
    if (this.store) {
      return;
    }
    if (this.initPromise) {
      return;
    }

    this.initPromise = (async () => {
      try {
        const config: relationalStore.StoreConfig = {
          name: DB_NAME,
          securityLevel: relationalStore.SecurityLevel.S1
        };
        this.store = await relationalStore.getRdbStore(context, config);
        await this.store.executeSql(SQL_CREATE_CONFESSIONS);
        await this.store.executeSql(SQL_CREATE_READING_HISTORY);
        await this.store.executeSql(SQL_CREATE_TASK_COMPLETIONS);
        hilog.info(DOMAIN, 'DatabaseHelper', 'Database initialized successfully');
      } catch (err) {
        hilog.error(DOMAIN, 'DatabaseHelper', 'Failed to init database: %{public}s', JSON.stringify(err));
      }
    })();
  }

  /** 等待初始化完成 */
  async ensureReady(): Promise<void> {
    if (this.initPromise) {
      await this.initPromise;
    }
  }

  // ═══════ 心事记录 ═══════

  /** 保存一条心事记录 */
  async insertConfession(
    categoryId: number, categoryName: string, content: string,
    responseTitle: string, responseBody: string
  ): Promise<number> {
    await this.ensureReady();
    if (!this.store) {
      return -1;
    }
    const date = new Date().toISOString();
    const valueBucket: relationalStore.ValuesBucket = {
      date: date,
      categoryId: categoryId,
      categoryName: categoryName,
      content: content,
      responseTitle: responseTitle,
      responseBody: responseBody
    };
    const rowId = await this.store.insert('confessions', valueBucket);
    hilog.info(DOMAIN, 'DatabaseHelper', 'Confession inserted, rowId: %{public}d', rowId);
    return rowId;
  }

  /** 获取所有心事记录（按时间倒序） */
  async getAllConfessions(): Promise<relationalStore.ValuesBucket[]> {
    await this.ensureReady();
    if (!this.store) {
      return [];
    }
    const predicates = new relationalStore.RdbPredicates('confessions');
    predicates.orderByDesc('id');
    const resultSet = await this.store.query(predicates);
    const rows: relationalStore.ValuesBucket[] = [];
    while (resultSet.goToNextRow()) {
      rows.push(resultSet.getRow());
    }
    resultSet.close();
    return rows;
  }

  /** 获取最新一条心事记录 */
  async getLatestConfession(): Promise<relationalStore.ValuesBucket | null> {
    await this.ensureReady();
    if (!this.store) {
      return null;
    }
    const predicates = new relationalStore.RdbPredicates('confessions');
    predicates.orderByDesc('id');
    predicates.limitAs(1);
    const resultSet = await this.store.query(predicates);
    let row: relationalStore.ValuesBucket | null = null;
    if (resultSet.goToNextRow()) {
      row = resultSet.getRow();
    }
    resultSet.close();
    return row;
  }

  // ═══════ 阅读历史 ═══════

  /** 标记一个故事为已读 */
  async addReadingHistory(storyId: number): Promise<void> {
    await this.ensureReady();
    if (!this.store) {
      return;
    }
    const date = new Date().toISOString();
    const valueBucket: relationalStore.ValuesBucket = {
      storyId: storyId,
      readDate: date
    };
    await this.store.insert('reading_history', valueBucket);
  }

  /** 获取所有已读故事的 ID 列表 */
  async getReadStoryIds(): Promise<number[]> {
    await this.ensureReady();
    if (!this.store) {
      return [];
    }
    const predicates = new relationalStore.RdbPredicates('reading_history');
    const resultSet = await this.store.query(predicates);
    const ids: number[] = [];
    while (resultSet.goToNextRow()) {
      ids.push(resultSet.getLong(resultSet.getColumnIndex('storyId')));
    }
    resultSet.close();
    return ids;
  }

  // ═══════ 任务完成 ═══════

  /** 获取今天的日期字符串 (YYYY-MM-DD) */
  private getTodayString(): string {
    const d = new Date();
    const y = d.getFullYear();
    const m = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `${y}-${m}-${day}`;
  }

  /** 标记今日任务为已完成（upsert 语义） */
  async completeTask(taskId: number): Promise<void> {
    await this.ensureReady();
    if (!this.store) {
      return;
    }
    const today = this.getTodayString();
    // 先查是否已有今天的记录
    const predicates = new relationalStore.RdbPredicates('task_completions');
    predicates.equalTo('date', today);
    predicates.equalTo('taskId', taskId);
    const resultSet = await this.store.query(predicates);
    if (resultSet.goToNextRow()) {
      const id = resultSet.getLong(resultSet.getColumnIndex('id'));
      resultSet.close();
      const updateBucket: relationalStore.ValuesBucket = { isCompleted: 1 };
      const updatePredicates = new relationalStore.RdbPredicates('task_completions');
      updatePredicates.equalTo('id', id);
      await this.store.update(updateBucket, updatePredicates);
    } else {
      resultSet.close();
      const valueBucket: relationalStore.ValuesBucket = {
        date: today,
        taskId: taskId,
        isCompleted: 1
      };
      await this.store.insert('task_completions', valueBucket);
    }
  }

  /** 检查指定任务今天是否已完成 */
  async isTaskCompleted(taskId: number): Promise<boolean> {
    await this.ensureReady();
    if (!this.store) {
      return false;
    }
    const today = this.getTodayString();
    const predicates = new relationalStore.RdbPredicates('task_completions');
    predicates.equalTo('date', today);
    predicates.equalTo('taskId', taskId);
    predicates.equalTo('isCompleted', 1);
    const resultSet = await this.store.query(predicates);
    const exists = resultSet.goToNextRow();
    resultSet.close();
    return exists;
  }

  /** 关闭数据库 */
  async close(): Promise<void> {
    if (this.store) {
      await this.store.close();
      this.store = null;
      this.initPromise = null;
    }
  }
}

export const dbHelper = DatabaseHelper.instance;
