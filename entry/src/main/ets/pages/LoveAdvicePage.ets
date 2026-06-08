import { LoveAdvice } from '../model/MBTIModel';
import { loveAdviceData } from '../data/LoveAdviceData';
import router from '@ohos.router';

@Entry
@Component
struct LoveAdvicePage {
  @State resultType: string = '';
  @State loveAdvice: LoveAdvice | null = null;

  aboutToAppear() {
    const params = router.getParams() as Record<string, Object>;
    if (params && params['resultType']) {
      this.resultType = params['resultType'] as string;
      this.loveAdvice = loveAdviceData[this.resultType];
    }
  }

  goBack() {
    router.back();
  }

  build() {
    Column() {
      Row() {
        Button() {
          Text('←')
            .fontSize(24)
            .fontColor('#FFFFFF')
        }
        .width(50)
        .height(50)
        .backgroundColor(Color.Transparent)
        .onClick(() => this.goBack())

        Text('恋爱建议')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Blank().width(50)
      }
      .width('100%')
      .height(60)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#E91E63', 0], ['#C2185B', 1]]
      })

      if (this.loveAdvice) {
        Scroll() {
          Column() {
            Column() {
              Text(`${this.resultType} 的恋爱风格`)
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#E91E63')
                .margin({ bottom: 15 })

              Text(this.loveAdvice.loveStyle)
                .fontSize(16)
                .fontColor('#666666')
                .textAlign(TextAlign.Center)
                .lineHeight(24)
            }
            .width('90%')
            .padding(20)
            .backgroundColor('#FFF0F5')
            .borderRadius(15)
            .margin({ top: 20, bottom: 20 })

            Column() {
              Row() {
                Text('💕')
                  .fontSize(20)
                  .margin({ right: 8 })
                Text('理想伴侣特质')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
              }
              .margin({ bottom: 15 })

              Flex({ wrap: FlexWrap.Wrap }) {
                ForEach(this.loveAdvice.idealPartner, (item: string) => {
                  Text(item)
                    .fontSize(14)
                    .fontColor('#FFFFFF')
                    .backgroundColor('#E91E63')
                    .borderRadius(15)
                    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                    .margin({ right: 8, bottom: 8 })
                })
              }
              .width('100%')
            }
            .width('90%')
            .padding(20)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 15 })
            .shadow({ radius: 5, color: '#FFE0E6', offsetX: 0, offsetY: 2 })

            Column() {
              Row() {
                Text('💑')
                  .fontSize(20)
                  .margin({ right: 8 })
                Text('最佳匹配类型')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
              }
              .margin({ bottom: 15 })

              Row() {
                ForEach(this.loveAdvice.bestMatch, (item: string) => {
                  Column() {
                    Text(item)
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#FFFFFF')
                  }
                  .width(70)
                  .height(70)
                  .backgroundColor('#4CAF50')
                  .borderRadius(35)
                  .justifyContent(FlexAlign.Center)
                  .margin({ right: 15 })
                })
              }
              .width('100%')
            }
            .width('90%')
            .padding(20)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 15 })
            .shadow({ radius: 5, color: '#FFE0E6', offsetX: 0, offsetY: 2 })

            Column() {
              Row() {
                Text('⚠️')
                  .fontSize(20)
                  .margin({ right: 8 })
                Text('需要注意的类型')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
              }
              .margin({ bottom: 15 })

              Row() {
                ForEach(this.loveAdvice.avoidMatch, (item: string) => {
                  Column() {
                    Text(item)
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#FFFFFF')
                  }
                  .width(70)
                  .height(70)
                  .backgroundColor('#FF9800')
                  .borderRadius(35)
                  .justifyContent(FlexAlign.Center)
                  .margin({ right: 15 })
                })
              }
              .width('100%')
            }
            .width('90%')
            .padding(20)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 15 })
            .shadow({ radius: 5, color: '#FFE0E6', offsetX: 0, offsetY: 2 })

            Column() {
              Row() {
                Text('🌹')
                  .fontSize(20)
                  .margin({ right: 8 })
                Text('约会建议')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
              }
              .margin({ bottom: 15 })

              ForEach(this.loveAdvice.datingTips, (item: string, index: number) => {
                Row() {
                  Text(`${index + 1}.`)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#E91E63')
                    .margin({ right: 8 })
                  Text(item)
                    .fontSize(16)
                    .fontColor('#333333')
                    .layoutWeight(1)
                }
                .width('100%')
                .margin({ bottom: 10 })
                .alignItems(VerticalAlign.Top)
              })
            }
            .width('90%')
            .padding(20)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 15 })
            .shadow({ radius: 5, color: '#FFE0E6', offsetX: 0, offsetY: 2 })

            Column() {
              Row() {
                Text('💬')
                  .fontSize(20)
                  .margin({ right: 8 })
                Text('沟通方式')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
              }
              .margin({ bottom: 15 })

              Text(this.loveAdvice.communicationStyle)
                .fontSize(16)
                .fontColor('#666666')
                .lineHeight(24)
            }
            .width('90%')
            .padding(20)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 15 })
            .shadow({ radius: 5, color: '#FFE0E6', offsetX: 0, offsetY: 2 })

            Column() {
              Row() {
                Text('❤️')
                  .fontSize(20)
                  .margin({ right: 8 })
                Text('爱的语言')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
              }
              .margin({ bottom: 15 })

              Flex({ wrap: FlexWrap.Wrap }) {
                ForEach(this.loveAdvice.loveLanguage, (item: string) => {
                  Text(item)
                    .fontSize(14)
                    .fontColor('#FFFFFF')
                    .backgroundColor('#E91E63')
                    .borderRadius(15)
                    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                    .margin({ right: 8, bottom: 8 })
                })
              }
              .width('100%')
            }
            .width('90%')
            .padding(20)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 15 })
            .shadow({ radius: 5, color: '#FFE0E6', offsetX: 0, offsetY: 2 })

            Column() {
              Row() {
                Text('💪')
                  .fontSize(20)
                  .margin({ right: 8 })
                Text('恋爱中的挑战')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
              }
              .margin({ bottom: 15 })

              Flex({ wrap: FlexWrap.Wrap }) {
                ForEach(this.loveAdvice.challenges, (item: string) => {
                  Text(item)
                    .fontSize(14)
                    .fontColor('#FFFFFF')
                    .backgroundColor('#9C27B0')
                    .borderRadius(15)
                    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                    .margin({ right: 8, bottom: 8 })
                })
              }
              .width('100%')
            }
            .width('90%')
            .padding(20)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .margin({ bottom: 30 })
            .shadow({ radius: 5, color: '#FFE0E6', offsetX: 0, offsetY: 2 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      } else {
        Column() {
          Text('未找到恋爱建议')
            .fontSize(18)
            .fontColor('#999999')
            .margin({ top: 100 })

          Button('返回')
            .width('60%')
            .height(50)
            .backgroundColor('#E91E63')
            .fontColor('#FFFFFF')
            .borderRadius(25)
            .margin({ top: 30 })
            .onClick(() => this.goBack())
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
