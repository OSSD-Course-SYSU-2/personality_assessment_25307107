/**
 * 心事述说馆 - 回信页
 * 背景：图片 — 替换 bg_letter.png
 */
import router from '@ohos.router';
import { freeFlowState } from '../common/FreeFlowState';

@Entry
@Component
struct ResponsePage {
  @State responseTitle: string = '';
  @State responseBody: string = '';
  @State responseFollowUp: string = '';
  @State categoryEmoji: string = '';
  @State categoryName: string = '';
  @State userContent: string = '';
  @State showRecap: boolean = false;

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    const rp = freeFlowState.hasRestoreData() ? freeFlowState.getRestoredParams() : null;
    this.responseTitle = (params?.['responseTitle'] || rp?.['aiTitle'] || '谢谢你愿意说出来') as string;
    this.responseBody = (params?.['responseBody'] || rp?.['aiBody'] || '你把心事写下来的那一刻，已经是一种勇敢。') as string;
    this.responseFollowUp = (params?.['responseFollowUp'] || rp?.['aiFollowUp'] || '愿你被世界温柔以待。') as string;
    this.categoryEmoji = (params?.['categoryEmoji'] || '') as string;
    this.categoryName = (params?.['categoryName'] || '') as string;
    this.userContent = (params?.['userContent'] || '') as string;
    freeFlowState.updateState('pages/ResultPage', {
      'categoryId': params?.['categoryId'] || -1, 'responseRevealed': true,
      'aiTitle': this.responseTitle, 'aiBody': this.responseBody, 'aiFollowUp': this.responseFollowUp
    });
  }

  goHome(): void { router.replaceUrl({ url: 'pages/Index' }); }
  writeAgain(): void { router.replaceUrl({ url: 'pages/TestPage' }); }

  build() {
    Column() {
      Row() {
        Button() { Text('←').fontSize(22).fontColor('#FFFFFF') }
        .width(44).height(44).backgroundColor(Color.Transparent).onClick(() => this.goHome())
        Text('💌 暖心回信').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
          .layoutWeight(1).textAlign(TextAlign.Center)
        Blank().width(44)
      }
      .width('100%').height(52).backgroundColor('#C8896ECC').backdropBlur(12)

      Scroll() {
        Column() {
          // 信笺
          Column() {
            Row() { Text('—·—·—').fontSize(10).fontColor('#EDE6DE') }
            .width('100%').justifyContent(FlexAlign.Center).margin({ bottom: 22 })

            if (this.categoryEmoji) {
              Row() {
                Text('收件人：').fontSize(12).fontColor('#BFB4A8')
                Text(this.categoryEmoji).fontSize(16).margin({ left: 2, right: 4 })
                Text(this.categoryName).fontSize(13).fontColor('#C8896E').fontWeight(FontWeight.Medium)
              }
              .width('100%').margin({ bottom: 20 })
            }

            Text(this.responseTitle)
              .fontSize(26).fontWeight(FontWeight.Bold).fontColor('#C8896E')
              .textAlign(TextAlign.Center).width('100%').margin({ bottom: 22 })

            Text(this.responseBody)
              .fontSize(15).fontColor('#4A3F35').lineHeight(30).textAlign(TextAlign.Start).width('100%').margin({ bottom: 28 })

            Row() { Text('·   ·   ·').fontSize(14).fontColor('#D8CFC4') }
            .width('100%').justifyContent(FlexAlign.Center).margin({ bottom: 18 })

            Text(this.responseFollowUp)
              .fontSize(14).fontColor('#BFB4A8').fontStyle(FontStyle.Italic)
              .textAlign(TextAlign.Center).width('100%').margin({ bottom: 20 })

            Row() {
              Column() {
                Text('心事述说馆').fontSize(13).fontColor('#C8A89A')
                Text(new Date().toISOString().split('T')[0]).fontSize(10).fontColor('#D8CFC4').margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%').justifyContent(FlexAlign.End)
            Row() { Text('—·—·—').fontSize(10).fontColor('#EDE6DE') }
            .width('100%').justifyContent(FlexAlign.Center).margin({ top: 16 })
          }
          .width('88%').padding(28).backgroundColor('#FFFFFFDD').borderRadius(20)
          .border({ width: 1, color: '#EDE6DE55' })
          .margin({ top: 20, bottom: 14 }).backdropBlur(12)

          if (this.userContent) {
            Column() {
              Row() {
                Text('📝 你写给树洞的话').fontSize(13).fontColor('#8B7D72').layoutWeight(1)
                Text(this.showRecap ? '收起 ▲' : '展开 ▼').fontSize(12).fontColor('#BFB4A8')
              }
              .width('100%').padding(16)
              .backgroundColor(this.showRecap ? '#FDF8F4' : '#FFFFFFDD').borderRadius(14)
              .border({ width: 1, color: '#EDE6DE55' })
              .onClick(() => { this.showRecap = !this.showRecap; })
              if (this.showRecap) {
                Column() {
                  Divider().width('100%').height(1).color('#EDE6DE').margin({ bottom: 14 })
                  Text(this.userContent).fontSize(14).fontColor('#6B5C4F').lineHeight(24).width('100%')
                }
                .width('100%').padding({ left: 16, right: 16, bottom: 16 })
                .backgroundColor('#FDF8F4').borderRadius({ bottomLeft: 14, bottomRight: 14 })
              }
            }
            .width('88%').margin({ bottom: 16 })
          }

          Button() {
            Row() { Text('🧪').fontSize(17).margin({ right: 8 }); Text('测测你的压力水平').fontSize(15).fontWeight(FontWeight.Medium) }
          }
          .width('88%').height(52).backgroundColor('#C8896E').fontColor('#FFFFFF').borderRadius(26)
          .margin({ bottom: 10 }).onClick(() => router.pushUrl({ url: 'pages/LoveAdvicePage' }))

          Button() {
            Row() { Text('🎁').fontSize(17).margin({ right: 8 }); Text('去治愈角放松一下').fontSize(15).fontWeight(FontWeight.Medium) }
          }
          .width('88%').height(52).backgroundColor('#FFFFFFDD').fontColor('#C8896E')
          .border({ width: 1.5, color: '#C8896E', radius: 26 }).margin({ bottom: 10 })
          .backdropBlur(12).onClick(() => router.pushUrl({ url: 'pages/FunPage' }))

          Button('再写一封心事')
            .width('88%').height(48).backgroundColor('#FFFFFFDD').fontColor('#C8896E')
            .border({ width: 1.5, color: '#C8896E', radius: 24 }).margin({ bottom: 10 })
            .backdropBlur(12).onClick(() => this.writeAgain())
          Text('返回首页').fontSize(14).fontColor('#BFB4A8').onClick(() => this.goHome()).margin({ bottom: 28 })
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
