//
//  InstanceGameObject.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/24.
//

import MetalKit

class InstanceGameObject: Node {
    
    private var _mesh: Mesh!
    
    var material = Material()
    
    internal var _nodes: [Node] = []
    private var _modelConstantBuffer: MTLBuffer!
    
    init(meshType: MeshTypes, instanceCount: Int) {
        super.init(name: "Instance Game Object")
        self._mesh = MeshLibrary.Mesh(meshType)
        self._mesh.setInstanceCount(instanceCount)
        self.generateInstance(instanceCount)
        self.createBuffers(instanceCount)
    }
    
    func generateInstance(_ instanceCount: Int) {
        for _ in 0..<instanceCount {
            _nodes.append(Node())
        }
    }
    
    func createBuffers(_ instanceCount: Int) {
        _modelConstantBuffer = Engine.Device.makeBuffer(length: ModelConstants.stride(instanceCount), options: [])
    }
    
    private func updateModelConstantsBuffer() {
        var poinster = _modelConstantBuffer.contents().bindMemory(to: ModelConstants.self, capacity: _nodes.count)
        for node in _nodes {
            poinster.pointee.modelMatrix = matrix_multiply(self.modelMatrix, node.modelMatrix)
            poinster = poinster.advanced(by: 1)
        }
    }
    
    override func update() {
        updateModelConstantsBuffer()
        super.update()
    }
}

extension InstanceGameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.PipelineStates(.Instance))
        
        renderCommandEncoder.setDepthStencilState(DepthStencilStateLibrary.DepthStencilState(.Less))
        
        //vertex shader
        renderCommandEncoder.setVertexBuffer(_modelConstantBuffer, offset: 0, index: 2)
        
        //fragment shader
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 1)
        
        _mesh.drawPrimitives(renderCommandEncoder)
    }
}

extension InstanceGameObject {
    public func setColor(_ color: float4) {
        self.material.color = color
        self.material.useMaterialColor = true
    }
}
