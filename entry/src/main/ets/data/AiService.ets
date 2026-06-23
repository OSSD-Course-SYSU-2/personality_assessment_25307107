/**
 * 心事述说馆 - AI 回信服务
 * 调用 AI API 根据用户心事生成温暖回信
 * API 不可用时自动回退到预设回信
 */
import { http } from '@kit.NetworkKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { feelingCards } from './FeelingCards';

const DOMAIN = 0x0000;

// ── 硅基流动 API（国内直连，免费 2000万 token）──
const AI_API_URL: string = 'https://api.siliconflow.cn/v1/chat/completions';
const AI_API_KEY: string = 'sk-udobiytdsdircqxvqmuvhulqctwrtfiwegxmkrngztjhnvft';
const AI_MODEL: string = 'deepseek-ai/DeepSeek-V3';

/** AI 回信结果 */
export interface AiResponse {
  title: string;
  body: string;
  followUp: string;
}

/** 聊天消息 */
interface ChatMessage {
  role: string;
  content: string;
}

/** AI API 请求体 */
interface AiRequestBody {
  model: string;
  messages: ChatMessage[];
  temperature: number;
  max_tokens: number;
}

/** AI API 响应中的消息体 */
interface AiMessage {
  role: string;
  content: string;
}

/** AI API 响应中的选择项 */
interface AiChoice {
  message: AiMessage;
}

/** AI API 完整响应 */
interface AiApiResponse {
  choices: AiChoice[];
}

/**
 * 调用 AI 生成回信，失败返回 null
 */
export async function callAiResponse(
  userContent: string,
  categoryName: string,
  categoryPrompt: string
): Promise<AiResponse | null> {
  if (!AI_API_KEY) {
    hilog.warn(DOMAIN, 'AiService', 'No API key configured, falling back to curated responses');
    return null;
  }

  let response: http.HttpResponse | null = null;

  try {
    const systemPrompt: string =
      '你是一个温暖的情感树洞，名叫"心事述说馆"。用户选择了"' + categoryName + '"这个话题，引导语是"' + categoryPrompt + '"。请根据用户写下的心事，用温暖、共情、治愈的语气回复。回复需要包含：1. 一个温暖的回信标题（10字以内）2. 回信正文（100-200字，要真诚、有共鸣、给人力量）3. 一句简短的结尾语（15字以内，温暖鼓励）。请以 JSON 格式返回：{"title":"标题","body":"正文","followUp":"结尾语"}。只返回纯 JSON，不要有其他内容。';

    const userMessage: string = '我选择的话题是"' + categoryName + '"。我想说的是：' + userContent;

    const messages: ChatMessage[] = [
      { role: 'system', content: systemPrompt },
      { role: 'user', content: userMessage }
    ];

    const requestObj: AiRequestBody = {
      model: AI_MODEL,
      messages: messages,
      temperature: 0.9,
      max_tokens: 600
    };
    const requestBody: string = JSON.stringify(requestObj);

    const httpRequest: http.HttpRequest = http.createHttp();
    response = await httpRequest.request(
      AI_API_URL,
      {
        method: http.RequestMethod.POST,
        header: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + AI_API_KEY
        },
        extraData: requestBody,
        connectTimeout: 15000,
        readTimeout: 30000
      } as http.HttpRequestOptions
    );

    httpRequest.destroy();

    if (response.responseCode === 200) {
      const resultStr: string = response.result as string;
      const data: AiApiResponse = JSON.parse(resultStr) as AiApiResponse;
      const content: string = data.choices.length > 0 && data.choices[0].message
        ? data.choices[0].message.content
        : '';

      // 尝试提取 JSON
      const jsonMatch: RegExpMatchArray | null = content.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        const parsed: AiResponse = JSON.parse(jsonMatch[0]) as AiResponse;
        if (parsed.title && parsed.body) {
          hilog.info(DOMAIN, 'AiService', 'AI response generated successfully');
          return parsed;
        }
      }

      // 降级：纯文本回信
      hilog.warn(DOMAIN, 'AiService', 'AI returned non-JSON, using raw text');
      return {
        title: '写给特别的你',
        body: content.substring(0, 300),
        followUp: '一切都值得被认真对待'
      };
    }

    hilog.error(DOMAIN, 'AiService', 'API returned status: %{public}d', response.responseCode);
    return null;
  } catch (err) {
    hilog.error(DOMAIN, 'AiService', 'API call failed: %{public}s', JSON.stringify(err));
    return null;
  }
}

/**
 * 根据类别选择预设回信（AI 不可用时的回退方案）
 */
export function getFallbackResponse(categoryId: number, responseIndex: number): AiResponse {
  const card = feelingCards.find((c): boolean => c.id === categoryId);
  if (card) {
    const idx: number = Math.min(responseIndex, card.curatedResponses.length - 1);
    const r = card.curatedResponses[idx];
    return { title: r.title, body: r.body, followUp: r.followUp };
  }
  return {
    title: '谢谢你愿意说出来',
    body: '你把心事写下来的那一刻，已经是一种勇敢。这里永远欢迎你随时回来。',
    followUp: '愿你被世界温柔以待。'
  };
}
