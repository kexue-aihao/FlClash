import 'package:fl_clash/common/anytls.dart';
import 'package:test/test.dart';

void main() {
  group('relaxAnytlsTlsVerify', () {
    test('strips fingerprint and enables skip-cert-verify for anytls', () {
      final config = <String, dynamic>{
        'proxies': [
          {
            'name': 'hk1',
            'type': 'anytls',
            'server': 'example.com',
            'fingerprint': 'deadbeef',
          },
          {
            'name': 'vmess1',
            'type': 'vmess',
            'fingerprint': 'keep-me',
          },
        ],
      };

      relaxAnytlsTlsVerify(config);

      final anytls = (config['proxies'] as List).first as Map;
      final vmess = (config['proxies'] as List)[1] as Map;

      expect(anytls.containsKey('fingerprint'), isFalse);
      expect(anytls['skip-cert-verify'], isTrue);
      expect(vmess['fingerprint'], 'keep-me');
      expect(vmess.containsKey('skip-cert-verify'), isFalse);
    });

    test('no-op when proxies missing', () {
      final config = <String, dynamic>{'rules': []};
      relaxAnytlsTlsVerify(config);
      expect(config.containsKey('proxies'), isFalse);
    });
  });
}
