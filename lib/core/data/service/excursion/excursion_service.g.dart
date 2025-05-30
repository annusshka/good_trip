// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'excursion_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ExcursionService implements ExcursionService {
  _ExcursionService(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<AudioExcursionDto>> getExcursionsByCity({
    required String city,
    required int offset,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'city': city,
      r'offset': offset,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<AudioExcursionDto>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/audioexcursion/city',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            AudioExcursionDto.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<AudioExcursionDto>> getCreatedExcursions(
      {required int offset}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'offset': offset};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<AudioExcursionDto>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/admin/excursions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            AudioExcursionDto.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<AudioExcursionDto>> getCreatedExcursionsByUser(
      {required int offset}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'offset': offset};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<AudioExcursionDto>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/audioexcursion/created',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            AudioExcursionDto.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<AudioExcursionDto>> getCreatedExcursionsByAdmin(
      {required int offset}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'offset': offset};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<AudioExcursionDto>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/audioexcursion/created',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            AudioExcursionDto.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<void> likeExcursion({
    required String excursionId,
    required bool isLiked,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'excursion_id': excursionId,
      r'is_liked': isLiked,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/audioexcursion/like',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<List<AudioExcursionDto>> getLikedExcursionsByUser(
      {required int offset}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'offset': offset};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<AudioExcursionDto>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/audioexcursion/like',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) =>
            AudioExcursionDto.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<int> createExcursion({required AudioExcursionDto excursion}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(excursion.toJson());
    final _result = await _dio.fetch<int>(_setStreamType<int>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/audioexcursion/create',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = _result.data!;
    return value;
  }

  @override
  Future<int> createExcursionImage({
    required int excursionId,
    required File image,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'excursion_id',
      excursionId.toString(),
    ));
    _data.files.add(MapEntry(
      'image',
      MultipartFile.fromFileSync(
        image.path,
        filename: image.path.split(Platform.pathSeparator).last,
      ),
    ));
    final _result = await _dio.fetch<int>(_setStreamType<int>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
        .compose(
          _dio.options,
          '/audioexcursion/create/image',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = _result.data!;
    return value;
  }

  @override
  Future<int> createExcursionAudio({
    required int excursionId,
    required File audio,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'excursion_id',
      excursionId.toString(),
    ));
    _data.files.add(MapEntry(
      'audio',
      MultipartFile.fromFileSync(
        audio.path,
        filename: audio.path.split(Platform.pathSeparator).last,
      ),
    ));
    final _result = await _dio.fetch<int>(_setStreamType<int>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
        .compose(
          _dio.options,
          '/audioexcursion/create/audio',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = _result.data!;
    return value;
  }

  @override
  Future<void> deleteExcursion({required String excursionId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'excursion_id': excursionId};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/audioexcursion',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<List<TourKind>> getExcursionTypes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<List<dynamic>>(_setStreamType<List<TourKind>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/auth/excursions/types',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!
        .map((dynamic i) => TourKind.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
