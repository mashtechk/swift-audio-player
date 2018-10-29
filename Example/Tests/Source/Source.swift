//
//  Sources.swift
//  SwiftAudio_Tests
//
//  Created by Jørgen Henrichsen on 05/08/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftAudio

struct Source {
    static let path: String = Bundle.main.path(forResource: "TestSound", ofType: "m4a")!
    static let url: URL = URL(fileURLWithPath: Source.path)
    
    static func getAudioItem() -> AudioItem {
        return DefaultAudioItem(audioUrl: Source.path, sourceType: .file, pitchAlgorithmType: .lowQualityZeroLatency)
    }
}

struct ShortSource {
    static let path: String = Bundle.main.path(forResource: "ShortTestSound", ofType: "m4a")!
    static let url: URL = URL(fileURLWithPath: Source.path)
    
    static func getAudioItem() -> AudioItem {
        return DefaultAudioItem(audioUrl: ShortSource.path, sourceType: .file, pitchAlgorithmType: .lowQualityZeroLatency)
    }
}
