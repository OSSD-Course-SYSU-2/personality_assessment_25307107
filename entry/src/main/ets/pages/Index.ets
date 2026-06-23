/**
 * 心事述说馆 - 首页
 */
import router from '@ohos.router';
import { freeFlowState } from '../common/FreeFlowState';

@Entry
@Component
struct Index {
  @State showDebugPanel: boolean = false;
  @State simCategoryId: number = 1;
  @State simResponseIdx: number = 0;
  @State simStressQIdx: number = 3;
  @State simTaskIdx: number = 1;

  aboutToAppear(): void {
    if (freeFlowState.isRestoredFromContinuation && freeFlowState.currentPage !== 'pages/Index') {
      const targetPage = freeFlowState.currentPage;
      const restoredParams = freeFlowState.getRestoredParams();
      freeFlowState.isRestoredFromContinuation = false;
      router.replaceUrl({ url: targetPage, params: restoredParams });
      return;
    }
    freeFlowState.updateState('pages/Index', {});
    freeFlowState.isRestoredFromContinuation = false;
  }

  simulateContinuation(page: string, params: Record<string, Object>): void {
    freeFlowState.updateState(page, params);
    router.pushUrl({ url: page, params: params });
  }

  greeting(): string {
    const h = new Date().getHours();
    if (h < 6) return '夜深了';
    if (h < 12) return '早安';
    if (h < 14) return '午安';
    if (h < 18) return '下午好';
    return '晚上好';
  }

