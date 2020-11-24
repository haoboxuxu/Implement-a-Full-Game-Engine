//
//  RenderPipelineDescriptor.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/18.
//

import MetalKit

enum RenderPipelineDescriptorTypes {
    case Basic
    case Instance
}

class RenderPipelineDescriptorLibrary {
    
    private static var renderPipelineDescriptor: [RenderPipelineDescriptorTypes : RenderPipelineDescriptor] = [:]
    
    public static func Initialize() {
        createDefaultRenderPipelineDescriptor()
    }
    
    private static func createDefaultRenderPipelineDescriptor() {
        renderPipelineDescriptor.updateValue(Basic_RenderPipelineDescriptor(), forKey: .Basic)
        renderPipelineDescriptor.updateValue(Instance_RenderPipelineDescriptor(), forKey: .Instance)
    }
    
    public static func Descriptor(_ renderPipelineDescriptorType: RenderPipelineDescriptorTypes) -> MTLRenderPipelineDescriptor {
        return renderPipelineDescriptor[renderPipelineDescriptorType]!.renderPipelineDescriptor
    }
}

protocol RenderPipelineDescriptor {
    var name: String { get }
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor! { get }
}

public struct Basic_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Basic Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Prefences.MainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Prefences.MainDepthPixelFormat
        renderPipelineDescriptor.vertexFunction = ShaderLibrary.Vertex(.Basic)
        renderPipelineDescriptor.fragmentFunction = ShaderLibrary.Fragment(.Basic)
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptorLibrary.Descriptor(.Basic)
    }
}

public struct Instance_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Instance Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Prefences.MainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Prefences.MainDepthPixelFormat
        renderPipelineDescriptor.vertexFunction = ShaderLibrary.Vertex(.Instance)
        renderPipelineDescriptor.fragmentFunction = ShaderLibrary.Fragment(.Basic)
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptorLibrary.Descriptor(.Basic)
    }
}
