//
//  RealmAccessible.swift
//  RealmSwiftService
//
//  Created by Tsubasa Hayashi on 2018/11/05.
//  Copyright © 2018 Tsubasa Hayashi. All rights reserved.
//

// The MIT License (MIT)
// Copyright (c) 2018 yokurin <yoku.rin.99@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import RealmSwift

public protocol RealmAccessible {
    associatedtype ObjectType: RealmSwift.Object = Self

    // MARK: Static Methods
    static func all() -> Results<ObjectType>
    static func find(by key: Any) -> ObjectType?
    static func first() -> ObjectType?
    static func last() -> ObjectType?
    @discardableResult
    static func deleteAll() throws -> Bool
    @discardableResult
    static func delete(list: List<ObjectType>) throws -> Bool


    // MARK: Instance Methods
    @discardableResult
    func save(update: Bool) throws -> Bool
    @discardableResult
    func delete() throws -> Bool

    // MARK: Realm Properties
    var realm: Realm { get }
    static var realm: Realm { get }
}

// MARK: Static Methods
public extension RealmAccessible {
    static func all() -> Results<ObjectType> {
        return realm.objects(ObjectType.self)
    }

    static func find(by key: Any) -> ObjectType? {
        return realm.object(ofType: ObjectType.self, forPrimaryKey: key)
    }

    static func first() -> ObjectType? {
        return all().first
    }

    static func last() -> ObjectType? {
        return all().last
    }

    @discardableResult
    static func deleteAll() throws -> Bool {
        let _all = all()
        do {
            try realm.write {
                realm.delete(_all)
            }
            return true
        } catch let e {
            #if DEBUG
            print(e.localizedDescription)
            #endif
            return false
        }
    }

    @discardableResult
    static func delete(list: List<ObjectType>) throws -> Bool {
        if realm.isInWriteTransaction {
            realm.delete(list)
            return true
        } else {
            do {
                try realm.write {
                    realm.delete(list)
                }
                return true
            } catch let e {
                #if DEBUG
                print(e.localizedDescription)
                #endif
                return false
            }
        }
    }
}

// MARK: Instance Methods
public extension RealmAccessible where Self: RealmSwift.Object {

    @discardableResult
    func save(update: Bool = true) throws -> Bool {
        do {
            try realm.write {
                realm.add(self, update: update)
            }
            return true
        } catch let e {
            #if DEBUG
            print(e.localizedDescription)
            #endif
            return false
        }

    }

    @discardableResult
    func delete() throws -> Bool {
        do {
            try realm.write {
                realm.delete(self)
            }
            return true
        } catch let e {
            #if DEBUG
            print(e.localizedDescription)
            #endif
            return false
        }
    }
}

// MARK: Realm Properties
fileprivate var RealmInstanceKey: UInt8 = 0

public extension RealmAccessible {

    var realm: Realm {
        get {
            guard let realm = objc_getAssociatedObject(self, &RealmInstanceKey) as? Realm else {
                let realm = try! Realm()
                objc_setAssociatedObject(self, &RealmInstanceKey, realm, .OBJC_ASSOCIATION_RETAIN)
                return realm
            }
            return realm
        }
        set {
            objc_setAssociatedObject(self, &RealmInstanceKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    static var realm: Realm {
        get {
            guard let realm = objc_getAssociatedObject(self, &RealmInstanceKey) as? Realm else {
                let realm = try! Realm()
                objc_setAssociatedObject(self, &RealmInstanceKey, realm, .OBJC_ASSOCIATION_RETAIN)
                return realm
            }
            return realm
        }
        set {
            objc_setAssociatedObject(self, &RealmInstanceKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

}
