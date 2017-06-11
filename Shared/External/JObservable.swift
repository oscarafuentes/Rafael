//
//  JObservable.swift
//  Jacqueline
//
//  Created by Oscar Fuentes on 6/10/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//
import Foundation


/**
 A wrapper class which enables the observation of an object, including attachments,
 "will set" event types, and "did set" event types.
 */

open class JObservable<T> {
    
    public typealias JObservableValueFunction = (T) -> Void
    
    /**
     The current value, an element of generic type T.
     */
    
    open var value: T {
        didSet {
            for block in self.didSetBlocks {
                block(self.value)
            }
        }
        
        willSet {
            for block in self.willSetBlocks {
                block(self.value)
            }
        }
    }
    
    fileprivate var didSetBlocks: [JObservableValueFunction] = [JObservableValueFunction]()
    fileprivate var willSetBlocks: [JObservableValueFunction] = [JObservableValueFunction]()
    
    /**
     Initializes an observable object where:
     
     - Parameter value: An intial value which conforms to the designated generic type.
     
     - Returns: An observable object which conforms to the designated generic type.
     */
    
    public init(_ value: T) {
        self.value = value
    }
    
    /**
     Property observer which is called immediately after the new value is stored.
     
     - Parameter block: The code block to run immediately after the new value is stored.
     */
    
    open func observeDidSet(_ block: @escaping (T) -> Void) {
        block(self.value)
        self.didSetBlocks.append(block)
    }
    
    /**
     Property observer which is called just before the new value is stored.
     
     - Parameter block: The code block to run just before the new value is stored.
     */
    
    open func observeWillSet(_ block: @escaping (T) -> Void) {
        block(self.value)
        self.willSetBlocks.append(block)
    }
    
    /**
     Create a unidirectional dependency on another observable object.
     
     - Parameter dependency: The obserable object to bind to.
     */
    
    open func attach(_ dependency: JObservable<T>) {
        dependency.observeDidSet { (value: T) -> Void in
            self.value = value
        }
    }
    
}
