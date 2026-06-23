/**
 * 心事述说馆 - 自由流转（跨端迁移）状态管理
 * 用于在设备间迁移时保存和恢复应用状态
 */
import { preferences } from '@kit.ArkData';

// 跨端迁移状态键名常量
export const FF_KEY_CURRENT_PAGE = 'ff_currentPage';
export const FF_KEY_PAGE_PARAMS = 'ff_pageParams';

// Preferences 存储名
const PREF_NAME = 'freeFlowState';

/**
 * 书写页流转状态
 */
export interface FreeFlowWriteState {
  selectedCategoryId: number;
  writtenContent: string;
  categoryPrompt: string;
  isComplete: boolean;
}

/**
 * 回信页流转状态（含 AI 生成内容）
 */
export interface FreeFlowResponseState {
  categoryId: number;
  feelingCardId: number;
  responseIndex: number;
  responseRevealed: boolean;
  aiTitle: string;
  aiBody: string;
  aiFollowUp: string;
}

/**
 * 压力测试页流转状态
 */
export interface FreeFlowStressTestState {
  currentQuestionIndex: number;
  answers: number[];
  totalScore: number;
  isComplete: boolean;
}

/**
 * 治愈页流转状态
 */
export interface FreeFlowHealingState {
  taskIndex: number;
  quoteIndex: number;
  fortuneIndex: number;
  isTaskDone: boolean;
}

/**
 * 全局自由流转状态管理器
 * 各页面在状态变化时更新此对象，EntryAbility.onContinue 读取它来保存状态
 */
class FreeFlowStateManager {
  currentPage: string = 'pages/Index';
  pageParams: Record<string, Object> = {};
  /** 是否刚从跨端迁移恢复（由 EntryAbility 设置，Index 检查后重置） */
  isRestoredFromContinuation: boolean = false;

  /**
   * 更新当前页面和参数（各页面在 aboutToAppear 和关键状态变化时调用）
   */
  updateState(page: string, params: Record<string, Object>): void {
    this.currentPage = page;
    this.pageParams = params;
  }

  /**
   * 从 Want 恢复状态到管理器（EntryAbility 调用）
   */
  restoreFromWant(parameters: Record<string, Object>): void {
    const savedPage = parameters[FF_KEY_CURRENT_PAGE] as string;
    const savedParams = parameters[FF_KEY_PAGE_PARAMS] as Record<string, Object>;
    if (savedPage) {
      this.currentPage = savedPage;
      this.pageParams = savedParams || {};
      this.isRestoredFromContinuation = true;
    }
  }

  /**
   * 将当前状态写入 Want 参数（在 onContinue 中调用）
   */
  saveToWant(wantParam: Record<string, Object>): void {
    wantParam[FF_KEY_CURRENT_PAGE] = this.currentPage;
    wantParam[FF_KEY_PAGE_PARAMS] = this.pageParams;
  }

  /**
   * 获取恢复的页面参数
   */
  getRestoredParams(): Record<string, Object> {
    return this.pageParams;
  }

  /**
   * 检查是否有流转恢复数据
   */
  hasRestoreData(): boolean {
    return this.currentPage !== 'pages/Index' || Object.keys(this.pageParams).length > 0;
  }

  // ═══════ 调试用：获取当前状态快照 ═══════

  /**
   * 获取当前状态的 JSON 字符串（用于调试复制）
   */
  getStateSnapshot(): string {
    return JSON.stringify({
      currentPage: this.currentPage,
      pageParams: this.pageParams
    }, null, 2);
  }

  /**
   * 清空流转状态（恢复到首页默认）
   */
  clearState(): void {
    this.currentPage = 'pages/Index';
    this.pageParams = {};
    this.isRestoredFromContinuation = false;
  }
}

/** 全局单例 */
export const freeFlowState = new FreeFlowStateManager();
