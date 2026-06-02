/// Relax AnyTLS TLS verification for v2board / Mihomo compatibility.
///
/// v2rayN (sing-box) ignores URI `pcs` on AnyTLS, while Mihomo enforces YAML
/// `fingerprint`. Wrong panel pins break FlClash but not v2rayN.
void relaxAnytlsTlsVerify(Map<String, dynamic> rawConfig) {
  final proxies = rawConfig['proxies'];
  if (proxies is! List) {
    return;
  }

  for (final proxy in proxies) {
    if (proxy is! Map) {
      continue;
    }
    final type = proxy['type'];
    if (type is! String || type.toLowerCase() != 'anytls') {
      continue;
    }
    proxy.remove('fingerprint');
    proxy['skip-cert-verify'] = true;
  }
}
