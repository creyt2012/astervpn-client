// VMess URI parser - parse vmess:// base64 links
import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vmess_uri_parser.freezed.dart';
part 'vmess_uri_parser.g.dart';

@freezed
class VmessUriConfig with _$VmessUriConfig {
  const factory VmessUriConfig({
    required String v,
    required String ps,
    required String add,
    required int port,
    required String id,
    required int aid,
    required String scy,
    required String net,
    String type,
    String host,
    String path,
    String tls,
    String sni,
    String alpn,
    String fp,
    bool allowInsecure,
    String peer,
  }) = _VmessUriConfig;

  factory VmessUriConfig.fromJson(Map<String, dynamic> json) => _$VmessUriConfigFromJson(json);
}

class VmessUriParser {
  static const String _vmessPrefix = 'vmess://';
  static const String _v2rayPrefix = 'v2ray://';

  /// Parse vmess:// or v2ray:// URI to VmessUriConfig
  static VmessUriConfig? parse(String uri) {
    try {
      String base64Str;
      
      if (uri.startsWith(_vmessPrefix)) {
        base64Str = uri.substring(_vmessPrefix.length);
      } else if (uri.startsWith(_v2rayPrefix)) {
        base64Str = uri.substring(_v2rayPrefix.length);
      } else {
        return null;
      }

      // Handle URL-safe base64
      base64Str = base64Str.replaceAll('-', '+').replaceAll('_', '/');
      
      // Add padding if needed
      switch (base64Str.length % 4) {
        case 2: base64Str += '=='; break;
        case 3: base64Str += '='; break;
      }

      final decoded = utf8.decode(base64.decode(base64Str));
      final json = jsonDecode(decoded) as Map<String, dynamic>;
      
      return VmessUriConfig.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  /// Parse multiple URIs (subscription content)
  static List<VmessUriConfig> parseSubscription(String content) {
    final lines = content.split('\n');
    final configs = <VmessUriConfig>[];
    
    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;
      
      final config = parse(trimmed);
      if (config != null) {
        configs.add(config);
      }
    }
    
    return configs;
  }

  /// Convert VmessUriConfig to V2Ray outbound config
  static Map<String, dynamic> toV2RayOutbound(VmessUriConfig config) {
    final streamSettings = <String, dynamic>{
      'network': config.net,
      'security': config.tls == 'tls' ? 'tls' : 'none',
    };

    if (config.net == 'ws') {
      streamSettings['wsSettings'] = {
        'path': config.path ?? '/',
        'headers': config.host != null ? {'Host': config.host!} : {},
      };
    } else if (config.net == 'grpc') {
      streamSettings['grpcSettings'] = {
        'serviceName': config.path ?? '',
        'multiMode': true,
      };
    }

    if (config.tls == 'tls') {
      streamSettings['tlsSettings'] = {
        'serverName': config.sni ?? config.add,
        'allowInsecure': config.allowInsecure ?? false,
        'alpn': config.alpn?.split(',') ?? ['h2', 'http/1.1'],
        'fingerprint': config.fp ?? 'chrome',
      };
    }

    return {
      'protocol': 'vmess',
      'tag': 'outbound',
      'settings': {
        'vnext': [
          {
            'address': config.add,
            'port': config.port,
            'users': [
              {
                'id': config.id,
                'alterId': config.aid,
                'security': config.scy,
              }
            ]
          }
        ]
      },
      'streamSettings': streamSettings,
      'mux': {
        'enabled': true,
        'concurrency': 8,
      }
    };
  }

  /// Generate vmess:// URI from config
  static String toUri(VmessUriConfig config) {
    final json = jsonEncode(config.toJson());
    final base64Str = base64.encode(utf8.encode(json));
    return '$_vmessPrefix$base64Str';
  }
}