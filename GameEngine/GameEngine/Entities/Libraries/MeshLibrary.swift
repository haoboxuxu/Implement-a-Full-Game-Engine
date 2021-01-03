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
    case Quad
    case Cube_Custom
    case Cruiser
    case Sphere
    case SuzanneMonkey
    case Chest

    ///UnReal
    //terrain
    case terrain
    //characters
    case alien
    case astronautA
    case astronautB
    //cityunits
    case turret_double
    case machine_barrelLarge
    case machine_generator
    case machine_wireless
    //holidays
    case present
    case presentGreen
    case snowman
    case snowmanFancy
    case treeDecorated
    case treePineSnow
    case treePineSnowed
    case wreath
    
    //skysphere
    case skysphere
}

class MeshLibrary: Library<MeshTypes, Mesh> {

    private var _library: [MeshTypes : Mesh] = [:]

    override func fillLibrary() {
        _library.updateValue(NoMesh(), forKey: .None)
        _library.updateValue(Triangle_CustomMesh(), forKey: .Triangle_Custom)
        _library.updateValue(Mesh(modelName: "quad"), forKey: .Quad)
        _library.updateValue(Cube_CustomMesh(), forKey: .Cube_Custom)
        _library.updateValue(Mesh(modelName: "cruiser"), forKey: .Cruiser)
        _library.updateValue(Mesh(modelName: "sphere"), forKey: .Sphere)
        _library.updateValue(Mesh(modelName: "SuzanneMonkey"), forKey: .SuzanneMonkey)
        _library.updateValue(Mesh(modelName: "chest"), forKey: .Chest)

        //UnReal
        //terrian
        _library.updateValue(Mesh(modelName: "terrain"), forKey: .terrain)
        //characters
        _library.updateValue(Mesh(modelName: "alien"), forKey: .alien)
        _library.updateValue(Mesh(modelName: "astronautA"), forKey: .astronautA)
        _library.updateValue(Mesh(modelName: "astronautB"), forKey: .astronautB)
        //cityunits
        _library.updateValue(Mesh(modelName: "turret_double"), forKey: .turret_double)
        _library.updateValue(Mesh(modelName: "machine_barrelLarge"), forKey: .machine_barrelLarge)
        _library.updateValue(Mesh(modelName: "machine_generator"), forKey: .machine_generator)
        _library.updateValue(Mesh(modelName: "machine_wireless"), forKey: .machine_wireless)
        //holidays
        _library.updateValue(Mesh(modelName: "present"), forKey: .present)
        _library.updateValue(Mesh(modelName: "presentGreen"), forKey: .presentGreen)
        _library.updateValue(Mesh(modelName: "snowman"), forKey: .snowman)
        _library.updateValue(Mesh(modelName: "snowmanFancy"), forKey: .snowmanFancy)
        _library.updateValue(Mesh(modelName: "treeDecorated"), forKey: .treeDecorated)
        _library.updateValue(Mesh(modelName: "treePineSnow"), forKey: .treePineSnow)
        _library.updateValue(Mesh(modelName: "treePineSnowed"), forKey: .treePineSnowed)
        _library.updateValue(Mesh(modelName: "wreath"), forKey: .wreath)
        
        //skysphere
        _library.updateValue(Mesh(modelName: "skysphere"), forKey: .skysphere)
    }

    override subscript(type: MeshTypes) -> Mesh {
        return _library[type]!
    }
}

class Mesh {
    private var _vertices: [Vertex] = []
    private var _vertexCount: Int = 0
    private var _vertexBuffer: MTLBuffer! = nil
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

    private func createBuffers(){
        if _vertices.count > 0 {
            _vertexBuffer = Engine.Device.makeBuffer(bytes: _vertices,
                                                    length: Vertex.stride(_vertices.count),
                                                    options: [])
        }
    }

