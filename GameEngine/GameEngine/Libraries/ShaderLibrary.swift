//
//  ShaderLibrary.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/18.
//

import MetalKit

enum VertextShaderTypes {
    case Basic
}

enum FragmentShaderTypes {
    case Basic
}

class ShaderLibrary {
    public static var DefaultLibrary: MTLLibrary!
    
    private static var vertexShaders: [VertextShaderTypes: Shader] = [:]
    private static var fragmentShaders: [FragmentShaderTypes: Shader] = [:]
    
    public static func initialize() {
        DefaultLibrary = Engine.Device.makeDefaultLibrary()
        createDefaultShaders()
    }
    
    public static func createDefaultShaders() {
        vertexShaders.updateValue(Basic_VertexShader(), forKey: .Basic)
        fragmentShaders.updateValue(Basic_FragmentShader(), forKey: .Basic)
    }
    
    public static func Vertex(_ vertextShaderTypes: VertextShaderTypes) -> MTLFunction {
        //return vertexShaders[vertextShaderTypes]!.function
        return ShaderLibrary.DefaultLibrary.makeFunction(name: "basic_vertex_shader") as! MTLFunction
    }
    
    public static func Fragment(_ fragmentShaderTypes: FragmentShaderTypes) -> MTLFunction {
        //return fragmentShaders[fragmentShaderTypes]!.function
        return ShaderLibrary.DefaultLibrary.makeFunction(name: "basic_fragment_shader") as! MTLFunction
    }
}

protocol Shader {
    var name: String { get }
    var functionName: String { get }
    var function: MTLFunction { get }
}

public struct Basic_VertexShader: Shader {
    public var name: String =  "Basic Vertex Shader"
    public var functionName: String = "basic_vertex_shader"
    public var function: MTLFunction {
        let funtion = ShaderLibrary.DefaultLibrary.makeFunction(name: "basic_vertex_shader")
        funtion?.label = name
        return function
    }
}

public struct Basic_FragmentShader: Shader {
    public var name: String =  "Basic Fragmen tShader"
    public var functionName: String = "basic_fragment_shader"
    public var function: MTLFunction {
        let funtion = ShaderLibrary.DefaultLibrary.makeFunction(name: "basic_fragment_shader")
        funtion?.label = name
        return function
    }
}
