//
//  Renderer.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/19.
//

import MetalKit

class Renderer: NSObject {
    var gameObjects: [Node] = [Player()]
    var player = Player()
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        //when window is resizxe
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        let commandBuffer = Engine.CommandQuque.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        player.update(deltaTime: 1 / Float(view.preferredFramesPerSecond))
        
        player.render(renderCommandEncoder: renderCommandEncoder!)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
    
}
