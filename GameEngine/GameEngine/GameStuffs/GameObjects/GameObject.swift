//
//  GameObject.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/19.
//

import MetalKit
class GameObject: Node {
    
    private var _modelConstants = ModelConstants()
    private var _material: Material? = nil
    private var _baseColorTextureType = TextureTypes.None
    private var _mesh: Mesh!
    
    init(name: String, meshType: MeshTypes) {
        super.init(name: name)
        _mesh = Entities.Meshes[meshType]
    }
    
    override func update() {
        updateModelConstants()
        super.update()
    }
    
    private func updateModelConstants() {
        _modelConstants.modelMatrix = self.modelMatrix
    }
}

extension GameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Basic])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        
        //vertex shader
        renderCommandEncoder.setVertexBytes(&_modelConstants, length: ModelConstants.stride, index: 2)
        
        _mesh.drawPrimitives(renderCommandEncoder, material: _material, baseColorTextureType: _baseColorTextureType)
    }
}

extension GameObject {
    public func useBaseColorTexture(_ textureType: TextureTypes) {
        self._baseColorTextureType = textureType
    }
    
    public func useMaterial(_ material: Material) {
        _material = material
    }
}
