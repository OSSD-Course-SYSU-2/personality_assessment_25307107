import { MBTIResult } from '../model/MBTIModel';
import { mbtiResults } from '../data/MBTIResults';
import { loveAdviceData } from '../data/LoveAdviceData';
import router from '@ohos.router';

@Entry
@Component
struct ResultPage {
  @State resultType: string = '';
  @State result: MBTIResult | null = null;

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params && params['resultType']) {
      this.resultType = params['resultType'] as string;
      this.result = mbtiResults[this.resultType];
    }
  }

  restartTest() {
    router.replaceUrl({
      url: 'pages/TestPage'
    });
  }

  goHome() {
    router.replaceUrl({
      url: 'pages/Index'
    });
  }

  build() {
    Column() {
      // 顶部标题栏
      Column() {
        Text('💕 你的恋爱性格')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .height(60)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#E91E63', 0], ['#C2185B', 1]]
      })
      .justifyContent(FlexAlign.Center)

      if (this.result) {
        Scroll() {
          Column() {
            // MBTI类型展示 - 恋爱主题
            Column() {
              Text('你的恋爱性格是')
                .fontSize(14)
                .fontColor('#E91E63')
                .margin({ bottom: 8 })

              Text(this.resultType)
                .fontSize(52)
                .fontWeight(FontWeight.Bold)
                .fontColor('#E91E63')
                .margin({ bottom: 10 })

              Text(this.result.description)
                .fontSize(16)
                .fontColor('#666666')
                .textAlign(TextAlign.Center)
                .width('85%')
                .lineHeight(24)
            }
            .width('100%')
            .margin({ top: 25, bottom: 20 })
            .padding(20)
            .backgroundColor('#FFF0F5')
            .borderRadius(15)

            // 分享卡片
            Column() {
              Row() {
                Text('✨')
                  .fontSize(20)
                  .margin({ right: 8 })
                Text('结果分享卡片')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
              }
              .margin({ bottom: 14 })

              Text(this.resultType)
                .fontSize(44)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .margin({ bottom: 8 })

              Text(this.result.description)
                .fontSize(15)
                .fontColor('#FFF5F7')
                .textAlign(TextAlign.Center)
                .lineHeight(22)
                .width('92%')
                .margin({ bottom: 14 })

              Row() {
                Column() {
                  Text('性格亮点')
                    .fontSize(12)
                    .fontColor('#FFDCE6')
                    .margin({ bottom: 6 })
                  Text(this.result.strengths[0])
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FFFFFF')
                }
                .width('45%')

                Column() {
                  Text('最佳匹配')
                    .fontSize(12)
                    .fontColor('#FFDCE6')
                    .margin({ bottom: 6 })
                  Text(loveAdviceData[this.resultType].bestMatch[0])
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FFFFFF')
                }
                .width('45%')
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ bottom: 14 })

              Text('截图这张卡片，发给朋友一起看你的恋爱风格。')
                .fontSize(12)
                .fontColor('#FFE7EE')
            }
            .width('100%')
            .padding(20)
            .backgroundColor('#E91E63')
            .borderRadius(18)
            .margin({ bottom: 20 })
            .shadow({ radius: 10, color: '#F7B4C7', offsetX: 0, offsetY: 5 })

            // 恋爱性格特点
            Column() {
              Row() {
                Text('💘')
                  .fontSize(18)
                  .margin({ right: 8 })
                Text('恋爱性格特点')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
              }
              .margin({ bottom: 12 })

              ForEach(this.result.characteristics, (item: string) => {
                Row() {
                  Text('•')
                    .fontSize(16)
                    .fontColor('#E91E63')
                    .margin({ right: 8 })
                  Text(item)
                    .fontSize(15)
                    .fontColor('#333333')
                }
                .width('100%')
                .margin({ bottom: 8 })
                .alignItems(VerticalAlign.Top)
              })
            }
            .width('90%')
            .padding(18)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 15 })
            .shadow({ radius: 5, color: '#FFE0E6', offsetX: 0, offsetY: 2 })

            // 恋爱中的优势
            Column() {
              Row() {
                Text('💚')
                  .fontSize(18)
                  .margin({ right: 8 })
                Text('恋爱中的优势')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
              }
              .margin({ bottom: 12 })

              Flex({ wrap: FlexWrap.Wrap }) {
                ForEach(this.result.strengths, (item: string) => {
                  Text(item)
                    .fontSize(14)
                    .fontColor('#FFFFFF')
                    .backgroundColor('#4CAF50')
                    .borderRadius(15)
                    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                    .margin({ right: 8, bottom: 8 })
                })
              }
              .width('100%')
            }
            .width('90%')
            .padding(18)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 15 })
            .shadow({ radius: 5, color: '#FFE0E6', offsetX: 0, offsetY: 2 })

            // 恋爱中的劣势
            Column() {
              Row() {
                Text('💛')
                  .fontSize(18)
                  .margin({ right: 8 })
                Text('需要注意的方面')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
              }
              .margin({ bottom: 12 })

              Flex({ wrap: FlexWrap.Wrap }) {
                ForEach(this.result.weaknesses, (item: string) => {
                  Text(item)
                    .fontSize(14)
                    .fontColor('#FFFFFF')
                    .backgroundColor('#FF9800')
                    .borderRadius(15)
                    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                    .margin({ right: 8, bottom: 8 })
                })
              }
              .width('100%')
            }
            .width('90%')
            .padding(18)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 15 })
            .shadow({ radius: 5, color: '#FFE0E6', offsetX: 0, offsetY: 2 })

            // 最佳匹配预览（核心亮点）
            Column() {
              Row() {
                Text('💑')
                  .fontSize(18)
                  .margin({ right: 8 })
                Text('你的最佳伴侣')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
              }
              .margin({ bottom: 12 })

              Row() {
                ForEach(loveAdviceData[this.resultType].bestMatch, (item: string) => {
                  Column() {
                    Text(item)
                      .fontSize(20)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#FFFFFF')
                  }
                  .width(65)
                  .height(65)
                  .backgroundColor('#E91E63')
                  .borderRadius(32)
                  .justifyContent(FlexAlign.Center)
                  .margin({ right: 15 })
                })

                Column() {
                  Text('...')
                    .fontSize(20)
                    .fontColor('#E91E63')
                }
                .width(65)
                .height(65)
                .backgroundColor('#FFF0F5')
                .borderRadius(32)
                .justifyContent(FlexAlign.Center)
              }
              .width('100%')
            }
            .width('90%')
            .padding(18)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 20 })
            .shadow({ radius: 5, color: '#FFE0E6', offsetX: 0, offsetY: 2 })

            // 查看完整恋爱建议按钮（核心功能入口）
            Button() {
              Row() {
                Text('💕')
                  .fontSize(22)
                  .margin({ right: 8 })
                Text('查看完整恋爱建议')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
              }
            }
            .width('90%')
            .height(60)
            .backgroundColor('#E91E63')
            .fontColor('#FFFFFF')
            .borderRadius(30)
            .shadow({ radius: 12, color: '#E91E63', offsetX: 0, offsetY: 6 })
            .margin({ bottom: 20 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/LoveAdvicePage',
                params: {
                  resultType: this.resultType
                }
              });
            })

            Button('去玩趣味玩法')
              .width('90%')
              .height(52)
              .backgroundColor('#FFF0F5')
              .fontColor('#E91E63')
              .border({ width: 1, color: '#F6B3C6', radius: 26 })
              .margin({ bottom: 20 })
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/FunPage',
                  params: {
                    resultType: this.resultType
                  }
                });
              })

            // 操作按钮
            Row() {
              Button('重新测试')
                .width('40%')
                .height(50)
                .backgroundColor('#FFFFFF')
                .fontColor('#E91E63')
                .border({ width: 2, color: '#E91E63', radius: 25 })
                .onClick(() => this.restartTest())

              Button('返回首页')
                .width('40%')
                .height(50)
                .backgroundColor('#FFFFFF')
                .fontColor('#E91E63')
                .border({ width: 2, color: '#E91E63', radius: 25 })
                .onClick(() => this.goHome())
            }
            .width('90%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ bottom: 30 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      } else {
        Column() {
          Text('未找到测试结果')
            .fontSize(18)
            .fontColor('#999999')
            .margin({ top: 100 })

          Button('返回首页')
            .width('60%')
            .height(50)
            .backgroundColor('#E91E63')
            .fontColor('#FFFFFF')
            .borderRadius(25)
            .margin({ top: 30 })
            .onClick(() => this.goHome())
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF5F7')
  }
}
