//
//  HomeModel.swift
//  MazaadyTask
//
//  Created by mac on 13/01/2024.
//

import Foundation

struct HeaderModel{
    let id: Int
    let image: String
}

struct TypeModel{
    let id: Int
    let typeTitle: String
}

struct ItemModel{
    let id: Int
    let freeFlag: String?
    let title: String
    let time: String
    let author: String
    let position: String
    let bookImage: String
    let authorImage: String
    
    let lessonNumber: String
    let category: String
    let free: String?
}



extension TypeModel{
    static var types: [TypeModel] {
        return [.init(id: 0, typeTitle: "All"),
                .init(id: 1, typeTitle: "UI/UX"),
                .init(id: 2, typeTitle: "Illustration"),
                .init(id: 3, typeTitle: "3D Animation")]
    }
}

extension HeaderModel{
    static var headers: [HeaderModel] {
        return [.init(id: 1, image: "AvatarOne"),
                .init(id: 2, image: "AvatarTwo"),
                .init(id: 3, image: "AvatarThree"),
                .init(id: 4, image: "AvatarFour")]
    }
}

extension ItemModel{
    static var items: [ItemModel] {
        return [.init(id: 1, freeFlag: "Free e-book", title: "Step design sprint for beginner", time: "5h 21m", author: "Laurel Seilha", position: "Product Designer", bookImage: "BaseBackground", authorImage: "authorOne", lessonNumber: "6 lessons", category: "UI/UX", free: "Free"),
                .init(id: 2, freeFlag: nil, title: "Basic skill for sketch illustratior", time: "3h 21m", author: "Laurel Seilha", position: "Product Designer", bookImage: "Background2", authorImage: "authorTwo", lessonNumber: "2 lessons", category: "Design", free: nil)
        ]
    }
}
