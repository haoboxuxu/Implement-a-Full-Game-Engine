//
//  TextureLibrary.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/8.
//

import MetalKit

enum TextureTypes {
    case None
    case IMG
    case Cruiser
}

class TextureLibrary: Library<TextureTypes, MTLTexture> {
    private var _library: [TextureTypes : Texture] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Texture("img"), forKey: .IMG)
        _library.updateValue(Texture("cruiser", ext: "bmp", origin: .BottomLeft), forKey: .Cruiser)
    }
    
    override subscript(type: TextureTypes) -> MTLTexture? {
        return _library[type]?.texture
    }
}

class Texture {
    var texture: MTLTexture!
    
    init(_ textureName: String, ext: String = "JPG", origin: TextureOrigin = TextureOrigin.TopLeft) {
        let textureLoader = TextureLoader(textureName: textureName, textureExtension: ext, origin: origin)
        let texture: MTLTexture = textureLoader.loadTextureFromBundle()
        setTexture(texture)
    }
    
    func setTexture(_ texture: MTLTexture) {
        self.texture = texture
    }
}


public enum TextureOrigin {
    case TopLeft
    case BottomLeft
}

class TextureLoader {
    private var _textureName: String!
    private var _textureExtension: String!
    private var _origin: MTKTextureLoader.Origin!
    
    init(textureName: String, textureExtension: String = "JPG", origin: TextureOrigin = TextureOrigin.TopLeft) {
        self._textureName = textureName
        self._textureExtension = textureExtension
        self.setTextureOrigin(origin)
    }
    
    func setTextureOrigin(_ textureOrigin: TextureOrigin) {
        switch textureOrigin {
        case .TopLeft:
            self._origin = MTKTextureLoader.Origin.topLeft
        case .BottomLeft:
            self._origin = MTKTextureLoader.Origin.bottomLeft
        }
    }
    
    public func loadTextureFromBundle() -> MTLTexture {
        var result: MTLTexture!
        
        if let url = Bundle.main.url(forResource: _textureName, withExtension: _textureExtension) {
            let textureLoader = MTKTextureLoader(device: Engine.Device)
            
            let options: [MTKTextureLoader.Option : Any] = [MTKTextureLoader.Option.origin : _origin]
            
            do {
                result = try textureLoader.newTexture(URL: url, options: options)
                result.label = _textureName
            } catch let error as NSError {
                print(error)
            }
        }else {
            print("\(_textureName) not fount")
        }
        
        return result
    }
}
