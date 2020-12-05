//
//  FragmentShaderLibrary.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/5.
//

import MetalKit

enum FragmentShaderTypes {
    case Basic
}

class FragmentShaderLibrary: Library<FragmentShaderTypes, MTLFunction> {
    private var _library: [FragmentShaderTypes: Shader] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Shader(name: "Basic Fragment Shader", funtionName: "basic_fragment_shader"), forKey: .Basic)
    }
    
    override subscript(type: FragmentShaderTypes) -> MTLFunction {
        return (_library[type]?.funtion)!
    }
}
