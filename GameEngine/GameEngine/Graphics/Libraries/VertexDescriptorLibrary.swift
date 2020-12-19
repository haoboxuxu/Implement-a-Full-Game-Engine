//
//  VertexDescriptorLibrary.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/18.
//

import MetalKit

enum VertexDescriptorTypes {
    case Basic
}

class VertexDescriptorLibrary: Library<VertexDescriptorTypes, MTLVertexDescriptor> {
    
    private var _library: [VertexDescriptorTypes : VertexDescriptor] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Basic_VertexDescriptor(), forKey: .Basic)
    }
    
    override subscript(type: VertexDescriptorTypes) -> MTLVertexDescriptor? {
        return _library[type]!.vertexDescriptor
    }
}

protocol VertexDescriptor {
    var name: String { get }
    var vertexDescriptor: MTLVertexDescriptor! { get }
}

class Basic_VertexDescriptor: VertexDescriptor {
    var name: String = "Basic Vertex Descriptor"
    
    var vertexDescriptor: MTLVertexDescriptor!
    init() {
        vertexDescriptor = MTLVertexDescriptor()
        
        // position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        // color
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = float3.size
        // texture coordinate
        vertexDescriptor.attributes[2].format = .float2
        vertexDescriptor.attributes[2].bufferIndex = 0
        vertexDescriptor.attributes[2].offset = float3.size + float4.size
        // normal
        vertexDescriptor.attributes[3].format = .float3
        vertexDescriptor.attributes[3].bufferIndex = 0
        vertexDescriptor.attributes[3].offset = float3.size + float4.size + float3.size
        
        vertexDescriptor.layouts[0].stride = Vertex.stride
    }
}
