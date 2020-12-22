//
//  MeshLibrary.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/19.
//

import MetalKit

enum MeshTypes {
    case None
    case Triangle_Custom
    case Quad_Custom
    case Cube_Custom
    case Cruiser
    case Sphere
    case SuzanneMonkey
}

class MeshLibrary: Library<MeshTypes, Mesh> {
    
    private var _library: [MeshTypes : Mesh] = [:]
    
    override func fillLibrary() {
        _library.updateValue(NoMesh(), forKey: .None)
        _library.updateValue(Triangle_CustomMesh(), forKey: .Triangle_Custom)
        _library.updateValue(Quad_CustomMesh(), forKey: .Quad_Custom)
        _library.updateValue(Cube_CustomMesh(), forKey: .Cube_Custom)
        _library.updateValue(Mesh(modelName: "cruiser"), forKey: .Cruiser)
        _library.updateValue(Mesh(modelName: "sphere"), forKey: .Sphere)
        _library.updateValue(Mesh(modelName: "SuzanneMonkey"), forKey: .SuzanneMonkey)
    }
    
    override subscript(type: MeshTypes) -> Mesh {
        return _library[type]!
    }
}

class Mesh {
    private var _vertices: [Vertex] = []
    private var _vertexCount: Int = 0
    private var _vertexBuffer: MTLBuffer!
    private var _instanceCount: Int = 1
    private var _submeshes: [Submesh] = []
    
    
    init() {
        createMesh()
        createBuffers()
    }
    
    init(modelName: String) {
        loadMeshFromModel(modelName)
    }
    
    func createMesh(){ }
    
    func createBuffers(){
        if _vertices.count > 0 {
            _vertexBuffer = Engine.Device.makeBuffer(bytes: _vertices,
                                                    length: Vertex.stride(_vertices.count),
                                                    options: [])
        }
    }
    
    func loadMeshFromModel(_ modelName: String) {
        guard let assetURL = Bundle.main.url(forResource: modelName, withExtension: "obj") else {
            fatalError("\(modelName) obj file not found")
        }
        
        let descriptor = MTKModelIOVertexDescriptorFromMetal(Graphics.VertexDescriptors[.Basic]!)
        (descriptor.attributes[0] as! MDLVertexAttribute).name = MDLVertexAttributePosition
        (descriptor.attributes[1] as! MDLVertexAttribute).name = MDLVertexAttributeColor
        (descriptor.attributes[2] as! MDLVertexAttribute).name = MDLVertexAttributeTextureCoordinate
        (descriptor.attributes[3] as! MDLVertexAttribute).name = MDLVertexAttributeNormal
        
        let bufferAllocator = MTKMeshBufferAllocator(device: Engine.Device)
        let asset: MDLAsset = MDLAsset(url: assetURL,
                                       vertexDescriptor: descriptor,
                                       bufferAllocator: bufferAllocator,
                                       preserveTopology: true,
                                       error: nil)
        var mtkMeshes: [MTKMesh] = []
        
        do {
            mtkMeshes = try MTKMesh.newMeshes(asset: asset, device: Engine.Device).metalKitMeshes
        } catch {
            print("\(modelName) load \(error)")
        }
        
        let mtkMesh = mtkMeshes[0]
        self._vertexBuffer = mtkMesh.vertexBuffers[0].buffer
        self._vertexCount = mtkMesh.vertexCount
        for i in mtkMesh.submeshes.indices {
            let mtkSubmesh = mtkMesh.submeshes[i]
            let submesh = Submesh(mtkSubmesh: mtkSubmesh)
            addSubmesh(submesh)
        }
    }
    
    func setInstanceCount(_ count: Int) {
        self._instanceCount = count
    }
    
    func addSubmesh(_ submesh: Submesh) {
        _submeshes.append(submesh)
    }
    
    func addVertex(position: float3, color: float4 = float4(1,0,1,1), textureCoordinate: float2 = float2(0, 0), normal: float3 = float3(0,1,0)) {
        _vertices.append(Vertex(position: position, color: color, textureCoordinate: textureCoordinate, normal: normal))
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        if _vertexBuffer != nil {
            renderCommandEncoder.setVertexBuffer(_vertexBuffer, offset: 0, index: 0)
            
            if _submeshes.count > 0 {
                
                for submesh in _submeshes {
                    renderCommandEncoder.drawIndexedPrimitives(type: submesh.primitiveType,
                                                               indexCount: submesh.indexCount,
                                                               indexType: submesh.indexType,
                                                               indexBuffer: submesh.indexBuffer,
                                                               indexBufferOffset: submesh.indexBufferOfferset)
                }
                
            }else {
                renderCommandEncoder.drawPrimitives(type: .triangle,
                                                    vertexStart: 0,
                                                    vertexCount: _vertices.count,
                                                    instanceCount: _instanceCount)
            }
        }
    }
}

