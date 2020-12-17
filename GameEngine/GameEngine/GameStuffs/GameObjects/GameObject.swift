//
//  GameObject.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/19.
//

import MetalKit
class GameObject: Node {
    
    private var _modelConstants = ModelConstants()
    private var _material = Material()
    private var _textureType: TextureTypes = TextureTypes.None
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
        
        //fragment shader
        renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear], index: 0)
        renderCommandEncoder.setFragmentBytes(&_material, length: Material.stride, index: 1)
        if (_material.useTexture) {
            renderCommandEncoder.setFragmentTexture(Entities.Textures[_textureType], index: 0)
        }
        
        _mesh.drawPrimitives(renderCommandEncoder)
    }
}

extension GameObject {
    public func setMaterialColor(_ color: float4) {
        self._material.color = color
        self._material.useMaterialColor = true
    }
    
    public func setMaterialColor(_ r: Float,_ g: Float,_ b: Float,_ a: Float) {
        setMaterialColor(float4(r,g,b,a))
    }
    
    public func setTexture(_ textureType: TextureTypes) {
        self._textureType = textureType
        self._material.useTexture = true
        self._material.useMaterialColor = false
    }
    
    public func setMaterialIsLit(_ isLit: Bool) { self._material.isLit = isLit }
    public func setMaterialIsLit() -> Bool { return self._material.isLit }
    
    public func setMaterialAmbient(_ ambient: float3) { self._material.ambient = ambient }
    public func setMaterialAmbient(_ ambient: Float) { self._material.ambient = float3(ambient, ambient, ambient) }
    public func addMaterialAmbient(_ value: Float) { self._material.ambient += value }
    public func getMaterialAmbient() -> float3 { return self._material.ambient }
    
    public func setMaterialDiffuse(_ diffuse: float3) { self._material.diffuse = diffuse }
    public func setMaterialDiffuse(_ diffuse: Float) { self._material.diffuse = float3(diffuse, diffuse, diffuse) }
    public func addMaterialDiffuse(_ value: Float) { self._material.diffuse += value }
    public func getMaterialDiffuse() -> float3 { return self._material.diffuse }
    
    public func setMaterialSpecular(_ specular: float3) { self._material.specular = specular }
    public func setMaterialSpecular(_ specular: Float) { self._material.specular = float3(specular, specular, specular) }
    public func addMaterialSpecular(_ value: Float) { self._material.specular += value }
    public func getMaterialSpecular() -> float3 { return self._material.specular }
    
    public func setMaterialShininess(_ shininess: Float) { self._material.shininess = shininess }
    public func getMaterialShininess() -> Float { return self._material.shininess }
}
