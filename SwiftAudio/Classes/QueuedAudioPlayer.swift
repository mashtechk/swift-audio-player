//
//  QueuedAudioPlayer.swift
//  SwiftAudio
//
//  Created by Jørgen Henrichsen on 24/03/2018.
//

import Foundation


/**
 An audio player that can keep track of a queue of AudioItems.
 */
public class QueuedAudioPlayer: AudioPlayer {
    
    let queueManager: QueueManager = QueueManager<AudioItem>()
    
    /**
     Set wether the player should automatically play the next song when a song is finished.
     Default is `true`.
     */
    public var automaticallyPlayNextSong: Bool = true
    
    public override var currentItem: AudioItem? {
        return queueManager.current
    }
    
    /**
     The previous items held by the queue.
     */
    public var previousItems: [AudioItem]? {
        return queueManager.previousItems
    }
    
    /**
     The upcoming items in the queue.
     */
    public var nextItems: [AudioItem]? {
        return queueManager.nextItems
    }
    
    /**
     Add a single item to the queue.
     
     - parameter item: The item to add.
     - parameter playWhenReady: If the AudioPlayer has no item loaded, it will load the `item`. If this is `true` it will automatically start playback. Default is `true`.
     - throws: `APError`
     */
    public func add(item: AudioItem, playWhenReady: Bool = true) throws {
        if currentItem == nil {
            queueManager.addItem(item)
            try self.loadItem(item, playWhenReady: playWhenReady)
        }
        else {
            queueManager.addItem(item)
        }
    }
    
    /**
     Add items to the queue.
     
     - parameter items: The items to add to the queue.
     - parameter playWhenReady: If the AudioPlayer has no item loaded, it will load the first item in the list. If this is `true` it will automatically start playback. Default is `true`.
     - throws: `APError`
     */
    public func add(items: [AudioItem], playWhenReady: Bool = true) throws {
        if currentItem == nil {
            queueManager.addItems(items)
            try self.loadItem(currentItem!, playWhenReady: playWhenReady)
        }
        else {
            queueManager.addItems(items)
        }
    }
    
    /**
     Step to the next item in the queue.
     
     - throws: `APError`
     */
    public func next() throws {
        let nextItem = try queueManager.next()
        try self.loadItem(nextItem, playWhenReady: true)
    }
    
    /**
     Step to the previous item in the queue.
     */
    public func previous() throws {
        let previousItem = try queueManager.previous()
        try self.loadItem(previousItem, playWhenReady: true)
    }
    
    /**
     Remove an item from the queue.
     
     - parameter index: The index of the item to remove.
     - throws: `APError.QueueError`
     */
    public func removeItem(atIndex index: Int) throws {
        try queueManager.remove(atIndex: index)
    }
    
    /**
     Jump to a certain item in the queue.
     
     - parameter index: The index of the item to jump to.
     - parameter playWhenReady: Wether the item should start playing when ready. Default is `true`.
     - throws: `APError`
     */
    public func jumpToItem(atIndex index: Int, playWhenReady: Bool = true) throws {
        let item = try queueManager.jump(to: index)
        try self.loadItem(item, playWhenReady: playWhenReady)
    }
    
    /**
     Move an item in the queue from one position to another.
     
     - parameter fromIndex: The index of the item to move.
     - parameter toIndex: The index to move the item to.
     - throws: `APError.QueueError`
     */
    func moveItem(fromIndex: Int, toIndex: Int) throws {
        try queueManager.moveItem(fromIndex: fromIndex, toIndex: toIndex)
    }
    
    // MARK: - AVPlayerWrapperDelegate
    
    override func AVWrapperItemDidComplete() {
        super.AVWrapperItemDidComplete()
        if automaticallyPlayNextSong {
            try? self.next()
        }
    }
    
}