class Submesh {
    private var _indices: [UInt32] = []
    
    private var _indexCount: Int = 0
    public var indexCount: Int {
        _indexCount
    }
    
    private var _indexBuffer: MTLBuffer!
    public var indexBuffer: MTLBuffer {
        _indexBuffer
    }
    
    private var _primitiveType: MTLPrimitiveType = .triangle
    public var primitiveType: MTLPrimitiveType {
        _primitiveType
    }
    
    private var _indexType: MTLIndexType = .uint32
    public var indexType: MTLIndexType {
        _indexType
    }
    
    private var _indexBufferOfferset: Int = 0
    public var indexBufferOfferset: Int {
        _indexBufferOfferset
    }
    
    init(indices: [UInt32]) {
        self._indices = indices
        self._indexCount = indices.count
        
    }
    
    init(mtkSubmesh: MTKSubmesh) {
        _indexBuffer = mtkSubmesh.indexBuffer.buffer
        _indexBufferOfferset = mtkSubmesh.indexBuffer.offset
        _indexCount = mtkSubmesh.indexCount
        _indexType = mtkSubmesh.indexType
        _primitiveType = mtkSubmesh.primitiveType
    }
    
    private func createIndexBuffer() {
        if _indices.count > 0 {
            _indexBuffer = Engine.Device.makeBuffer(bytes: _indices,
                                                    length: UInt32.stride(_indices.count),
                                                    options: [])
        }
    }
    
}

class NoMesh: Mesh { }

class Triangle_CustomMesh: Mesh {
    override func createMesh() {
        addVertex(position: float3( 0, 1,0), color: float4(1,0,0,1))
        addVertex(position: float3(-1,-1,0), color: float4(0,1,0,1))
        addVertex(position: float3( 1,-1,0), color: float4(0,0,1,1))
    }
}

class Quad_CustomMesh: Mesh {
    override func createMesh() {
        addVertex(position: float3( 1, 1,0), color: float4(1,0,0,1), textureCoordinate: float2(1, 0), normal: float3(0, 0, 1)) //Top Right
        addVertex(position: float3(-1, 1,0), color: float4(0,1,0,1), textureCoordinate: float2(0, 0), normal: float3(0, 0, 1)) //Top Left
        addVertex(position: float3(-1,-1,0), color: float4(0,0,1,1), textureCoordinate: float2(0, 1), normal: float3(0, 0, 1)) //Bottom Left
        addVertex(position: float3( 1,-1,0), color: float4(1,0,1,1), textureCoordinate: float2(1, 1), normal: float3(0, 0, 1)) //Bottom Right
        
        addSubmesh(Submesh(indices: [0, 1, 2, 0, 2, 3]))
    }
}

class Cube_CustomMesh: Mesh {
    override func createMesh() {
        //Left
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: float3(-1.0,-1.0, 1.0), color: float4(0.0, 1.0, 0.5, 1.0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(0.0, 0.5, 1.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(1.0, 0.0, 1.0, 1.0))
        
        //RIGHT
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 0.0, 0.5, 1.0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(0.0, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(0.0, 0.5, 1.0, 1.0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 0.5, 1.0, 1.0))
        
        //TOP
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 0.0, 0.0, 1.0))
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(0.0, 1.0, 0.0, 1.0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(0.0, 0.0, 1.0, 1.0))
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(0.5, 1.0, 1.0, 1.0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(1.0, 0.0, 1.0, 1.0))
        
        //BOTTOM
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(0.5, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(0.0, 0.0, 1.0, 1.0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 1.0, 0.5, 1.0))
        addVertex(position: float3(-1.0,-1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 0.5, 1.0, 1.0))
        
        //BACK
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(0.5, 1.0, 0.0, 1.0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(0.0, 0.0, 1.0, 1.0))
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(1.0, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 0.5, 1.0, 1.0))
        
        //FRONT
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(1.0, 0.5, 0.0, 1.0))
        addVertex(position: float3(-1.0,-1.0, 1.0), color: float4(0.0, 1.0, 0.0, 1.0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(0.5, 0.0, 1.0, 1.0))
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 1.0, 0.5, 1.0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 0.0, 1.0, 1.0))
    }

}
