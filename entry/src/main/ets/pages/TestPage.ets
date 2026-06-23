/**
 * 心事述说馆 - 书写页
 * 背景：图片 — 替换 bg_write.png
 */
import router from '@ohos.router';
import { freeFlowState } from '../common/FreeFlowState';
import { feelingCards, getFeelingCard } from '../data/FeelingCards';
import { dbHelper } from '../data/DatabaseHelper';
import { callAiResponse, getFallbackResponse } from '../data/AiService';
import { FeelingCard } from '../model/HeartTalkModel';

@Entry
@Component
struct WritePage {
  @State selectedCategoryId: number = -1;
  @State selectedCategory: FeelingCard | null = null;
  @State isSubmitting: boolean = false;
  @State showCards: boolean = true;
  private contentText: string = '';

  aboutToAppear() {
    const routerParams = router.getParams() as Record<string, Object>;
    const restored = freeFlowState.hasRestoreData() ? freeFlowState.getRestoredParams() : null;
    const catId = (routerParams?.['selectedCategoryId'] || restored?.['selectedCategoryId']) as number;
    if (catId !== undefined && catId !== null && catId > 0) {
      this.selectedCategoryId = catId;
      this.selectedCategory = getFeelingCard(catId) || null;
      if (this.selectedCategory) { this.showCards = false; }
    }
    const saved = (routerParams?.['writtenContent'] || restored?.['writtenContent']) as string;
    if (saved) { this.contentText = saved; }
    this.syncFS();
  }

  syncFS(): void {
    freeFlowState.updateState('pages/TestPage', {
      'selectedCategoryId': this.selectedCategoryId, 'writtenContent': this.contentText,
      'categoryPrompt': this.selectedCategory?.prompt || '', 'isComplete': this.isSubmitting
    });
  }

  select(c: FeelingCard): void { this.selectedCategoryId = c.id;
    this.selectedCategory = c;
    this.showCards = false;
    this.contentText = ''; this.syncFS(); }
  back(): void { this.showCards = true;
    this.selectedCategoryId = -1;
    this.selectedCategory = null;
    this.contentText = ''; this.syncFS(); }
  async submit(): Promise<void> {
    const text = this.contentText.trim(); if (!text || !this.selectedCategory) { return; }
    this.isSubmitting = true; this.syncFS(); const cat = this.selectedCategory;
    let title: string; let body: string; let followUp: string;
    const ai = await callAiResponse(text, cat.category, cat.prompt);
    if (ai !== null) { title = ai.title;
      body = ai.body;
      followUp = ai.followUp; }
    else { const ix = Math.floor(Math.random() * cat.curatedResponses.length);
      const fb = getFallbackResponse(cat.id, ix);
      title = fb.title;
      body = fb.body;
      followUp = fb.followUp; }
    try { await dbHelper.insertConfession(cat.id, cat.category, text, title, body); } catch (e) {}
    this.isSubmitting = false; this.contentText = '';
    router.pushUrl({ url: 'pages/ResultPage', params: { 'categoryId': cat.id, 'responseTitle': title, 'responseBody': body, 'responseFollowUp': followUp, 'categoryName': cat.category, 'categoryEmoji': cat.emoji, 'userContent': text } });
  }

  goHome(): void { router.replaceUrl({ url: 'pages/Index' }); }

