//
//  Chest.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/22.
//

class Chest: GameObject {
    init() {
        super.init(name: "Chest", meshType: .Chest)
        setScale(0.02)
//        setMaterialColor()
        moveY(-0.8)
    }
}

