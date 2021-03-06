//
//  TextureLibrary.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/8.
//

import MetalKit

enum TextureTypes {
    case None
    case BreakingBad
    case Cruiser
    case MetalPlateDiffuse
    case MetalPlateNormal
    
    //planet
    case earth_daymap
    case earth_nightmap
    case moon
    case moon_terrian
    
    //skysphere
    case galaxies
}

class TextureLibrary: Library<TextureTypes, MTLTexture> {
    private var _library: [TextureTypes : Texture] = [:]

    override func fillLibrary() {
        _library.updateValue(Texture("breakingbad"), forKey: .BreakingBad)
        _library.updateValue(Texture("cruiser", ext: "bmp", origin: .bottomLeft), forKey: .Cruiser)
        _library.updateValue(Texture("metal_plate_diff"), forKey: .MetalPlateDiffuse)
        _library.updateValue(Texture("metal_plate_nor"), forKey: .MetalPlateNormal)
        
        //planet
        _library.updateValue(Texture("earth_daymap", ext: "jpg", origin: .topLeft), forKey: .earth_daymap)
        _library.updateValue(Texture("earth_nightmap", ext: "jpg", origin: .topLeft), forKey: .earth_nightmap)
        _library.updateValue(Texture("moon", ext: "jpg", origin: .topLeft), forKey: .moon)
        _library.updateValue(Texture("moon_terrian", ext: "jpg", origin: .topLeft), forKey: .moon_terrian)
        
        //skysphere
        _library.updateValue(Texture("galaxies", ext: "png", origin: .bottomLeft), forKey: .galaxies)
    }

    override subscript(type: TextureTypes) -> MTLTexture? {
        return _library[type]?.texture
    }
}

class Texture {
    var texture: MTLTexture!

    init(_ textureName: String, ext: String = "png", origin: MTKTextureLoader.Origin = .topLeft) {
        let textureLoader = TextureLoader(textureName: textureName, textureExtension: ext, origin: origin)
        let texture: MTLTexture = textureLoader.loadTextureFromBundle()
        setTexture(texture)
    }

    func setTexture(_ texture: MTLTexture) {
        self.texture = texture
    }
}

class TextureLoader {
    private var _textureName: String!
    private var _textureExtension: String!
    private var _origin: MTKTextureLoader.Origin!

    init(textureName: String, textureExtension: String = "png", origin: MTKTextureLoader.Origin = .topLeft) {
        self._textureName = textureName
        self._textureExtension = textureExtension
        self._origin = origin
    }

    public func loadTextureFromBundle() -> MTLTexture {
        var result: MTLTexture!

        if let url = Bundle.main.url(forResource: _textureName, withExtension: _textureExtension) {
            let textureLoader = MTKTextureLoader(device: Engine.Device)

            let options: [MTKTextureLoader.Option : Any] = [
                MTKTextureLoader.Option.origin : _origin as Any,
                MTKTextureLoader.Option.generateMipmaps : true
            ]

            do {
                result = try textureLoader.newTexture(URL: url, options: options)
                result.label = _textureName
            } catch let error as NSError {
                print(error)
            }
        }else {
            print("no \(_textureName!) fount")
        }

        return result
    }
}
