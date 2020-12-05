//
//  ShaderLibrary.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/18.
//

import MetalKit

enum VertextShaderTypes {
    case Basic
    case Instance
}

class VertexShaderLibrary: Library<VertextShaderTypes, MTLFunction> {
    
    private var _library: [VertextShaderTypes: Shader] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Shader(name: "Basic Vertex Shader", funtionName: "basic_vertex_shader"), forKey: .Basic)
        _library.updateValue(Shader(name: "Instance Vertex Shader", funtionName: "instance_vertex_shader"), forKey: .Instance)
    }
    
    override subscript(type: VertextShaderTypes) -> MTLFunction {
        return (_library[type]?.funtion)!
    }
}
