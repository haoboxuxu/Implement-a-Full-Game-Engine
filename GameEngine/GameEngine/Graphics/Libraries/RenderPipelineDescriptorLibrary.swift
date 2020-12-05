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

class RenderPipelineDescriptorLibrary: Library<RenderPipelineDescriptorTypes, MTLRenderPipelineDescriptor> {
    
    private var _library: [RenderPipelineDescriptorTypes : RenderPipelineDescriptor] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Basic_RenderPipelineDescriptor(), forKey: .Basic)
        _library.updateValue(Instance_RenderPipelineDescriptor(), forKey: .Instance)
    }
    
    override subscript(type: RenderPipelineDescriptorTypes) -> MTLRenderPipelineDescriptor {
        return _library[type]!.renderPipelineDescriptor
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
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Basic]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Basic]
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
    }
}

public struct Instance_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Instance Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Prefences.MainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Prefences.MainDepthPixelFormat
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Instance]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Basic]
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
    }
}
