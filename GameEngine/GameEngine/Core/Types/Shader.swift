//
//  Shader.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/5.
//

import MetalKit

class Shader {
    var funtion: MTLFunction!
    init(name: String, funtionName: String) {
        self.funtion = Engine.DefaltLibrary.makeFunction(name: funtionName)
        self.funtion.label = name
    }
}
