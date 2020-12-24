//
//  Sun.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/12.
//

import MetalKit

class Sun: LightObject {
    init() {
        //super.init(meshType: .Sphere, name: "Sun") //show sphere
        super.init(name: "Sun")
        self.setScale(0.1)
    }
}
