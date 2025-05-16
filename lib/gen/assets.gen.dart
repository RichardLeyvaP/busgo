/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $LibGen {
  const $LibGen();

  /// Directory path: lib/l10n
  $LibL10nGen get l10n => const $LibL10nGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/image-trip-default.png
  AssetGenImage get imageTripDefault =>
      const AssetGenImage('assets/images/image-trip-default.png');

  /// List of all assets
  List<AssetGenImage> get values => [imageTripDefault];
}

class $LibL10nGen {
  const $LibL10nGen();

  /// File path: lib/l10n/app_en.arb
  String get appEn => 'lib/l10n/app_en.arb';

  /// File path: lib/l10n/app_es.arb
  String get appEs => 'lib/l10n/app_es.arb';

  /// File path: lib/l10n/app_pt.arb
  String get appPt => 'lib/l10n/app_pt.arb';

  /// List of all assets
  List<String> get values => [appEn, appEs, appPt];
}

class Assets {
  const Assets._();

  static const String env = 'assets/env.dart';
  static const String envProd = 'assets/env.prod.json';
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $LibGen lib = $LibGen();

  /// List of all assets
  static List<String> get values => [env, envProd];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
