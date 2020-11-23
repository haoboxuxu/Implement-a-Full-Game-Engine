//
//  GameObject.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/19.
//

import MetalKit
class GameObject: Node {
    
    var modelConstants = ModelConstants()
    private var material = Material()
    
    var mesh: Mesh!
    
    init(meshType: MeshTypes) {
        mesh = MeshLibrary.Mesh(meshType)
    }
    
    override func update(deltaTime: Float) {
        
        updateModelConstants()
    }
    
    private func updateModelConstants() {
        modelConstants.modelMatrix = self.modelMatrix
    }
}

extension GameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        //renderCommandEncoder.setTriangleFillMode(.lines)
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.PipelineStates(.Basic))
        renderCommandEncoder.setDepthStencilState(DepthStencilStateLibrary.DepthStencilState(.Less))
        
        //vertex shader
        renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
        
        //fragment shader
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 1)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)
    }
}

extension GameObject {
    public func setColor(_ color: float4) {
        self.material.color = color
        self.material.useMaterialColor = true
    }
}
