// V2Ray configuration models
import 'package:freezed_annotation/freezed_annotation.dart';

part 'v2ray_config.freezed.dart';
part 'v2ray_config.g.dart';

@freezed
class V2RayConfig with _$V2RayConfig {
  const factory V2RayConfig({
    required InboundConfig inbound,
    required OutboundConfig outbound,
    required DnsConfig dns,
    required RoutingConfig routing,
  }) = _V2RayConfig;

  factory V2RayConfig.fromJson(Map<String, dynamic> json) => _$V2RayConfigFromJson(json);
}

@freezed
class InboundConfig with _$InboundConfig {
  const factory InboundConfig({
    required int port,
    required String protocol,
    required String tag,
    Settings settings,
    StreamSettings streamSettings,
  }) = _InboundConfig;

  factory InboundConfig.fromJson(Map<String, dynamic> json) => _$InboundConfigFromJson(json);
}

@freezed
class OutboundConfig with _$OutboundConfig {
  const factory OutboundConfig({
    required String protocol,
    required String tag,
    required VmessSettings settings,
    StreamSettings streamSettings,
    MuxSettings mux,
  }) = _OutboundConfig;

  factory OutboundConfig.fromJson(Map<String, dynamic> json) => _$OutboundConfigFromJson(json);
}

@freezed
class VmessSettings with _$VmessSettings {
  const factory VmessSettings({
    required List<VmessUser> vnext,
  }) = _VmessSettings;

  factory VmessSettings.fromJson(Map<String, dynamic> json) => _$VmessSettingsFromJson(json);
}

@freezed
class VmessUser with _$VmessUser {
  const factory VmessUser({
    required String address,
    required int port,
    required List<VmessAccount> users,
  }) = _VmessUser;

  factory VmessUser.fromJson(Map<String, dynamic> json) => _$VmessUserFromJson(json);
}

@freezed
class VmessAccount with _$VmessAccount {
  const factory VmessAccount({
    required String id,
    required int alterId,
    required String security,
  }) = _VmessAccount;

  factory VmessAccount.fromJson(Map<String, dynamic> json) => _$VmessAccountFromJson(json);
}

@freezed
class StreamSettings with _$StreamSettings {
  const factory StreamSettings({
    required String network,
    required String security,
    TcpSettings tcpSettings,
    WsSettings wsSettings,
    GrpcSettings grpcSettings,
    TlsSettings tlsSettings,
  }) = _StreamSettings;

  factory StreamSettings.fromJson(Map<String, dynamic> json) => _$StreamSettingsFromJson(json);
}

@freezed
class TcpSettings with _$TcpSettings {
  const factory TcpSettings({
    HeaderSettings header,
  }) = _TcpSettings;

  factory TcpSettings.fromJson(Map<String, dynamic> json) => _$TcpSettingsFromJson(json);
}

@freezed
class WsSettings with _$WsSettings {
  const factory WsSettings({
    required String path,
    Map<String, String> headers,
  }) = _WsSettings;

  factory WsSettings.fromJson(Map<String, dynamic> json) => _$WsSettingsFromJson(json);
}

@freezed
class GrpcSettings with _$GrpcSettings {
  const factory GrpcSettings({
    required String serviceName,
    Map<String, String> metadata,
  }) = _GrpcSettings;

  factory GrpcSettings.fromJson(Map<String, dynamic> json) => _$GrpcSettingsFromJson(json);
}

@freezed
class TlsSettings with _$TlsSettings {
  const factory TlsSettings({
    String serverName,
    bool allowInsecure,
    List<String> alpn,
    String fingerprint,
  }) = _TlsSettings;

  factory TlsSettings.fromJson(Map<String, dynamic> json) => _$TlsSettingsFromJson(json);
}

@freezed
class HeaderSettings with _$HeaderSettings {
  const factory HeaderSettings({
    String type,
    Map<String, List<String>> request,
  }) = _HeaderSettings;

  factory HeaderSettings.fromJson(Map<String, dynamic> json) => _$HeaderSettingsFromJson(json);
}

@freezed
class MuxSettings with _$MuxSettings {
  const factory MuxSettings({
    required bool enabled,
    required int concurrency,
  }) = _MuxSettings;

  factory MuxSettings.fromJson(Map<String, dynamic> json) => _$MuxSettingsFromJson(json);
}

@freezed
class DnsConfig with _$DnsConfig {
  const factory DnsConfig({
    required List<String> servers,
    List<String> hosts,
    List<String> clientIp,
    bool disableCache,
  }) = _DnsConfig;

  factory DnsConfig.fromJson(Map<String, dynamic> json) => _$DnsConfigFromJson(json);
}

@freezed
class RoutingConfig with _$RoutingConfig {
  const factory RoutingConfig({
    required String domainStrategy,
    required List<RoutingRule> rules,
  }) = _RoutingConfig;

  factory RoutingConfig.fromJson(Map<String, dynamic> json) => _$RoutingConfigFromJson(json);
}

@freezed
class RoutingRule with _$RoutingRule {
  const factory RoutingRule({
    required String type,
    String inboundTag,
    String outboundTag,
    List<String> ip,
    List<String> domain,
    int port,
    String network,
    String sourceGeoip,
    String sourceGeosite,
  }) = _RoutingRule;

  factory RoutingRule.fromJson(Map<String, dynamic> json) => _$RoutingRuleFromJson(json);
}

@freezed
class Settings with _$Settings {
  const factory Settings({
    String udp,
    String address,
    int port,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
}