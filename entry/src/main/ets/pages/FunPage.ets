/**
 * 心事述说馆 - 治愈角
 * 背景：图片 — 替换 bg_heal.png
 */
import router from '@ohos.router';
import { freeFlowState } from '../common/FreeFlowState';
import { healingQuotes, dailyTasks, moodFortunes } from '../data/HealingContent';
import { dbHelper } from '../data/DatabaseHelper';

@Entry
@Component
struct HealingPage {
  @State taskIndex: number = 0;
  @State quoteIndex: number = 0;
  @State fortuneIndex: number = 0;
  @State isTaskDone: boolean = false;

  aboutToAppear() {
    const rp = freeFlowState.hasRestoreData() ? freeFlowState.getRestoredParams() : null;
    const d = new Date();
    this.quoteIndex = rp?.['quoteIndex'] !== undefined ? rp['quoteIndex'] as number
      : (d.getDate() + d.getMonth()) % healingQuotes.length;
    this.taskIndex = rp?.['taskIndex'] !== undefined ? rp['taskIndex'] as number
      : (d.getFullYear() * 372 + d.getMonth() * 31 + d.getDate()) % dailyTasks.length;
    this.fortuneIndex = rp?.['fortuneIndex'] !== undefined ? rp['fortuneIndex'] as number
      : (d.getFullYear() + d.getMonth() + d.getDate()) % moodFortunes.length;
    this.syncFS(); this.checkTask();
  }
  async checkTask(): Promise<void> { this.isTaskDone = await dbHelper.isTaskCompleted(this.taskIndex + 1); }
  syncFS(): void {
    freeFlowState.updateState('pages/FunPage', {
      'taskIndex': this.taskIndex, 'quoteIndex': this.quoteIndex,
      'fortuneIndex': this.fortuneIndex, 'isTaskDone': this.isTaskDone
    });
  }
  nextQuote(): void { this.quoteIndex = (this.quoteIndex + 1) % healingQuotes.length; this.syncFS(); }
  nextTask(): void { this.taskIndex = (this.taskIndex + 1) % dailyTasks.length; this.checkTask(); this.syncFS(); }
  async toggleDone(): Promise<void> { this.isTaskDone = !this.isTaskDone; if (this.isTaskDone) { await dbHelper.completeTask(this.taskIndex + 1); }
    this.syncFS(); }
  nextFortune(): void { this.fortuneIndex = (this.fortuneIndex + 1) % moodFortunes.length; this.syncFS(); }
  goHome(): void { router.replaceUrl({ url: 'pages/Index' }); }