  build() {
    Column() {
      // 头部
      Column() {
        Row() {
          Text('•').fontSize(10).fontColor('#FFFFFF').opacity(0.35)
          Blank()
          Text('•').fontSize(10).fontColor('#FFFFFF').opacity(0.35)
          Blank()
          Text('•').fontSize(10).fontColor('#FFFFFF').opacity(0.35)
        }
        .width('68%').margin({ bottom: 22 })

        Text(this.greeting())
          .fontSize(15).fontColor('#FFFFFF').opacity(0.85)
          .fontWeight(FontWeight.Medium).margin({ bottom: 10 })

        Text('心事述说馆')
          .fontSize(34).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
          .letterSpacing(5)

        Text('每一个心事都值得被温柔听见')
          .fontSize(13).fontColor('#FFFFFF').opacity(0.7)
          .margin({ top: 12, bottom: 16 })

        Divider().width(40).height(2).color('#FFFFFF').opacity(0.35)
      }
      .width('100%')
      .padding({ top: 40, bottom: 38 })
      .borderRadius({ bottomLeft: 38, bottomRight: 38 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#D4A37399', 0.0], ['#CB8D6EAA', 0.5], ['#C38063BB', 1.0]]
      })
      .backdropBlur(8)

      Scroll() {
        Column() {
          // 卡1：写下心事
          Column() {
            Row() {
              Column() { Text('✍️').fontSize(32) }
              .width(56).height(56).backgroundColor('#FDF5EE').borderRadius(18)
              .justifyContent(FlexAlign.Center).margin({ right: 16 })
              Column() {
                Text('写下心事').fontSize(19).fontWeight(FontWeight.Bold).fontColor('#3D3028')
                Text('选择一种心情，写下你想说的话').fontSize(13).fontColor('#8B7D72').margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start).layoutWeight(1)
            }
            .width('100%').margin({ bottom: 20 })
            Button() {
              Row() { Text('开始书写').fontSize(15).fontWeight(FontWeight.Medium); Text(' →').fontSize(15) }
            }
            .width('100%').height(48).backgroundColor('#C8896E').fontColor('#FFFFFF').borderRadius(24)
            .onClick(() => router.pushUrl({ url: 'pages/TestPage' }))
          }
          .width('88%').padding(22).backgroundColor('#FFFFFFDD').borderRadius(22)
          .margin({ top: 24, bottom: 14 })
          .backdropBlur(12)

          // 卡2：压力测试
          Column() {
            Row() {
              Column() { Text('🧪').fontSize(30) }
              .width(56).height(56).backgroundColor('#F6F2ED').borderRadius(18)
              .justifyContent(FlexAlign.Center).margin({ right: 16 })
              Column() {
                Text('压力小测试').fontSize(19).fontWeight(FontWeight.Bold).fontColor('#3D3028')
                Text('10道题快速评估你的压力水平').fontSize(13).fontColor('#8B7D72').margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start).layoutWeight(1)
            }
            .width('100%').margin({ bottom: 20 })
            Button('开始测试').width('100%').height(48).fontSize(15).fontWeight(FontWeight.Medium)
              .backgroundColor('#FFFFFF').fontColor('#C8896E')
              .border({ width: 1.5, color: '#C8896E', radius: 24 })
              .onClick(() => router.pushUrl({ url: 'pages/LoveAdvicePage' }))
          }
          .width('88%').padding(22).backgroundColor('#FFFFFFDD').borderRadius(22)
          .margin({ bottom: 14 }).backdropBlur(12)

          // 卡3：今日治愈
          Column() {
            Row() {
              Column() { Text('🎁').fontSize(30) }
              .width(56).height(56).backgroundColor('#F6F2ED').borderRadius(18)
              .justifyContent(FlexAlign.Center).margin({ right: 16 })
              Column() {
                Text('今日治愈').fontSize(19).fontWeight(FontWeight.Bold).fontColor('#3D3028')
                Text('每日一言 · 小任务 · 心情签').fontSize(13).fontColor('#8B7D72').margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start).layoutWeight(1)
            }
            .width('100%').margin({ bottom: 20 })
            Button('去治愈一下').width('100%').height(48).fontSize(15).fontWeight(FontWeight.Medium)
              .backgroundColor('#FFFFFF').fontColor('#C8896E')
              .border({ width: 1.5, color: '#C8896E', radius: 24 })
              .onClick(() => router.pushUrl({ url: 'pages/FunPage' }))
          }
          .width('88%').padding(22).backgroundColor('#FFFFFFDD').borderRadius(22)
          .margin({ bottom: 14 }).backdropBlur(12)

          Column() {
            Text('·  ·  ·').fontSize(16).fontColor('#D8CFC4')
          }
          .width('100%').alignItems(HorizontalAlign.Center).margin({ top: 16, bottom: 20 })

          // 调试面板
          Column() {
            Row() {
              Text('调试').fontSize(11).fontColor('#BFB4A8').layoutWeight(1)
              Text(this.showDebugPanel ? '收起' : '展开').fontSize(11).fontColor('#C8896E')
            }
            .width('100%').padding(12)
            .onClick(() => this.showDebugPanel = !this.showDebugPanel)
            if (this.showDebugPanel) {
              Column() {
                Row() {
                  Button(`书`).fontSize(10).height(28).backgroundColor('#FDF5EE').fontColor('#C8896E').border({ radius: 14 }).layoutWeight(1).margin({ right: 4 })
                    .onClick(() => this.simulateContinuation('pages/TestPage', { 'selectedCategoryId': this.simCategoryId, 'writtenContent': '测试...', 'isComplete': false }))
                  Button(`回`).fontSize(10).height(28).backgroundColor('#FDF5EE').fontColor('#C8896E').border({ radius: 14 }).layoutWeight(1).margin({ right: 4 })
                    .onClick(() => this.simulateContinuation('pages/ResultPage', { 'categoryId': 1, 'responseRevealed': true }))
                  Button(`压`).fontSize(10).height(28).backgroundColor('#FDF5EE').fontColor('#C8896E').border({ radius: 14 }).layoutWeight(1).margin({ right: 4 })
                    .onClick(() => this.simulateContinuation('pages/LoveAdvicePage', { 'currentQuestionIndex': 3, 'answers': JSON.stringify([1,2,1,0,...Array(6).fill(-1)]), 'totalScore': 0, 'isComplete': false }))
                  Button(`愈`).fontSize(10).height(28).backgroundColor('#FDF5EE').fontColor('#C8896E').border({ radius: 14 }).layoutWeight(1)
                    .onClick(() => this.simulateContinuation('pages/FunPage', { 'taskIndex': 1, 'quoteIndex': 2, 'fortuneIndex': 3 }))
                }
                .width('100%').margin({ bottom: 6 })
                Button('清空').fontSize(10).height(24).backgroundColor('#FFFFFF').fontColor('#BFB4A8').border({ radius: 12 })
                  .onClick(() => freeFlowState.clearState())
              }
              .width('100%').padding(10)
            }
          }
          .width('82%').backgroundColor('#FAFAFA').borderRadius(14).margin({ bottom: 24 })
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