  build() {
    Column() {
      Row() {
        Button() { Text('←').fontSize(22).fontColor('#FFFFFF') }
        .width(44).height(44).backgroundColor(Color.Transparent)
        .onClick(() => { if (!this.showCards && this.selectedCategory) { this.back(); }
        else { this.goHome(); } })
        Text(this.showCards ? '今天想说点什么？' : this.isSubmitting ? '正在写信...' : '写下心事')
          .fontSize(18).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
          .layoutWeight(1).textAlign(TextAlign.Center)
        Blank().width(44)
      }
      .width('100%').height(52).backgroundColor('#C8896ECC').backdropBlur(12)

      if (this.showCards) {
        Scroll() {
          Column() {
            Column() {
              Text('🌿 你今天的心情更接近...').fontSize(16).fontColor('#8B7D72')
              Text('选一个，我会认真听').fontSize(13).fontColor('#BFB4A8').margin({ top: 4 })
            }
            .width('100%').alignItems(HorizontalAlign.Center).margin({ top: 28, bottom: 22 })

            ForEach(feelingCards, (card: FeelingCard) => {
              Column() {
                Row() {
                  Text(card.emoji).fontSize(32).margin({ right: 16 })
                  Column() {
                    Text(card.category).fontSize(17).fontWeight(FontWeight.Medium).fontColor('#3D3028')
                    Text(card.prompt).fontSize(12).fontColor('#BFB4A8').maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis }).margin({ top: 2 })
                  }
                  .alignItems(HorizontalAlign.Start).layoutWeight(1)
                  Text('→').fontSize(16).fontColor('#D8CFC4')
                }
                .width('100%')
              }
              .width('88%').padding({ top: 18, bottom: 18, left: 20, right: 20 })
              .backgroundColor('#FFFFFFCC').borderRadius(18)
              .border({ width: 1, color: '#EDE6DE55' })
              .margin({ bottom: 10 }).backdropBlur(12)
              .onClick(() => this.select(card))
            })
          }
          .width('100%').alignItems(HorizontalAlign.Center).padding({ bottom: 24 })
        }
        .width('100%').layoutWeight(1).scrollBar(BarState.Off)
      } else if (this.selectedCategory && !this.isSubmitting) {
        Scroll() {
          Column() {
            Row() {
              Text('致：').fontSize(13).fontColor('#BFB4A8')
              Text(this.selectedCategory!.emoji).fontSize(18).margin({ left: 4, right: 6 })
              Text(this.selectedCategory!.category).fontSize(15).fontWeight(FontWeight.Medium).fontColor('#C8896E')
            }
            .width('88%').padding(16).backgroundColor('#FDF8F4').borderRadius(14)
            .margin({ top: 16, bottom: 14 }).backdropBlur(12)

            Text(this.selectedCategory!.prompt).fontSize(14).fontColor('#8B7D72').lineHeight(22)
              .textAlign(TextAlign.Center).width('82%').margin({ bottom: 18 })

            Column() {
              Row() { Text('—').fontSize(10).fontColor('#EDE6DE'); Blank(); Text('—').fontSize(10).fontColor('#EDE6DE'); Blank(); Text('—').fontSize(10).fontColor('#EDE6DE') }
              .width('70%').margin({ bottom: 16 })
              TextArea({ placeholder: '在这里写下你想说的话...' })
                .width('100%').height(190).fontSize(15)
                .fontColor('#3D3028').placeholderColor('#D8CFC4')
                .placeholderFont({ size: 15 }).backgroundColor(Color.Transparent)
                .border({ width: 0 }).padding(0)
                .onChange((value: string) => { this.contentText = value; })
              Divider().width('100%').height(1).color('#F0EBE2').margin({ top: 16, bottom: 12 })
              Text('✍️ 写完就交给树洞吧').fontSize(11).fontColor('#D8CFC4')
            }
            .width('88%').padding(24).backgroundColor('#FFFFFFCC').borderRadius(20)
            .border({ width: 1, color: '#EDE6DE55' })
            .margin({ bottom: 22 }).backdropBlur(12)

            Button() {
              Row() { Text('💌').fontSize(18).margin({ right: 8 }); Text('把心事交出去').fontSize(16).fontWeight(FontWeight.Bold) }
            }
            .width('88%').height(54).backgroundColor('#C8896E').fontColor('#FFFFFF')
            .borderRadius(27).shadow({ radius: 10, color: '#C8896E33', offsetX: 0, offsetY: 5 })
            .margin({ bottom: 14 }).onClick(() => this.submit())
            Text('← 换个心情').fontSize(13).fontColor('#BFB4A8').onClick(() => this.back()).margin({ bottom: 24 })
          }
          .width('100%').alignItems(HorizontalAlign.Center)
        }
        .width('100%').layoutWeight(1).scrollBar(BarState.Off)
      } else if (this.isSubmitting) {
        Column() {
          Text('💌').fontSize(52).margin({ bottom: 16 })
          Text('正在把你的心事放进树洞...').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#8B7D72').margin({ bottom: 8 })
          Text('温暖回信马上就来').fontSize(13).fontColor('#BFB4A8')
          LoadingProgress().width(44).height(44).color('#C8896E').margin({ top: 24 })
        }
        .width('100%').layoutWeight(1).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%').height('100%')
    .backgroundImage($r('app.media.bg_warm'))
    .backgroundImageSize(ImageSize.Cover)
  }
}
