//
//  SceneManger.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/20.
//

import MetalKit

enum SceneTypes {
    case Sandbox
    case UnRealScene
}

class SceneManger {
    private static var _currentScene: Scene!
    
    public static func Initialize(_ sceneType: SceneTypes) {
        SetScene(sceneType)
    }
    
    public static func SetScene(_ sceneType: SceneTypes) {
        switch sceneType {
        case .Sandbox:
            _currentScene = SandboxScene(name: "SandboxScene")
        case .UnRealScene:
            _currentScene = UnRealScene(name: "UnRealScene")
        }
    }
    
    public static func TickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        GameTime.UpdateTime(deltaTime)
        
        _currentScene.updateCameras()
        
        _currentScene.update()
        
        _currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
}
