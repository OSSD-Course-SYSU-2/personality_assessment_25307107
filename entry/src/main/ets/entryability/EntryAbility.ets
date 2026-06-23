import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { freeFlowState, FF_KEY_CURRENT_PAGE, FF_KEY_PAGE_PARAMS } from '../common/FreeFlowState';
import { dbHelper } from '../data/DatabaseHelper';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: object): void {
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    } catch (err) {
      hilog.error(DOMAIN, 'testTag', 'Failed to set colorMode. Cause: %{public}s', JSON.stringify(err));
    }
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');

    // 初始化本地数据库
    dbHelper.init(this.context);

    // 检查是否为跨端迁移启动（通过流转状态键判断）
    if (want.parameters && want.parameters[FF_KEY_CURRENT_PAGE]) {
      const params = want.parameters as Record<string, Object>;
      freeFlowState.restoreFromWant(params);
      hilog.info(DOMAIN, 'testTag', 'Restored from continuation, page: %{public}s',
        freeFlowState.currentPage);
    }
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // 如果是流转恢复，加载保存的页面；否则加载默认首页
    const loadPage = freeFlowState.hasRestoreData() ? freeFlowState.currentPage : 'pages/Index';
    hilog.info(DOMAIN, 'testTag', 'Loading page: %{public}s', loadPage);

    windowStage.loadContent(loadPage, (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }

  /**
   * 跨端迁移回调：在源设备上被调用，保存当前页面状态以便在新设备上恢复
   */
  onContinue(wantParam: Record<string, Object>): AbilityConstant.OnContinueResult {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onContinue, saving state...');
    freeFlowState.saveToWant(wantParam);
    hilog.info(DOMAIN, 'testTag', 'Saved page: %{public}s', freeFlowState.currentPage);
    return AbilityConstant.OnContinueResult.AGREE;
  }

  /**
   * 跨端迁移在新设备上恢复时调用（API 12+）
   */
  onNewWant(want: Want, launchParam: object): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onNewWant');
    if (want.parameters && want.parameters[FF_KEY_CURRENT_PAGE]) {
      const params = want.parameters as Record<string, Object>;
      freeFlowState.restoreFromWant(params);
      hilog.info(DOMAIN, 'testTag', 'onNewWant restored page: %{public}s', freeFlowState.currentPage);
    }
  }
}