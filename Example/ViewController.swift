//
//  ViewController.swift
//  Example
//
//  Created by Tsubasa Hayashi on 2018/11/05.
//  Copyright © 2018 Tsubasa Hayashi. All rights reserved.
//

import UIKit
import RealmSwiftService

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //--- RealmAccessible Example ---
        let cat = Cat(name: "tama")  // Create Realm Object
        _ = Cat.all()                // Get All Object of Cat
        _ = Cat.find(by: "id")       // Find Cat by id property
        _ = Cat.first()              // Get Last Object of Cat
        _ = Cat.last()               // Get First Object of Cat
        try! cat.save()              // Save Object of Cat
        try! cat.delete()            // Delete Object of Cat
        try! Cat.deleteAll()         // Delete All Object of Cat


        // --- Dao Example ---
        let dao = RealmDao<Dog>()    // Create Dao of Dog
        let dog = Dog(name: "pochi") // Create Realm Object
        _ = dao.all()                // Get All Object of Dog
        _ = dao.find(by: "id")       // Find Dog by id property
        _ = dao.first()              // Get First Object of Dog
        _ = dao.last()               // Get Last Object of Dog
        try! dao.save(dog)           // Save Object of Dog
        try! dao.delete(dog)         // Delete Object of Dog
        try! dao.deleteAll()         // Delete All Object of Dog

    }

}
