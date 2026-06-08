import router from '@ohos.router';
import { funFortunes, funMoodTips, funQuizItems, funTaskItems, getFunMatchHint } from '../data/FunPlayData';

interface FunPageParams {
  resultType?: string;
}

@Entry
@Component
struct FunPage {
  @State resultType: string = '';
  @State taskIndex: number = 0;
  @State quizIndex: number = 0;
  @State taskEmoji: string = '';
  @State taskTitle: string = '';
  @State taskSubtitle: string = '';
  @State taskDetail: string = '';
  @State moodTip: string = '';
  @State quizQuestion: string = '';
  @State quizOptionA: string = '';
  @State quizOptionB: string = '';
  @State quizResult: string = '';
  @State quizResultDetail: string = '';
  @State matchHint: string = '';
  @State fortuneIndex: number = 0;
  @State fortuneText: string = '';

  aboutToAppear() {
    const params = router.getParams() as FunPageParams;
    if (params && params.resultType) {
      this.resultType = params.resultType;
    }

    const date = new Date();
    this.taskIndex = (date.getFullYear() * 372 + date.getMonth() * 31 + date.getDate()) % funTaskItems.length;
    this.quizIndex = date.getDate() % funQuizItems.length;
    this.fortuneIndex = (date.getFullYear() + date.getMonth() + date.getDate()) % funFortunes.length;
    this.loadTaskData();
    this.loadQuizData();
    this.moodTip = funMoodTips[this.taskIndex % funMoodTips.length];
    this.matchHint = getFunMatchHint(this.resultType);
    this.fortuneText = funFortunes[this.fortuneIndex];
    this.quizResult = '';
    this.quizResultDetail = '';
  }

  loadTaskData() {
    const task = funTaskItems[this.taskIndex];
    this.taskEmoji = task.emoji;
    this.taskTitle = task.title;
    this.taskSubtitle = task.subtitle;
    this.taskDetail = task.detail;
  }

  loadQuizData() {
    const quiz = funQuizItems[this.quizIndex];
    this.quizQuestion = quiz.question;
    this.quizOptionA = quiz.optionA;
    this.quizOptionB = quiz.optionB;
  }

  nextTask() {
    this.taskIndex = (this.taskIndex + 1) % funTaskItems.length;
    this.loadTaskData();
    this.moodTip = funMoodTips[this.taskIndex % funMoodTips.length];
  }

  nextQuiz() {
    this.quizIndex = (this.quizIndex + 1) % funQuizItems.length;
    this.loadQuizData();
    this.quizResult = '';
    this.quizResultDetail = '';
  }

  nextFortune() {
    this.fortuneIndex = (this.fortuneIndex + 1) % funFortunes.length;
    this.fortuneText = funFortunes[this.fortuneIndex];
  }

  selectQuiz(option: 'A' | 'B') {
    const currentQuiz = funQuizItems[this.quizIndex];
    this.quizResult = option === 'A' ? '你选了 A' : '你选了 B';
    this.quizResultDetail = option === 'A' ? currentQuiz.answerA : currentQuiz.answerB;
  }

