/**
 * 心事述说馆 - 压力自测
 * 背景：图片 — 替换 bg_test.png
 */
import router from '@ohos.router';
import { freeFlowState } from '../common/FreeFlowState';
import { stressQuestions, stressResults, getStressLevel } from '../data/StressTestData';
import { StressQuestion, StressResult, StressOption } from '../model/HeartTalkModel';

@Entry
@Component
struct StressTestPage {
  @State currentQuestionIndex: number = 0;
  @State answers: number[] = new Array(stressQuestions.length).fill(-1);
  @State totalScore: number = 0;
  @State isComplete: boolean = false;
  @State result: StressResult | null = null;
  @State resultKey: string = '';

  aboutToAppear() {
    const rp = freeFlowState.hasRestoreData() ? freeFlowState.getRestoredParams() : null;
    if (rp?.['currentQuestionIndex'] !== undefined) { this.currentQuestionIndex = rp['currentQuestionIndex'] as number; }
    if (rp?.['answers']) { this.answers = JSON.parse(rp['answers'] as string); }
    else { this.answers = new Array(stressQuestions.length).fill(-1); }
    if (rp?.['totalScore'] !== undefined) {
      this.totalScore = rp['totalScore'] as number;
      this.isComplete = rp['isComplete'] as boolean;
      if (this.isComplete) { this.resultKey = getStressLevel(this.totalScore);
        this.result = stressResults[this.resultKey]; }
    }
    this.syncFS();
  }
  syncFS(): void {
    freeFlowState.updateState('pages/LoveAdvicePage', {
      'currentQuestionIndex': this.currentQuestionIndex, 'answers': JSON.stringify(this.answers),
      'totalScore': this.totalScore, 'isComplete': this.isComplete
    });
  }
  selectOption(score: number): void {
    this.answers[this.currentQuestionIndex] = score;
    if (this.currentQuestionIndex < stressQuestions.length - 1) { this.currentQuestionIndex++; }
    else { this.totalScore = this.answers.reduce((s: number, v: number) => s + (v >= 0 ? v : 0), 0);
      this.isComplete = true;
      this.resultKey = getStressLevel(this.totalScore);
      this.result = stressResults[this.resultKey]; }
    this.syncFS();
  }
  prevQ(): void { if (this.currentQuestionIndex > 0) { this.currentQuestionIndex--; this.syncFS(); } }
  restart(): void { this.currentQuestionIndex = 0;
    this.answers = new Array(stressQuestions.length).fill(-1);
    this.totalScore = 0; this.isComplete = false; this.result = null; this.resultKey = '';
    this.syncFS(); }
  goBack(): void { router.back(); }
  goHome(): void { router.replaceUrl({ url: 'pages/Index' }); }

