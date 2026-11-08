
import 'package:flutter/material.dart';

import '../app_build.dart';
import '../local_store.dart';
import 'app_scope.dart';
import 'widgets/focus_ring.dart';

const termsVersion = 1;

const _clauses = [
  '$appName 是开源软件，源代码全部公开，仅供个人学习与技术研究，不收费，不提供任何付费服务。',
  '$appName 与红果短剧及其他各站源的运营方无任何关联，未获得其授权或认可；文中提到的名称和商标归各自权利人所有。',
  '$appName 本身不存储、不上传、不分发任何影视内容，所有内容均来自第三方站点，版权归原权利人所有；应用不解除源站 VIP 或其他授权限制。',
  '通过本应用观看或下载的内容仅供试看和个人学习交流，请于下载后 24 小时内删除；如喜欢相关作品，请支持正版。',
  '不得在任何公开平台（如社交媒体、短视频平台、论坛、公开群组等）宣传、分享本应用及其安装包、下载链接或通过本应用获取的内容。',
  '站源内容（包括其中的广告、链接、二维码、联系方式等）均由第三方提供，请自行鉴别真伪，切勿轻信其中的充值、投资、博彩、兼职等信息；由此造成的任何财产损失，作者不承担任何责任。',
  '观看记录、追剧和下载等数据只保存在本设备。开启「匿名使用统计」时，启动时发送随机编号、版本号和平台用于统计使用人数，可在设置 › 关于中关闭。',
  '你应遵守所在地法律法规及各站点的服务条款，不得将本应用用于违法或商业用途；因使用本项目产生的一切后果由使用者自行承担。',
  '本应用按「现状」提供，不对可用性、稳定性或适用性作任何保证，作者不承担由此造成的任何直接或间接损失。',
  '如不同意以上条款，请立即停止使用并卸载本应用。',
  '如认为本项目侵犯了你的合法权益，请通过 Issue 联系，核实后会及时处理。',
];

class TermsPage extends StatefulWidget {
  const TermsPage({super.key, required this.store});

  final LocalStore store;

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  var _busy = false;

  Future<void> _accept() async {
    if (_busy) return;

    setState(() => _busy = true);

    try {
      await widget.store.setAcceptedTerms(termsVersion);
    } catch (failure) {
      if (!mounted) return;

      setState(() => _busy = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('保存确认状态失败：$failure'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final television = AppScope.of(context).television;
    final horizontal = television ? televisionInset : 20.0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('$appName 使用说明'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                horizontal,
                20,
                horizontal,
                28,
              ),
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  size: 42,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  '开始使用前，请了解以下事项',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '本应用是开源媒体客户端。请仅访问你有权使用的内容，'
                  '尊重版权并遵守所在地法律法规及第三方站点服务条款。'
                  '应用不会解除源站 VIP、登录或其他授权限制。',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '使用前请注意',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const _NoticeLine(
                          text: '内容由第三方站点提供，版权归相应权利人所有。',
                        ),
                        const _NoticeLine(
                          text: '不要利用本应用侵犯版权、传播违法内容或从事未经授权的商业活动。',
                        ),
                        const _NoticeLine(
                          text: '谨慎对待第三方站点的广告、二维码、充值和联系方式。',
                        ),
                        const _NoticeLine(
                          text: '观看记录、追剧和下载等数据按原条款说明保存在本设备。',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ExpansionTile(
                  title: const Text('查看完整使用条款'),
                  subtitle: const Text('原有条款全文保留在这里'),
                  children: [
                    for (var i = 0; i < _clauses.length; i++)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: Text(
                          '${i + 1}. ${_clauses[i]}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.55,
                          ),
                        ),
                      ),
  
