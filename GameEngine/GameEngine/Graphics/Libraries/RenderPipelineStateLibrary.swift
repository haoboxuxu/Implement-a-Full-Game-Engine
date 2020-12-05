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
}

class RenderPipelineStateLibrary: Library<RenderPipelineStateTypes, MTLRenderPipelineState> {
    private var _library: [RenderPipelineStateTypes : RenderPipelineState] = [:]
    
    override func fillLibrary() {
        _library.updateValue(RenderPipelineState(renderPipelineDescriptorTypes: .Basic), forKey: .Basic)
        _library.updateValue(RenderPipelineState(renderPipelineDescriptorTypes: .Instance), forKey: .Instance)
    }
    
    override subscript(type: RenderPipelineStateTypes) -> MTLRenderPipelineState {
        return _library[type]!.renderPipelineState
    }
}

class RenderPipelineState {
    var renderPipelineState: MTLRenderPipelineState!
    init(renderPipelineDescriptorTypes: RenderPipelineDescriptorTypes) {
        do {
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: Graphics.RenderPipelineDescriptors[renderPipelineDescriptorTypes])
        } catch let error as NSError {
            print(error)
        }
    }
}
