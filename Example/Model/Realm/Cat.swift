//
//  Cat.swift
//  Example
//
//  Created by Tsubasa Hayashi on 2018/11/05.
//  Copyright © 2018 Tsubasa Hayashi. All rights reserved.
//

import Foundation
import RealmSwift
import RealmSwiftService

@objcMembers
class Cat: Object, RealmAccessible {

    dynamic var id = UUID().uuidString
    dynamic var name = ""

    override static func primaryKey() -> String? { return "id" }

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
