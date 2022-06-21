

// import '../constants/constants.dart';

// class Project {
//   late bool status;
//   String? assetPath;
//   //e.g education, music etc
//   String? projectCategory;
//   String? projectId;
//   ProjectTypes? projectType;

//   late String name;
  
//   String? imageUrl;
//   String? playstoreUrl;
//   String? appStoreUrl;
//   String? description;
//   List<String>? screenshots;
//   List<String>? languages;

//   Project(
    
//       {this.projectId,
//       required this.status,
//       required this.projectType,
//        this.projectCategory,
//       this.assetPath,
//       required this.name,
//       this.playstoreUrl,
//       this.appStoreUrl,
//       this.imageUrl,
//       this.description,
//       this.screenshots,
//       this.languages});

//   Project.fromJson(Map<String, dynamic> json, String id) {
//     projectId = id;
//     name=json['name'];
//     projectType:json["projectType"];
//     status=json['status'];
//     playstoreUrl = json["playstore_url"];
//     appStoreUrl = json["appstore_url"];

//     description = json["description"];
//     assetPath = json["asset_path"];

//     screenshots =
//         json["screenshots"] != null ? List.from(json["screenshots"]) : null;
//     languages = json["languages"] != null ? List.from(json["languages"]) : null;

//     name = json['name'];
//     imageUrl = json['image_url'];
//   }
// }
