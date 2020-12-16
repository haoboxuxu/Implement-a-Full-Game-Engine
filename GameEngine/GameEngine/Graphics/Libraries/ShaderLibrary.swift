//
//  ShaderLibrary.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/16.
//

import MetalKit

enum ShaderTypes {
    // Vertex
    case Basic_Vertex
    case Instanced_Vertex
    // Fragment
    case Basic_Fragment
}

class ShaderLibrary: Library<ShaderTypes, MTLFunction> {
    private var _library: [ShaderTypes : Shader] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Shader(functionName: "basic_vertex_shader"), forKey: .Basic_Vertex)
        _library.updateValue(Shader(functionName: "instance_vertex_shader"), forKey: .Instanced_Vertex)
        _library.updateValue(Shader(functionName: "basic_fragment_shader"), forKey: .Basic_Fragment)
    }
    
    override subscript(type: ShaderTypes) -> MTLFunction {
        return (_library[type]?.funtion)!
    }
}

class Shader {
    var funtion: MTLFunction!
    init(functionName: String) {
        self.funtion = Engine.DefaltLibrary.makeFunction(name: functionName)
        self.funtion.label = functionName
    }
}
