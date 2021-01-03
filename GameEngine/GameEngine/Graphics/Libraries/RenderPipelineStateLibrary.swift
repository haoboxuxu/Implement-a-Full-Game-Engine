//
//  RenderPipelineStateLibrary.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/18.
//

import MetalKit

enum RenderPipelineStateTypes {
    case Basic
    case Instance
    case SkySphere
}

class RenderPipelineStateLibrary: Library<RenderPipelineStateTypes, MTLRenderPipelineState> {
    private var _library: [RenderPipelineStateTypes : RenderPipelineState] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Basic_RenderPipelineState(), forKey: .Basic)
        _library.updateValue(Instance_RenderPipelineState(), forKey: .Instance)
        _library.updateValue(SkySphere_RenderPipelineState(), forKey: .SkySphere)
    }
    
    override subscript(type: RenderPipelineStateTypes) -> MTLRenderPipelineState {
        return _library[type]!.renderPipelineState
    }
}

class RenderPipelineState {
    var renderPipelineState: MTLRenderPipelineState!
    init(renderPipelineDescriptor: MTLRenderPipelineDescriptor) {
        do {
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch let error as NSError {
            print(error)
        }
    }
}

class Basic_RenderPipelineState: RenderPipelineState {
    init() {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.label = "Basic_Render_Pipeline_Descriptor"
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preference.MainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preference.MainDepthPixelFormat
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.Shaders[.Basic_Vertex]
        renderPipelineDescriptor.fragmentFunction = Graphics.Shaders[.Basic_Fragment]
        super.init(renderPipelineDescriptor: renderPipelineDescriptor)
    }
}

class Instance_RenderPipelineState: RenderPipelineState {
    init() {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.label = "Instance_Render_Pipeline_Descriptor"
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preference.MainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preference.MainDepthPixelFormat
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.Shaders[.Instanced_Vertex]
        renderPipelineDescriptor.fragmentFunction = Graphics.Shaders[.Basic_Fragment]
        super.init(renderPipelineDescriptor: renderPipelineDescriptor)
    }
}

class SkySphere_RenderPipelineState: RenderPipelineState{
    init(){
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.label = "Sky Sphere Render Pipeline Descriptor"

        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preference.MainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preference.MainDepthPixelFormat
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]

        renderPipelineDescriptor.vertexFunction = Graphics.Shaders[.SkySphere_Vertex]
        renderPipelineDescriptor.fragmentFunction = Graphics.Shaders[.SkySphere_Fragment]

        super.init(renderPipelineDescriptor: renderPipelineDescriptor)
    }
}
