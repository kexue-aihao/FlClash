/// Relax AnyTLS TLS verification for v2board / Mihomo compatibility.
///
/// v2rayN (sing-box) ignores URI `pcs` on AnyTLS, while Mihomo enforces YAML
/// `fingerprint`. Wrong panel pins break FlClash but not v2rayN.
void relaxAnytlsTlsVerify(Map rawConfig) {
  final proxies = rawConfig['proxies'];
  if (proxies is! List) {
    return;
  }

  for (var i = 0; i < proxies.length; i++) {
    final proxy = proxies[i];
    if (proxy is! Map) {
      continue;
    }
    final type = proxy['type'];
    if (type is! String || type.toLowerCase() != 'anytls') {
      continue;
    }
    final relaxed = Map<String, dynamic>.from(proxy);
    relaxed.remove('fingerprint');
    relaxed['skip-cert-verify'] = true;
    proxies[i] = relaxed;
  }
}
