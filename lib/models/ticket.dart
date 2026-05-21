class TicketModel {
  String? sId;
  String? name;
  int? price;
  int? totalQuantity;
  int? soldQuantity;
  ProEventId? proEventId;
  List<NFT>? nft;
  DateTime? createdAt;
  DateTime? updatedAt;

  TicketModel({
    this.sId,
    this.name,
    this.price,
    this.totalQuantity,
    this.soldQuantity,
    this.proEventId,
    this.nft,
    this.createdAt,
    this.updatedAt,
  });

  TicketModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    totalQuantity = json['totalQuantity'];
    soldQuantity = json['soldQuantity'] ?? 0;
    proEventId = json['eventId'] != null
        ? ProEventId.fromJson(json['eventId'])
        : null;

    if (json['nft'] != null) {
      nft = <NFT>[];
      json['nft'].forEach((v) {
        nft!.add(NFT.fromJson(v));
      });
    }

    createdAt = json['createdAt'] != null
        ? DateTime.parse(json['createdAt']).toLocal()
        : null;
    updatedAt = json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt']).toLocal()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['price'] = price;
    data['totalQuantity'] = totalQuantity;
    data['soldQuantity'] = soldQuantity;
    if (proEventId != null) {
      data['eventId'] = proEventId!.toJson();
    }

    if (nft != null) {
      data['nft'] = nft!.map((v) => v.toJson()).toList();
    }

    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    return data;
  }
}

class NFT {
  String? tokenId;
  String? mintTxHash;
  String? status;
  DateTime? mintedAt;

  NFT({this.tokenId, this.mintTxHash, this.status, this.mintedAt});

  NFT.fromJson(Map<String, dynamic> json) {
    tokenId = json['tokenId'];
    mintTxHash = json['mintTxHash'];
    status = json['status'];
    mintedAt = json['mintedAt'] != null
        ? DateTime.parse(json['mintedAt']).toLocal()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['tokenId'] = tokenId;
    data['mintTxHash'] = mintTxHash;
    data['status'] = status;
    data['mintedAt'] = mintedAt?.toIso8601String();
    return data;
  }
}

class ProEventId {
  String? sId;
  String? title;

  ProEventId({this.sId, this.title});

  ProEventId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['title'] = title;
    return data;
  }
}
