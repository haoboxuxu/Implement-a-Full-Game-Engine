//
//  CameraManger.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/21.
//

import Foundation

class CameraManger {
    
    private var _cameras: [CameraTypes : Camera] = [:]
    
    public var currentCamera: Camera!
    
    public func registerCamera(camera: Camera) {
        self._cameras.updateValue(camera, forKey: camera.cameraType)
    }
    
    public func setCamera(_ cameraType: CameraTypes) {
        self.currentCamera = _cameras[cameraType]
    }
    
    internal func update() {
        for camera in _cameras.values {
            camera.update()
        }
    }
}
