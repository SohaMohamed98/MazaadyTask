//
//  ResponseObject.swift
//  MazaadyTask
//
//  Created by mac on 12/01/2024.
//

import Foundation
struct ResponseObject<T: Decodable>: Decodable {
    var message: String?
    var code: Int?
    var data: T?
    
    private enum CodingKeys:String,CodingKey{
        case message = "msg"
        case code, data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let msg = try container.decodeIfPresent(String.self, forKey: .message){
            self.message = msg
        }else{
            self.message = ""
        }
        self.code = try container.decode(Int.self, forKey: .code)
        self.data = try container.decodeIfPresent(T.self, forKey: .data)
    }
}



