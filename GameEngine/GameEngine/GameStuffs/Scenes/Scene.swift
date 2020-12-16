//
//  Scene.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/20.
//

import MetalKit

class Scene: Node {
    
    private var _cameraManger = CameraManger()
    private var _lightManger = LightManger()
    private var _sceneConstants = SceneConstants()
    
    override init(name: String) {
        super.init(name: name)
        buildScene()
    }
    
    func buildScene() { }
    
    func addCamera(_ camera: Camera, _ isCurrentCamera: Bool  = true) {
        _cameraManger.registerCamera(camera: camera)
        if (isCurrentCamera) {
            _cameraManger.setCamera(camera.cameraType)
        }
    }
    
    func addLight(_ lightObject: LightObject) {
        self.addChild(lightObject)
        _lightManger.addLightObject(lightObject)
    }
    
    func updateSceneConstants() {
        _sceneConstants.viewMatrix = _cameraManger.currentCamera.viewMatrix
        _sceneConstants.projectionMatrix = _cameraManger.currentCamera.projectionMatrix
        _sceneConstants.totalGameTime = GameTime.TotalGameTime
        _sceneConstants.cameraPosition = _cameraManger.currentCamera.getPosition()
    }
    
    func updateCameras() {
        _cameraManger.update()
    }
    
    override func update() {
        updateSceneConstants()
        super.update()
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&_sceneConstants, length: SceneConstants.stride, index: 1)
        _lightManger.setLightData(renderCommandEncoder)
        super.render(renderCommandEncoder: renderCommandEncoder)
    }
}
