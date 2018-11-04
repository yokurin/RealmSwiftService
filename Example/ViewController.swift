//
//  ViewController.swift
//  Example
//
//  Created by Tsubasa Hayashi on 2018/11/05.
//  Copyright © 2018 Tsubasa Hayashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //--- RealmAccessible Example ---
        let cat = Cat(name: "tama")
        Cat.all()
        Cat.find(by: "id")
        Cat.first()
        Cat.last()
        try! Cat.deleteAll()
        try! cat.delete()
        try! cat.save()

        // --- Dao Example ---
        let dao = RealmDao<Dog>()
        let dog = Dog(name: "pochi")
        dao.all()
        dao.find(by: "id")
        dao.first()
        dao.last()
        try! dao.deleteAll()
        try! dao.delete(dog)
        try! dao.save(dog)
    }

}
