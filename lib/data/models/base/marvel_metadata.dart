import 'package:equatable/equatable.dart';
import 'package:marvelhero/core/models/base.dart';

import 'marvel_base.dart';

class MarvelMetaData<T extends BaseModel> extends Equatable {
  final int code;
  final String status;
  final String copyright;
  final String attributionText;
  final String attributionHTML;
  final String etag;
  final MarvelBase<T> data;

  MarvelMetaData(this.code, this.status, this.copyright, this.attributionText,
      this.attributionHTML, this.etag, this.data);

  MarvelMetaData.fromJson(Map<String, dynamic> json)
      : assert(json['code'] is int),
        code = json['code'],
        status = json['status'],
        copyright = json['copyright'],
        attributionText = json['attributionText'],
        attributionHTML = json['attributionHTML'],
        etag = json['etag'],
        data = MarvelBase.fromJson(json['data']);

  Map<String, dynamic> toJson() => {
        'offset': code,
        'limit': status,
        'count': copyright,
        'attributionText': attributionText,
        'attributionHTML': attributionHTML,
        'etag': etag,
        'data': data,
      };

  @override
  List<Object> get props => [code];
}
