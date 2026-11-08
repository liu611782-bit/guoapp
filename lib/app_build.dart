const allSourcesEnabled = bool.fromEnvironment('ALL_SOURCES');
const appName = allSourcesEnabled
    ? String.fromEnvironment('ZHENGUOJIAN_DISPLAY_NAME', defaultValue: '果洞漫剧')
    : '果洞漫剧';
const appSlug = allSourcesEnabled ? 'zhenguojian' : 'hongguojian';