    func loadMeshFromModel(_ modelName: String, ext: String = "obj") {
        guard let assetURL = Bundle.main.url(forResource: modelName, withExtension: ext) else {
            fatalError("\(modelName) obj file not found")
        }

        let descriptor = MTKModelIOVertexDescriptorFromMetal(Graphics.VertexDescriptors[.Basic]!)
        (descriptor.attributes[0] as! MDLVertexAttribute).name = MDLVertexAttributePosition
        (descriptor.attributes[1] as! MDLVertexAttribute).name = MDLVertexAttributeColor
        (descriptor.attributes[2] as! MDLVertexAttribute).name = MDLVertexAttributeTextureCoordinate
        (descriptor.attributes[3] as! MDLVertexAttribute).name = MDLVertexAttributeNormal
        (descriptor.attributes[4] as! MDLVertexAttribute).name = MDLVertexAttributeTangent
        (descriptor.attributes[5] as! MDLVertexAttribute).name = MDLVertexAttributeBitangent

        let bufferAllocator = MTKMeshBufferAllocator(device: Engine.Device)
        let asset: MDLAsset = MDLAsset(url: assetURL,
                                       vertexDescriptor: descriptor,
                                       bufferAllocator: bufferAllocator,
                                       preserveTopology: true,
                                       error: nil)

        asset.loadTextures()

        var mdlMeshes: [MDLMesh] = []

        do {
            mdlMeshes = try MTKMesh.newMeshes(asset: asset, device: Engine.Device).modelIOMeshes

        } catch {
            print("\(modelName) load \(error)")
        }

        var mtkMeshes: [MTKMesh] = []
        for mdlMesh in mdlMeshes {
            mdlMesh.addTangentBasis(forTextureCoordinateAttributeNamed: MDLVertexAttributeTextureCoordinate,
                                    tangentAttributeNamed: MDLVertexAttributeTangent,
                                    bitangentAttributeNamed: MDLVertexAttributeBitangent)
            mdlMesh.vertexDescriptor = descriptor

            do {
                let mtkMesh = try MTKMesh(mesh: mdlMesh, device: Engine.Device)
                mtkMeshes.append(mtkMesh)
            } catch {
                print("\(modelName) load \(error)")
            }
        }

        let mtkMesh = mtkMeshes[0]
        let mdlMesh = mdlMeshes[0]

        self._vertexBuffer = mtkMesh.vertexBuffers[0].buffer
        self._vertexCount = mtkMesh.vertexCount

        for i in mtkMesh.submeshes.indices {
            let mtkSubmesh = mtkMesh.submeshes[i]
            let mdlSubmesh = mdlMesh.submeshes![i] as! MDLSubmesh
            let submesh = Submesh(mtkSubmesh: mtkSubmesh, mdlSubmesh: mdlSubmesh)
            addSubmesh(submesh)
        }
    }

    func setInstanceCount(_ count: Int) {
        self._instanceCount = count
    }

    func addSubmesh(_ submesh: Submesh) {
        _submeshes.append(submesh)
    }

