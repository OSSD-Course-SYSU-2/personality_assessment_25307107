import router from '@ohos.router';

@Entry
@Component
struct Index {
  build() {
    Column() {
      // 顶部渐变标题栏
      Column() {
        Text('💕')
          .fontSize(40)
          .margin({ top: 20, bottom: 8 })
        Text('恋爱性格测试')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
        Text('发现你的恋爱密码')
          .fontSize(14)
          .fontColor('#FFD1DC')
          .margin({ top: 5 })
      }
      .width('100%')
      .height(160)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#E91E63', 0], ['#C2185B', 1]]
      })

      // 主内容区域
      Scroll() {
        Column() {
          // 核心介绍
          Column() {
            Text('探索你的恋爱性格')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .margin({ bottom: 12 })

            Text('通过科学的性格测试，了解你在恋爱中的真实模样，找到最适合你的另一半，收获甜蜜爱情！')
              .fontSize(15)
              .fontColor('#666666')
              .textAlign(TextAlign.Center)
              .width('90%')
              .lineHeight(24)
          }
          .width('100%')
          .margin({ top: 25, bottom: 20 })

          // 功能亮点卡片
          Column() {
            // 亮点1
            Row() {
              Column() {
                Text('💘')
                  .fontSize(28)
              }
              .width(50)
              .height(50)
              .backgroundColor('#FFF0F5')
              .borderRadius(25)
              .justifyContent(FlexAlign.Center)
              .margin({ right: 15 })

              Column() {
                Text('恋爱性格分析')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
                Text('16种恋爱性格类型，找到你的专属标签')
                  .fontSize(13)
                  .fontColor('#999999')
                  .margin({ top: 3 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')
            .margin({ bottom: 18 })

            // 亮点2
            Row() {
              Column() {
                Text('💑')
                  .fontSize(28)
              }
              .width(50)
              .height(50)
              .backgroundColor('#FFF0F5')
              .borderRadius(25)
              .justifyContent(FlexAlign.Center)
              .margin({ right: 15 })

              Column() {
                Text('最佳伴侣匹配')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
                Text('科学匹配最适合你的恋爱对象类型')
                  .fontSize(13)
                  .fontColor('#999999')
                  .margin({ top: 3 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')
            .margin({ bottom: 18 })

            // 亮点3
            Row() {
              Column() {
                Text('🌹')
                  .fontSize(28)
              }
              .width(50)
              .height(50)
              .backgroundColor('#FFF0F5')
              .borderRadius(25)
              .justifyContent(FlexAlign.Center)
              .margin({ right: 15 })

              Column() {
                Text('约会实战建议')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
                Text('量身定制的约会技巧和恋爱攻略')
                  .fontSize(13)
                  .fontColor('#999999')
                  .margin({ top: 3 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')
            .margin({ bottom: 18 })

            // 亮点4
            Row() {
              Column() {
                Text('💬')
                  .fontSize(28)
              }
              .width(50)
              .height(50)
              .backgroundColor('#FFF0F5')
              .borderRadius(25)
              .justifyContent(FlexAlign.Center)
              .margin({ right: 15 })

              Column() {
                Text('沟通与爱的语言')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
                Text('了解你的爱的表达方式，提升恋爱质量')
                  .fontSize(13)
                  .fontColor('#999999')
                  .margin({ top: 3 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')
          }
          .width('90%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(15)
          .shadow({ radius: 8, color: '#FFE0E6', offsetX: 0, offsetY: 4 })

          // 开始测试按钮
          Button('开始测试，发现恋爱密码')
            .width('85%')
            .height(60)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .backgroundColor('#E91E63')
            .fontColor('#FFFFFF')
            .borderRadius(30)
            .shadow({ radius: 12, color: '#E91E63', offsetX: 0, offsetY: 6 })
            .margin({ top: 30, bottom: 10 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/TestPage'
              });
            })

          // 底部说明
          Text('仅需3分钟，解锁你的恋爱性格')
            .fontSize(13)
            .fontColor('#CCCCCC')
            .margin({ top: 10, bottom: 30 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF5F7')
  }
}
