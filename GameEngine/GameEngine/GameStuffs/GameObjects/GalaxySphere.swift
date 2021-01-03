//
//  GalaxySphere.swift
//  GameEngine
//
//  Created by 徐浩博 on 2021/1/4.
//

import MetalKit

class GalaxySphere: GameObject {
    
    override var renderPipelineStateTypes: RenderPipelineStateTypes {
        return .SkySphere
    }
    
    private var _skySphereTextureType: TextureTypes!
    
    init(skySphereTextureType: TextureTypes) {
        super.init(name: "SkySphere", meshType: .skysphere)
        
        _skySphereTextureType = skySphereTextureType
        setScale(500)
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setFragmentTexture(Entities.Textures[_skySphereTextureType], index: 10)
        super.render(renderCommandEncoder: renderCommandEncoder)
    }
}