    func addVertex(position: float3,
                   color: float4 = float4(1,0,1,1),
                   textureCoordinate: float2 = float2(0, 0),
                   normal: float3 = float3(0,1,0),
                   tangent: float3 = float3(1,0,0),
                   bitangent: float3 = float3(0,0,1)) {
        _vertices.append(Vertex(position: position, color: color, textureCoordinate: textureCoordinate, normal: normal, tangent: tangent, bitangent: bitangent))
    }

    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder,
                        material: Material? = nil,
                        baseColorTextureType: TextureTypes = .None,
                        normalMapTextureType: TextureTypes = .None) {
        if _vertexBuffer != nil {
            renderCommandEncoder.setVertexBuffer(_vertexBuffer, offset: 0, index: 0)

            if _submeshes.count > 0 {

                for submesh in _submeshes {

                    submesh.applyTextures(renderCommandEncoder: renderCommandEncoder,
                                          customBaseColorTextureType: baseColorTextureType,
                                          customnormalMapTextureType: normalMapTextureType)

                    submesh.applyMaterials(renderCommandEncoder: renderCommandEncoder,
                                           customMaterial: material)

                    renderCommandEncoder.drawIndexedPrimitives(type: submesh.primitiveType,
                                                               indexCount: submesh.indexCount,
                                                               indexType: submesh.indexType,
                                                               indexBuffer: submesh.indexBuffer,
                                                               indexBufferOffset: submesh.indexBufferOffset,
                                                               instanceCount: _instanceCount)
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

    private var _indexBufferOffset: Int = 0
    public var indexBufferOffset: Int {
        _indexBufferOffset
    }

    private var _material = Material()

    private var _baseColorTexture: MTLTexture!
    private var _normalMapTexture: MTLTexture!

    init(indices: [UInt32]) {
        self._indices = indices
        self._indexCount = indices.count
        createIndexBuffer()
    }

    init(mtkSubmesh: MTKSubmesh, mdlSubmesh: MDLSubmesh) {
        _indexBuffer = mtkSubmesh.indexBuffer.buffer
        _indexBufferOffset = mtkSubmesh.indexBuffer.offset
        _indexCount = mtkSubmesh.indexCount
        _indexType = mtkSubmesh.indexType
        _primitiveType = mtkSubmesh.primitiveType

        createTexture(mdlSubmesh.material!)
        createMaterial(mdlSubmesh.material!)
    }

    private func texture(for sematic: MDLMaterialSemantic,
                         in material: MDLMaterial?,
                         textureOrigin: MTKTextureLoader.Origin) -> MTLTexture? {
        let textureLoader = MTKTextureLoader(device: Engine.Device)
        guard let materialProperty = material?.property(with: sematic) else { return nil }
        guard let sourceTexture = materialProperty.textureSamplerValue?.texture else { return nil }

        let options: [MTKTextureLoader.Option : Any] = [
            MTKTextureLoader.Option.origin : textureOrigin as Any,
            MTKTextureLoader.Option.generateMipmaps : true
        ]

        let tex = try? textureLoader.newTexture(texture: sourceTexture, options: options)
        return tex
    }

    private func createTexture(_ mdlMaterial: MDLMaterial) {
        _baseColorTexture = texture(for: .baseColor, in: mdlMaterial, textureOrigin: .bottomLeft)
        _normalMapTexture = texture(for: .tangentSpaceNormal, in: mdlMaterial, textureOrigin: .bottomLeft)
    }

    private func createMaterial(_ mdlMaterial: MDLMaterial) {
        if let ambient = mdlMaterial.property(with: .emission)?.float3Value {
            _material.ambient = ambient
        }

        if let diffuse = mdlMaterial.property(with: .baseColor)?.float3Value {
            _material.diffuse = diffuse
        }

        if let specular = mdlMaterial.property(with: .specular)?.float3Value {
            _material.specular = specular
        }

        if let shininess = mdlMaterial.property(with: .specularExponent)?.floatValue {
            _material.shininess = shininess
        }
    }

    private func createIndexBuffer() {
        if _indices.count > 0 {
            _indexBuffer = Engine.Device.makeBuffer(bytes: _indices,
                                                    length: UInt32.stride(_indices.count),
                                                    options: [])
        }
    }

    func applyTextures(renderCommandEncoder: MTLRenderCommandEncoder,
                      customBaseColorTextureType: TextureTypes,
                      customnormalMapTextureType: TextureTypes) {

        _material.useBaseTexture = customBaseColorTextureType != .None || _baseColorTexture != nil
        _material.useNormalMapTexture = customnormalMapTextureType != .None || _normalMapTexture != nil
        
        renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear], index: 0)

        let baseColorTex = customBaseColorTextureType == .None ? _baseColorTexture : Entities.Textures[customBaseColorTextureType]
        renderCommandEncoder.setFragmentTexture(baseColorTex, index: 0)

        let normalMapTex = customnormalMapTextureType == .None ? _normalMapTexture : Entities.Textures[customnormalMapTextureType]
        renderCommandEncoder.setFragmentTexture(normalMapTex, index: 1)
    }

    func applyMaterials(renderCommandEncoder: MTLRenderCommandEncoder,
                        customMaterial: Material?) {

        var mat = customMaterial == nil ? _material : customMaterial
        renderCommandEncoder.setFragmentBytes(&mat, length: Material.stride, index: 1)
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

class Cube_CustomMesh: Mesh {
    override func createMesh() {
        //Left
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 0.5, 0.0, 1.0), normal: float3(-1, 0, 0))
        addVertex(position: float3(-1.0,-1.0, 1.0), color: float4(0.0, 1.0, 0.5, 1.0), normal: float3(-1, 0, 0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(0.0, 0.5, 1.0, 1.0), normal: float3(-1, 0, 0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 1.0, 0.0, 1.0), normal: float3(-1, 0, 0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0), normal: float3(-1, 0, 0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(1.0, 0.0, 1.0, 1.0), normal: float3(-1, 0, 0))

        //RIGHT
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 0.0, 0.5, 1.0), normal: float3( 1, 0, 0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(0.0, 1.0, 0.0, 1.0), normal: float3( 1, 0, 0))
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(0.0, 0.5, 1.0, 1.0), normal: float3( 1, 0, 0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(1.0, 1.0, 0.0, 1.0), normal: float3( 1, 0, 0))
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0), normal: float3( 1, 0, 0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 0.5, 1.0, 1.0), normal: float3( 1, 0, 0))

        //TOP
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 0.0, 0.0, 1.0), normal: float3( 0, 1, 0))
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(0.0, 1.0, 0.0, 1.0), normal: float3( 0, 1, 0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(0.0, 0.0, 1.0, 1.0), normal: float3( 0, 1, 0))
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 1.0, 0.0, 1.0), normal: float3( 0, 1, 0))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(0.5, 1.0, 1.0, 1.0), normal: float3( 0, 1, 0))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(1.0, 0.0, 1.0, 1.0), normal: float3( 0, 1, 0))

        //BOTTOM
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 0.5, 0.0, 1.0), normal: float3( 0,-1, 0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(0.5, 1.0, 0.0, 1.0), normal: float3( 0,-1, 0))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(0.0, 0.0, 1.0, 1.0), normal: float3( 0,-1, 0))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 1.0, 0.5, 1.0), normal: float3( 0,-1, 0))
        addVertex(position: float3(-1.0,-1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0), normal: float3( 0,-1, 0))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 0.5, 1.0, 1.0), normal: float3( 0,-1, 0))

        //BACK
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(1.0, 0.5, 0.0, 1.0), normal: float3( 0, 0,-1))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(0.5, 1.0, 0.0, 1.0), normal: float3( 0, 0,-1))
        addVertex(position: float3(-1.0, 1.0,-1.0), color: float4(0.0, 0.0, 1.0, 1.0), normal: float3( 0, 0,-1))
        addVertex(position: float3( 1.0, 1.0,-1.0), color: float4(1.0, 1.0, 0.0, 1.0), normal: float3( 0, 0,-1))
        addVertex(position: float3( 1.0,-1.0,-1.0), color: float4(0.0, 1.0, 1.0, 1.0), normal: float3( 0, 0,-1))
        addVertex(position: float3(-1.0,-1.0,-1.0), color: float4(1.0, 0.5, 1.0, 1.0), normal: float3( 0, 0,-1))

        //FRONT
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(1.0, 0.5, 0.0, 1.0), normal: float3( 0, 0, 1))
        addVertex(position: float3(-1.0,-1.0, 1.0), color: float4(0.0, 1.0, 0.0, 1.0), normal: float3( 0, 0, 1))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(0.5, 0.0, 1.0, 1.0), normal: float3( 0, 0, 1))
        addVertex(position: float3( 1.0, 1.0, 1.0), color: float4(1.0, 1.0, 0.5, 1.0), normal: float3( 0, 0, 1))
        addVertex(position: float3(-1.0, 1.0, 1.0), color: float4(0.0, 1.0, 1.0, 1.0), normal: float3( 0, 0, 1))
        addVertex(position: float3( 1.0,-1.0, 1.0), color: float4(1.0, 0.0, 1.0, 1.0), normal: float3( 0, 0, 1))
    }
}
