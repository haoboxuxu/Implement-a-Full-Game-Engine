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

class RenderPipelineStateLibrary {
    private static var renderPipelineStates: [RenderPipelineStateTypes : RenderPipelineState] = [:]
    
    public static func Initialize() {
        createDefaultRrenderPipelineStates()
    }
    
    private static func createDefaultRrenderPipelineStates() {
        renderPipelineStates.updateValue(Basic_RenderPipelineState(), forKey: .Basic)
        renderPipelineStates.updateValue(Instance_RenderPipelineState(), forKey: .Instance)
    }
    
    public static func PipelineStates(_ renderPipelineStateTypes: RenderPipelineStateTypes) -> MTLRenderPipelineState {
        return renderPipelineStates[renderPipelineStateTypes]!.renderPipelineState
    }
}

protocol RenderPipelineState {
    var name: String { get }
    var renderPipelineState: MTLRenderPipelineState! { get }
}

public struct Basic_RenderPipelineState: RenderPipelineState {
    var name: String = "Basic Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    init() {
        do {
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: RenderPipelineDescriptorLibrary.Descriptor(.Basic))
        } catch let error as NSError {
            print(error)
        }
    }
}


public struct Instance_RenderPipelineState: RenderPipelineState {
    var name: String = "Instance Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    init() {
        do {
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: RenderPipelineDescriptorLibrary.Descriptor(.Instance))
        } catch let error as NSError {
            print(error)
        }
    }
}