  build() {
    Column() {
      Row() {
        Button() { Text('←').fontSize(22).fontColor('#FFFFFF') }
        .width(44).height(44).backgroundColor(Color.Transparent).onClick(() => this.goHome())
        Text('今日治愈').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
          .layoutWeight(1).textAlign(TextAlign.Center)
        Blank().width(44)
      }
      .width('100%').height(52).backgroundColor('#C8896ECC').backdropBlur(12)

      Scroll() {
        Column() {
          // ── 每日一言 ──
          Column() {
            Text('每日一言').fontSize(12).fontColor('#BFB4A8')
              .padding({ left: 14, right: 14, top: 4, bottom: 4 })
              .backgroundColor('#F5F0EAB3').borderRadius(10).margin({ bottom: 18 })
            Text(healingQuotes[this.quoteIndex].emoji).fontSize(40).margin({ bottom: 14 })
            Text(healingQuotes[this.quoteIndex].content)
              .fontSize(20).fontColor('#3D3028').lineHeight(34)
              .fontWeight(FontWeight.Medium).textAlign(TextAlign.Center).margin({ bottom: 12 })
            Row() { Text('—').fontSize(12).fontColor('#D8CFC4') }
            .width('100%').justifyContent(FlexAlign.Center).margin({ bottom: 10 })
            Text(healingQuotes[this.quoteIndex].secondaryText).fontSize(13).fontColor('#BFB4A8')
            Button('换一句').fontSize(13).height(36).padding({ left: 22, right: 22 })
              .backgroundColor('#FFFFFF').fontColor('#C8896E')
              .border({ width: 1.5, color: '#C8896E', radius: 18 }).margin({ top: 18 })
              .onClick(() => this.nextQuote())
          }
          .width('88%').padding({ top: 24, bottom: 28, left: 24, right: 24 })
          .backgroundColor('#FFFFFFDD').borderRadius(20)
          .border({ width: 1, color: '#EDE6DE55' }).margin({ top: 20, bottom: 14 })
          .backdropBlur(12).alignItems(HorizontalAlign.Center)

          // ── 每日小任务 ──
          Column() {
            Text('今日小任务').fontSize(12).fontColor('#BFB4A8')
              .padding({ left: 14, right: 14, top: 4, bottom: 4 })
              .backgroundColor('#F5F0EAB3').borderRadius(10).margin({ bottom: 18 })
            Row() {
              Text(dailyTasks[this.taskIndex].emoji).fontSize(36).margin({ right: 14 })
              Column() {
                Text(dailyTasks[this.taskIndex].title).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#3D3028')
                Text(dailyTasks[this.taskIndex].secondaryText).fontSize(12).fontColor('#BFB4A8').margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start).layoutWeight(1)
            }
            .width('100%').margin({ bottom: 18 })
            Column() {
              Text(dailyTasks[this.taskIndex].content)
                .fontSize(18).fontColor('#3D3028').lineHeight(28)
                .fontWeight(FontWeight.Medium).textAlign(TextAlign.Center)
            }
            .width('100%').padding(20).backgroundColor(this.isTaskDone ? '#F2F5EF' : '#FDF8F4')
            .borderRadius(14).margin({ bottom: 20 })
            Row() {
              Button() {
                Row() {
                  Text(this.isTaskDone ? '✓' : '○').fontSize(18).margin({ right: 5 })
                  Text(this.isTaskDone ? '已完成' : '标记完成').fontSize(14)
                }
              }
              .height(42).padding({ left: 20, right: 20 })
              .backgroundColor(this.isTaskDone ? '#9BAF8A' : '#FFFFFF')
              .fontColor(this.isTaskDone ? '#FFFFFF' : '#9BAF8A')
              .border({ width: 1.5, color: '#9BAF8A', radius: 21 })
              .onClick(() => this.toggleDone())
              Blank().layoutWeight(1)
              Button('换一个').height(42).padding({ left: 20, right: 20 })
                .backgroundColor('#FFFFFF').fontColor('#C8896E')
                .border({ width: 1.5, color: '#C8896E', radius: 21 })
                .onClick(() => this.nextTask())
            }
            .width('100%')
          }
          .width('88%').padding({ top: 24, bottom: 26, left: 24, right: 24 })
          .backgroundColor('#FFFFFFDD').borderRadius(20)
          .border({ width: 1, color: '#EDE6DE55' }).margin({ bottom: 14 })
          .backdropBlur(12)

          // ── 心情签 ──
          Column() {
            Text('🏮').fontSize(20).margin({ bottom: 6 })
            Text('心情签').fontSize(12).fontColor('#FFFFFF').opacity(0.7).margin({ bottom: 24 })
            Text(moodFortunes[this.fortuneIndex].emoji).fontSize(48).margin({ bottom: 16 })
            Text(moodFortunes[this.fortuneIndex].keyword)
              .fontSize(28).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
              .letterSpacing(6).margin({ bottom: 18 })
            Text(moodFortunes[this.fortuneIndex].fortune)
              .fontSize(14).fontColor('#F5EBE4').lineHeight(26)
              .textAlign(TextAlign.Center).width('90%')
            Button('再抽一签').fontSize(13).fontWeight(FontWeight.Medium)
              .height(40).padding({ left: 26, right: 26 })
              .backgroundColor('#FFFFFFDD').fontColor('#C8896E').borderRadius(20)
              .margin({ top: 22 }).backdropBlur(12)
              .onClick(() => this.nextFortune())
          }
          .width('88%').padding({ top: 22, bottom: 32, left: 20, right: 20 })
          .linearGradient({ direction: GradientDirection.Top, colors: [['#C8896E', 0], ['#D4A373', 1]] })
          .borderRadius(22).margin({ bottom: 14 })
          .shadow({ radius: 16, color: '#C8896E44', offsetX: 0, offsetY: 8 })
          .alignItems(HorizontalAlign.Center)

          Text('返回首页').fontSize(14).fontColor('#BFB4A8')
            .onClick(() => this.goHome()).margin({ bottom: 28 })
        }
        .width('100%').alignItems(HorizontalAlign.Center)
      }
      .width('100%').layoutWeight(1).scrollBar(BarState.Off)
    }
    .width('100%').height('100%')
    .backgroundImage($r('app.media.bg_warm'))
    .backgroundImageSize(ImageSize.Cover)
  }
}