  @Builder
  resultView(rs: StressResult, total: number) {
    Scroll() {
      Column() {
        Column() {
          Text(rs.emoji).fontSize(56).margin({ bottom: 14 })
          Text('你的压力水平').fontSize(14).fontColor('#FFFFFF').opacity(0.8).margin({ bottom: 6 })
          Text(rs.level).fontSize(34).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
            .letterSpacing(3).margin({ bottom: 8 })
          Text('得分：' + total + ' 分').fontSize(14).fontColor('#FFFFFF').opacity(0.75)
        }
        .width('88%').padding({ top: 30, bottom: 30 }).backgroundColor(rs.color).borderRadius(22)
        .margin({ top: 18, bottom: 14 }).shadow({ radius: 14, color: rs.color + '44', offsetX: 0, offsetY: 8 })
        .alignItems(HorizontalAlign.Center)

        Column() {
          Text(rs.description).fontSize(15).fontColor('#3D3028').lineHeight(26).textAlign(TextAlign.Center)
        }
        .width('88%').padding(22).backgroundColor('#FFFFFFDD').borderRadius(18)
        .border({ width: 1, color: '#EDE6DE55' }).margin({ bottom: 14 }).backdropBlur(12)

        Column() {
          Row() { Text('🔍').fontSize(18).margin({ right: 10 }); Text('你可能正在经历的').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#3D3028') }
          .width('100%').margin({ bottom: 14 })
          ForEach(rs.signals, (signal: string) => {
            Row() {
              Text('•').fontSize(16).fontColor(rs.color).margin({ right: 12 })
              Text(signal).fontSize(15).fontColor('#3D3028').lineHeight(22).layoutWeight(1)
            }
            .width('100%').margin({ bottom: 10 }).alignItems(VerticalAlign.Top)
          })
        }
        .width('88%').padding(22).backgroundColor('#FFFFFFDD').borderRadius(18)
        .border({ width: 1, color: '#EDE6DE55' }).margin({ bottom: 14 }).backdropBlur(12)

        Column() {
          Row() { Text('💡').fontSize(18).margin({ right: 10 }); Text('给你的建议').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#3D3028') }
          .width('100%').margin({ bottom: 14 })
          ForEach(rs.advice, (tip: string, index: number) => {
            Row() {
              Text((index + 1) + '.').fontSize(15).fontWeight(FontWeight.Bold).fontColor(rs.color).margin({ right: 10 })
              Text(tip).fontSize(15).fontColor('#3D3028').lineHeight(22).layoutWeight(1)
            }
            .width('100%').margin({ bottom: 12 }).alignItems(VerticalAlign.Top)
          })
        }
        .width('88%').padding(22).backgroundColor('#FFFFFFDD').borderRadius(18)
        .border({ width: 1, color: '#EDE6DE55' }).margin({ bottom: 16 }).backdropBlur(12)

        Text('⚕️ 本测试仅供参考，不构成专业心理诊断').fontSize(11).fontColor('#BFB4A8')
          .textAlign(TextAlign.Center).width('80%').margin({ bottom: 18 })
        Button('🔄 重新测试').width('88%').height(50).backgroundColor('#FFFFFFDD')
          .fontColor('#C8896E').border({ width: 1.5, color: '#C8896E', radius: 25 }).margin({ bottom: 10 })
          .backdropBlur(12).onClick(() => this.restart())
        Text('返回首页').fontSize(14).fontColor('#BFB4A8').onClick(() => this.goHome()).margin({ bottom: 28 })
      }
      .width('100%').alignItems(HorizontalAlign.Center)
    }
    .width('100%').layoutWeight(1).scrollBar(BarState.Off)
  }

  build() {
    Column() {
      Row() {
        Button() { Text('←').fontSize(22).fontColor('#FFFFFF') }
        .width(44).height(44).backgroundColor(Color.Transparent).onClick(() => this.goBack())
        Text('🧪 压力自测').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
          .layoutWeight(1).textAlign(TextAlign.Center)
        Blank().width(44)
      }
      .width('100%').height(52).backgroundColor('#C8896ECC').backdropBlur(12)

      if (!this.isComplete) {
        Column() {
          Row() {
            Text('第 ' + (this.currentQuestionIndex + 1) + ' / ' + stressQuestions.length).fontSize(12).fontColor('#BFB4A8')
            Blank()
            Text(Math.round((this.currentQuestionIndex / stressQuestions.length) * 100) + '%').fontSize(12).fontColor('#C8896E')
          }
          .width('88%').margin({ top: 18, bottom: 8 })
          Progress({ value: this.currentQuestionIndex, total: stressQuestions.length, type: ProgressType.Linear })
            .width('88%').color('#C8896E').backgroundColor('#EDE6DE').height(5).borderRadius(3)
        }
        .width('100%').alignItems(HorizontalAlign.Center)

        Scroll() {
          Column() {
            Column() {
              Text('Q' + (this.currentQuestionIndex + 1) + '.').fontSize(20).fontWeight(FontWeight.Bold)
                .fontColor('#D8CFC4').margin({ bottom: 10 }).width('100%')
              Text(stressQuestions[this.currentQuestionIndex].question)
                .fontSize(18).fontWeight(FontWeight.Medium).fontColor('#3D3028').lineHeight(28).width('100%')
            }
            .width('88%').padding(24).backgroundColor('#FFFFFFDD').borderRadius(18)
            .border({ width: 1, color: '#EDE6DE55' })
            .shadow({ radius: 8, color: '#D8CFC4', offsetX: 0, offsetY: 4 })
            .backdropBlur(12).margin({ top: 28, bottom: 18 })

            ForEach(stressQuestions[this.currentQuestionIndex].options, (opt: StressOption) => {
              Button(opt.text)
                .width('88%').height(56).fontSize(15).fontColor('#3D3028')
                .backgroundColor('#FFFFFFDD').border({ width: 1, color: '#EDE6DE55', radius: 16 })
                .margin({ bottom: 10 }).backdropBlur(12)
                .onClick(() => this.selectOption(opt.score))
            })
            if (this.currentQuestionIndex > 0) {
              Text('← 上一题').fontSize(13).fontColor('#BFB4A8').margin({ top: 12, bottom: 24 }).onClick(() => this.prevQ())
            }
          }
          .width('100%').alignItems(HorizontalAlign.Center)
        }
        .width('100%').layoutWeight(1).scrollBar(BarState.Off)
      } else if (this.result) {
        this.resultView(this.result, this.totalScore)
      }
    }
    .width('100%').height('100%')
    .backgroundImage($r('app.media.bg_warm'))
    .backgroundImageSize(ImageSize.Cover)
  }
}
