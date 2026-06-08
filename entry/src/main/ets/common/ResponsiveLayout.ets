import display from '@ohos.display';

export interface ResponsiveLayout {
  isCompact: boolean;
  screenWidthVp: number;
  contentWidth: number;
  cardWidth: number;
  contentPadding: number;
  sectionGap: number;
  headerHeight: number;
  heroIconSize: number;
  heroTitleSize: number;
  heroSubtitleSize: number;
  sectionTitleSize: number;
  bodySize: number;
  smallTextSize: number;
  primaryButtonHeight: number;
  secondaryButtonHeight: number;
  cardRadius: number;
  buttonRadius: number;
}

const COMPACT_WIDTH_THRESHOLD = 600;
const MIN_CONTENT_WIDTH = 320;
const MAX_CONTENT_WIDTH = 960;

export function getResponsiveLayout(): ResponsiveLayout {
  const screenWidthVp = px2vp(display.getDefaultDisplaySync().width);
  const isCompact = screenWidthVp < COMPACT_WIDTH_THRESHOLD;
  const contentWidth = isCompact
    ? Math.max(screenWidthVp - 32, MIN_CONTENT_WIDTH)
    : Math.min(screenWidthVp * 0.72, MAX_CONTENT_WIDTH);

  return {
    isCompact,
    screenWidthVp,
    contentWidth,
    cardWidth: Math.min(contentWidth, 880),
    contentPadding: isCompact ? 18 : 24,
    sectionGap: isCompact ? 16 : 20,
    headerHeight: isCompact ? 160 : 220,
    heroIconSize: isCompact ? 40 : 48,
    heroTitleSize: isCompact ? 28 : 34,
    heroSubtitleSize: isCompact ? 14 : 16,
    sectionTitleSize: isCompact ? 18 : 20,
    bodySize: isCompact ? 15 : 16,
    smallTextSize: 13,
    primaryButtonHeight: isCompact ? 54 : 58,
    secondaryButtonHeight: 48,
    cardRadius: 16,
    buttonRadius: 26
  };
}