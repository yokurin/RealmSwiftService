//
//  RealmDao.swift
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

open class RealmDao <ObjectType: RealmSwift.Object> {
    public private(set) var realm: Realm

    public init(realm: Realm? = nil) {
        if let r = realm {
            self.realm = r
        } else {
            try! self.realm = Realm()
        }
    }

    open func all() -> Results<ObjectType> {
        return realm.objects(ObjectType.self)
    }

    open func first() -> ObjectType? {
        return all().first
    }

    open func last() -> ObjectType? {
        return all().last
    }

    open func find(by key: Any) -> ObjectType? {
        return realm.object(ofType: ObjectType.self, forPrimaryKey: key)
    }

    @discardableResult
    open func save(_ data: ObjectType) throws -> Bool {
        do {
            try realm.write {
                realm.add(data)
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
    open func update(_ data: ObjectType, execute:(() -> Void)? = nil) throws -> Bool {
        do {
            try realm.write {
                execute?()
                realm.add(data, update: true)
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
    open func delete(_ data: ObjectType) throws -> Bool {
        do {
            try realm.write {
                realm.delete(data)
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
    open func deleteAll() throws -> Bool {
        let all = realm.objects(ObjectType.self)
        do {
            try realm.write {
                realm.delete(all)
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
    open func delete(by key: Any) throws -> Bool {
        if let data = find(by: key) {
            return try delete(data)
        }
        return false
    }

    @discardableResult
    open func delete(list: List<ObjectType>) throws -> Bool {
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

