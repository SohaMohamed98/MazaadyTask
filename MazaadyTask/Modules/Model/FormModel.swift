//
//  FormModel.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import Foundation
// MARK: - FormModel
struct FormModel: Codable {
    let categories: [Category]?
    let statistics: Statistics?
    let adsBanners: [AdsBanner]?
    let iosVersion, iosLatestVersion, googleVersion, huaweiVersion: String?

    enum CodingKeys: String, CodingKey {
        case categories, statistics
        case adsBanners = "ads_banners"
        case iosVersion = "ios_version"
        case iosLatestVersion = "ios_latest_version"
        case googleVersion = "google_version"
        case huaweiVersion = "huawei_version"
    }
}

// MARK: - AdsBanner
struct AdsBanner: Codable {
    let img: String?
    let mediaType: String?
    let duration: Int?

    enum CodingKeys: String, CodingKey {
        case img
        case mediaType = "media_type"
        case duration
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let image: String?
    let slug: String?
    let children: [Category]?
    let circleIcon: String?
    let disableShipping: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, description, image, slug, children
        case circleIcon = "circle_icon"
        case disableShipping = "disable_shipping"
    }
}

// MARK: - Statistics
struct Statistics: Codable {
    let auctions, users, products: Int?
}
