//
//  GameView.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/18.
//

import MetalKit

class GameView: MTKView {
    
    var renderPipelineState: MTLRenderPipelineState!
    
    var vertices: [Vertex]!
    
    var vertexBuffer: MTLBuffer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.device = MTLCreateSystemDefaultDevice()
        Engine.Ignite(device: device!)
        
        self.clearColor = Prefences.clearColor
        self.colorPixelFormat = Prefences.MainPixelFormat
        
        createVertices()
        createBuffer()
    }
    
    func createVertices() {
        vertices = [
            Vertex(position: float3( 0, 1, 0), color: float4(1,0,0,1)),
            Vertex(position: float3(-1,-1, 0), color: float4(0,1,0,1)),
            Vertex(position: float3( 1,-1, 0), color: float4(0,0,1,1))
        ]
    }
    
    func createBuffer() {
        vertexBuffer = Engine.Device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
    }
    
    override func draw(_ dirtyRect: NSRect) {
        guard let drawable = self.currentDrawable, let renderPassDescriptor = self.currentRenderPassDescriptor else { return }
        let commandBuffer = Engine.CommandQuque.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.setRenderPipelineState(RenderPipelineStateLibrary.PipelineStates(.Basic))
        
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
