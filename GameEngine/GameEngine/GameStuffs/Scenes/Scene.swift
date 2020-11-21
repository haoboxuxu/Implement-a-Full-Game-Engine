//
//  Scene.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/20.
//

import MetalKit

class Scene: Node {
    
    var cameraManger = CameraManger()
    var sceneConstants = SceneConstants()
    
    override init() {
        super.init()
        buildScene()
    }
    
    func buildScene() { }
    
    func addCamera(_ camera: Camera, _ isCurrentCamera: Bool  = true) {
        cameraManger.registerCamera(camera: camera)
        if (isCurrentCamera) {
            cameraManger.setCamera(camera.cameraTypes)
        }
    }
    
    func updateSceneConstants() {
        sceneConstants.viewMatrix = cameraManger.currentCamera.viewMatrix
        sceneConstants.projectionMatrix = cameraManger.currentCamera.projectionMatrix
    }
    
    func updateCameras(deltaTime: Float) {
        cameraManger.update(deltaTime: deltaTime)
    }
    
    override func update(deltaTime: Float) {
        updateSceneConstants()
        super.update(deltaTime: deltaTime)
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
        super.render(renderCommandEncoder: renderCommandEncoder)
    }
}
