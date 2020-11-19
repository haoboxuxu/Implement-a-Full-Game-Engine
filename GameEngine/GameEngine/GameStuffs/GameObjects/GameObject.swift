//
//  GameObject.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/19.
//

import MetalKit
class GameObject: Node {
    
    var modelConstants = ModelConstants()
    
    var mesh: Mesh!
    
    var time: Float = 0
    
    init(meshType: MeshTypes) {
        mesh = MeshLibrary.Mesh(meshType)
    }
    
    func update(deltaTime: Float) {
        time += deltaTime
        
        self.position.x = cos(time)
        self.position.x = sin(time)
        self.scale = float3(cos(time))
        self.rotation.z = cos(time)
        
        updateModelConstants()
    }
    
    private func updateModelConstants() {
        modelConstants.modelMatrix = self.modelMatrix
    }
}

extension GameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        //renderCommandEncoder.setTriangleFillMode(.lines)
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 1)
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.PipelineStates(.Basic))
        renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)
    }
}