  goHome() {
    router.replaceUrl({
      url: 'pages/Index'
    });
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
        .onClick(() => this.goHome())

        Text('趣味玩法')
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

      Scroll() {
        Column() {
          Column() {
            Text('把测试玩得更轻松一点')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#E91E63')
              .margin({ bottom: 10 })

            Text('这里有每日小任务、随机彩蛋题和基于你类型的轻提示。')
              .fontSize(15)
              .fontColor('#666666')
              .textAlign(TextAlign.Center)
              .lineHeight(24)
          }
          .width('90%')
          .padding(20)
          .backgroundColor('#FFF0F5')
          .borderRadius(18)
          .margin({ top: 20, bottom: 15 })

          Column() {
            Row() {
              Text(this.taskEmoji)
                .fontSize(24)
                .margin({ right: 10 })
              Column() {
                Text(this.taskTitle)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
                Text(this.taskSubtitle)
                  .fontSize(14)
                  .fontColor('#E91E63')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')
            .margin({ bottom: 12 })

            Text(this.taskDetail)
              .fontSize(15)
              .fontColor('#555555')
              .lineHeight(24)

            Text(this.moodTip)
              .fontSize(13)
              .fontColor('#999999')
              .margin({ top: 14 })

            Button('换一个任务')
              .width('100%')
              .height(48)
              .margin({ top: 16 })
              .backgroundColor('#E91E63')
              .fontColor('#FFFFFF')
              .borderRadius(24)
              .onClick(() => this.nextTask())
          }
          .width('90%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .margin({ bottom: 15 })
          .shadow({ radius: 8, color: '#FAD3DE', offsetX: 0, offsetY: 4 })

          Column() {
            Row() {
              Text('🧧')
                .fontSize(22)
                .margin({ right: 8 })
              Text('恋爱幸运签')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
            }
            .margin({ bottom: 12 })

            Text(this.fortuneText)
              .fontSize(15)
              .fontColor('#555555')
              .lineHeight(24)

            Button('再抽一签')
              .width('100%')
              .height(48)
              .margin({ top: 16 })
              .backgroundColor('#FFF0F5')
              .fontColor('#E91E63')
              .border({ width: 1, color: '#F6B3C6', radius: 24 })
              .onClick(() => this.nextFortune())
          }
          .width('90%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .margin({ bottom: 15 })
          .shadow({ radius: 8, color: '#FAD3DE', offsetX: 0, offsetY: 4 })

          Column() {
            Row() {
              Text('🎲')
                .fontSize(22)
                .margin({ right: 8 })
              Text('三秒恋爱彩蛋题')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
            }
            .margin({ bottom: 14 })

            Text(this.quizQuestion)
              .fontSize(16)
              .fontColor('#555555')
              .lineHeight(24)
              .margin({ bottom: 16 })

            Button() {
              Row() {
                Text('A')
                  .fontSize(15)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#E91E63')
                  .borderRadius(12)
                  .width(24)
                  .height(24)
                  .textAlign(TextAlign.Center)
                  .margin({ right: 10 })
                Text(this.quizOptionA)
                  .fontSize(15)
                  .fontColor('#333333')
                  .textAlign(TextAlign.Start)
                  .layoutWeight(1)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .padding({ left: 12, right: 12, top: 14, bottom: 14 })
            }
            .width('100%')
            .backgroundColor('#FFF5F7')
            .borderRadius(14)
            .border({ width: 1, color: '#FFE0E6' })
            .margin({ bottom: 12 })
            .onClick(() => this.selectQuiz('A'))

            Button() {
              Row() {
                Text('B')
                  .fontSize(15)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#E91E63')
                  .borderRadius(12)
                  .width(24)
                  .height(24)
                  .textAlign(TextAlign.Center)
                  .margin({ right: 10 })
                Text(this.quizOptionB)
                  .fontSize(15)
                  .fontColor('#333333')
                  .textAlign(TextAlign.Start)
                  .layoutWeight(1)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .padding({ left: 12, right: 12, top: 14, bottom: 14 })
            }
            .width('100%')
            .backgroundColor('#FFF5F7')
            .borderRadius(14)
            .border({ width: 1, color: '#FFE0E6' })
            .onClick(() => this.selectQuiz('B'))

            Button('换一道彩蛋题')
              .width('100%')
              .height(46)
              .backgroundColor('#FFFFFF')
              .fontColor('#E91E63')
              .border({ width: 1, color: '#F6B3C6', radius: 23 })
              .margin({ top: 14 })
              .onClick(() => this.nextQuiz())

            if (this.quizResult) {
              Column() {
                Text(this.quizResult)
                  .fontSize(15)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#E91E63')
                  .margin({ bottom: 8 })
                Text(this.quizResultDetail)
                  .fontSize(14)
                  .fontColor('#666666')
                  .lineHeight(22)
              }
              .width('100%')
              .padding(14)
              .backgroundColor('#FFF0F5')
              .borderRadius(14)
              .margin({ top: 14 })
            }
          }
          .width('90%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .margin({ bottom: 15 })
          .shadow({ radius: 8, color: '#FAD3DE', offsetX: 0, offsetY: 4 })

          Column() {
            Row() {
              Text('💘')
                .fontSize(22)
                .margin({ right: 8 })
              Text('你的轻提示')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
            }
            .margin({ bottom: 12 })

            Text('这是根据你的 MBTI 类型给出的今天可直接照做的互动建议，适合聊天、约会和推进关系时参考。')
              .fontSize(13)
              .fontColor('#999999')
              .lineHeight(20)
              .margin({ bottom: 12 })

            Text(this.matchHint)
              .fontSize(15)
              .fontColor('#555555')
              .lineHeight(24)

            if (this.resultType) {
              Text(`当前类型：${this.resultType}`)
                .fontSize(13)
                .fontColor('#E91E63')
                .margin({ top: 12 })
            }
          }
          .width('90%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .margin({ bottom: 20 })
          .shadow({ radius: 8, color: '#FAD3DE', offsetX: 0, offsetY: 4 })

          Button('返回首页')
            .width('90%')
            .height(54)
            .backgroundColor('#FFFFFF')
            .fontColor('#E91E63')
            .border({ width: 2, color: '#E91E63', radius: 27 })
            .margin({ bottom: 30 })
            .onClick(() => this.goHome())
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
