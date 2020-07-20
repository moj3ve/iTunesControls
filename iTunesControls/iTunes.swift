//
//  iTunes.swift
//  iTunesControls
//
//  Created by Ford on 7/19/20.
//  Copyright © 2020 MinhTon. All rights reserved.
//

import Foundation

open class iTunesControls: NSObject {
    
    public static var currentTrack = Track()
    
    public static var playerState: PlayerState {
        get {
            if let state = iTunesControls.executeAppleScriptWithString("get player state") {
                
                if let stateEnum = PlayerState(rawValue: state) {
                    return stateEnum
                }
            }
            return PlayerState.paused
        }
        
        set {
            switch newValue {
            case .paused:
                _ = iTunesControls.executeAppleScriptWithString("pause")
            case .playing:
                _ = iTunesControls.executeAppleScriptWithString("play")
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: InternalNotification.key), object: self)
        }
    }
    
    public static func playNext(_ completionHandler: (()->())? = nil){
        _ = iTunesControls.executeAppleScriptWithString("play (next track)")
        completionHandler?()
        NotificationCenter.default.post(name: Notification.Name(rawValue: InternalNotification.key), object: self)
    }
    
    public static func playPrevious(_ completionHandler: (() -> ())? = nil){
        _ = iTunesControls.executeAppleScriptWithString("play (previous track)")
        completionHandler?()
        NotificationCenter.default.post(name: Notification.Name(rawValue: InternalNotification.key), object: self)
    }
    
    
    public static func startiTunes(hidden: Bool = true, completionHandler: (() -> ())? = nil){
        let option: StartOptions
        switch hidden {
        case true:
            option = .withoutUI
        case false:
            option = .withUI
        }
        _ = iTunesControls.startiTunes(option: option)
        completionHandler?()
        NotificationCenter.default.post(name: Notification.Name(rawValue: InternalNotification.key), object: self)
    }
    
    
    public static func activateiTunes(completionHandler: (() -> ())? = nil){
        _ = iTunesControls.activateiTunes()
        completionHandler?()
        NotificationCenter.default.post(name: Notification.Name(rawValue: InternalNotification.key), object: self)
    }
    
    static func executeAppleScriptWithString(_ command: String) -> String? {
        let myAppleScript = "if application \"iTunes\" is running then tell application \"iTunes\" to \(command)"
        
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            return scriptObject.executeAndReturnError(&error).stringValue
        }
        return nil
    }
    
    
    enum StartOptions {
        case withUI
        case withoutUI
    }
    
    static func startiTunes(option:StartOptions) -> String? {
        let command:String;
        switch option {
        case .withoutUI:
            command = "run"
        case .withUI:
            command = "launch"
        }
        
        let myAppleScript = "if application \"iTunes\" is not running then \(command) application \"iTunes\""
        
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            return scriptObject.executeAndReturnError(&error).stringValue
        }
        return nil
    }
    
    static func activateiTunes() -> String? {
        
        let myAppleScript = "activate application \"iTunes\""
        
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            return scriptObject.executeAndReturnError(&error).stringValue
        }
        return nil
    }
    
}
