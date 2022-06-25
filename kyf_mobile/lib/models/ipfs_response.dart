IpfsResponse ipfsResponseFromJson(Map<String, dynamic> json) => IpfsResponse(
      cid: json["cid"],
      created: DateTime.parse(json["created"]),
      type: json["type"],
      scope: json["scope"],
      files: List<dynamic>.from(json["files"]),
      size: json["size"],
      name: json["name"],
    );

class IpfsResponse {
  IpfsResponse({
    required this.cid,
    required this.created,
    required this.type,
    required this.scope,
    required this.files,
    required this.size,
    required this.name,
  });

  String cid;
  DateTime created;
  String type;
  String scope;
  List<dynamic> files;
  int size;
  String name;

  @override
  String toString() {
    return cid + " " + created.toIso8601String();
  }
}
