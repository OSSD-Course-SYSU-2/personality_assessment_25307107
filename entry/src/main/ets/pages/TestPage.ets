import { MBTIQuestion, DimensionScores } from '../model/MBTIModel';
import { mbtiQuestions } from '../data/MBTIQuestions';
import router from '@ohos.router';

@Entry
@Component
struct TestPage {
  @State currentQuestionIndex: number = 0;
  @State answers: number[] = [];
  @State progress: number = 0;
  @State isTestComplete: boolean = false;

  aboutToAppear() {
    this.answers = new Array(mbtiQuestions.length).fill(0);
  }

  // 计算MBTI结果
  calculateMBTIResult(): string {
    const scores: DimensionScores = {
      E: 0, I: 0, S: 0, N: 0, T: 0, F: 0, J: 0, P: 0
    };

    mbtiQuestions.forEach((question, index) => {
      const answer = this.answers[index];
      if (answer === 1) {
        if (question.dimension === 'EI') {
          if (question.direction === 'A') scores.E++; else scores.I++;
        } else if (question.dimension === 'SN') {
          if (question.direction === 'A') scores.S++; else scores.N++;
        } else if (question.dimension === 'TF') {
          if (question.direction === 'A') scores.T++; else scores.F++;
        } else if (question.dimension === 'JP') {
          if (question.direction === 'A') scores.J++; else scores.P++;
        }
      } else if (answer === 2) {
        if (question.dimension === 'EI') {
          if (question.direction === 'A') scores.I++; else scores.E++;
        } else if (question.dimension === 'SN') {
          if (question.direction === 'A') scores.N++; else scores.S++;
        } else if (question.dimension === 'TF') {
          if (question.direction === 'A') scores.F++; else scores.T++;
        } else if (question.dimension === 'JP') {
          if (question.direction === 'A') scores.P++; else scores.J++;
        }
      }
    });

    let result = '';
    result += scores.E >= scores.I ? 'E' : 'I';
    result += scores.S >= scores.N ? 'S' : 'N';
    result += scores.T >= scores.F ? 'T' : 'F';
    result += scores.J >= scores.P ? 'J' : 'P';

    return result;
  }

  // 选择答案
  selectAnswer(option: number) {
    this.answers[this.currentQuestionIndex] = option;

    if (this.currentQuestionIndex < mbtiQuestions.length - 1) {
      this.currentQuestionIndex++;
      this.progress = (this.currentQuestionIndex / mbtiQuestions.length) * 100;
    } else {
      this.isTestComplete = true;
      this.progress = 100;

      const resultType = this.calculateMBTIResult();
      router.pushUrl({
        url: 'pages/ResultPage',
        params: {
          resultType: resultType
        }
      });
    }
  }

  // 上一题
  previousQuestion() {
    if (this.currentQuestionIndex > 0) {
      this.currentQuestionIndex--;
      this.progress = (this.currentQuestionIndex / mbtiQuestions.length) * 100;
    }
  }

  build() {
    Column() {
      // 顶部标题栏
      Column() {
        Text('💕 恋爱性格测试')
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

      // 进度条
      Column() {
        Row() {
          Text(`已完成 ${Math.round(this.progress)}%`)
            .fontSize(14)
            .fontColor('#E91E63')
            .fontWeight(FontWeight.Medium)
        }
        .width('90%')
        .margin({ top: 20, bottom: 10 })

        Progress({ value: this.progress, total: 100, type: ProgressType.Linear })
          .width('90%')
          .color('#E91E63')
          .backgroundColor('#FFE0E6')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      // 题目区域
      if (!this.isTestComplete) {
        Column() {
          // 题号
          Text(`第 ${this.currentQuestionIndex + 1} 题 / 共 ${mbtiQuestions.length} 题`)
            .fontSize(16)
            .fontColor('#E91E63')
            .fontWeight(FontWeight.Medium)
            .margin({ top: 30, bottom: 20 })

          // 题目
          Text(mbtiQuestions[this.currentQuestionIndex].question)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .textAlign(TextAlign.Center)
            .width('85%')
            .lineHeight(28)
            .margin({ bottom: 35 })

          // 选项A
          Button() {
            Column() {
              Row() {
                Text('A')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#E91E63')
                  .borderRadius(12)
                  .width(24)
                  .height(24)
                  .textAlign(TextAlign.Center)
                  .margin({ right: 10 })
                Text(mbtiQuestions[this.currentQuestionIndex].optionA)
                  .fontSize(16)
                  .fontColor('#333333')
                  .layoutWeight(1)
              }
              .width('100%')
            }
            .width('100%')
            .padding({ left: 15, right: 15, top: 18, bottom: 18 })
            .alignItems(HorizontalAlign.Center)
          }
          .width('85%')
          .backgroundColor('#FFF5F7')
          .borderRadius(15)
          .border({ width: 1, color: '#FFE0E6' })
          .margin({ bottom: 15 })
          .onClick(() => this.selectAnswer(1))

          // 选项B
          Button() {
            Column() {
              Row() {
                Text('B')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#E91E63')
                  .borderRadius(12)
                  .width(24)
                  .height(24)
                  .textAlign(TextAlign.Center)
                  .margin({ right: 10 })
                Text(mbtiQuestions[this.currentQuestionIndex].optionB)
                  .fontSize(16)
                  .fontColor('#333333')
                  .layoutWeight(1)
              }
              .width('100%')
            }
            .width('100%')
            .padding({ left: 15, right: 15, top: 18, bottom: 18 })
            .alignItems(HorizontalAlign.Center)
          }
          .width('85%')
          .backgroundColor('#FFF5F7')
          .borderRadius(15)
          .border({ width: 1, color: '#FFE0E6' })
          .onClick(() => this.selectAnswer(2))

          // 上一题按钮
          if (this.currentQuestionIndex > 0) {
            Button('← 上一题')
              .width('85%')
              .height(50)
              .backgroundColor('#FFFFFF')
              .fontColor('#E91E63')
              .border({ width: 2, color: '#E91E63', radius: 25 })
              .margin({ top: 25 })
              .onClick(() => this.previousQuestion())
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
