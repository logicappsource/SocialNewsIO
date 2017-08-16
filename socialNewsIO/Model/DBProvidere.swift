//
//  DBProvidere.swift
//  socialNewsIO
//
//  Created by LogicAppSourceIO on 16/08/2017.
//  Copyright © 2017 Logicappsource. All rights reserved.
//
//
//import Foundation
//import FirebaseDatabase
//
//
//
//enum DBProvidere {
//
//
//        private static let _instance = DBProvidere()
//
//    static var Instance: DBProvidere {
//        return _instance
//    }
//
//
//    var dbRef: DatabaseReference {
//        return Database.database().reference().child(path)
//    }
//
//
//
//        case root
//        case users(uid: String)
//        case media  // Post
//        case chats // Chats
//        case messages
//
//
//        private var path: String {
//
//            switch self {
//            case .root:
//                return ""
//            case .users(let uid):
//                return "users/\(uid)"
//            case .media:
//                return "media"
//            case .chats:
//                return "chats"
//            case .messages:
//                return "messages"
//            default:
//                return ""
//
//
//
//    }
//
//
//
//

//
//
//}

