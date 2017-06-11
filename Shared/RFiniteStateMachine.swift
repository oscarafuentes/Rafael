//
//  RFiniteStateMachine.swift
//  Rafael
//
//  Created by Oscar Fuentes on 6/10/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation

/**
 A Non-Deterministic Mealy Finite-State Machine (Mathematical Model).
 
 - Σ: The input alphabet (a finite, non-empty set of symbols).
 - S: A finite, non-empty set of states.
 */

public class RFiniteStateMachine<Σ: RFiniteStateMachineSymbol, S: RFiniteStateMachineState> {
    
    /**
     A typealias representing the state-transition function block: δ : S × Σ → S.
     */
    
    public typealias RFiniteStateMachineStateTransitionFunction = (Σ, S) -> S?
    
    /**
     An initial state, an element of S.
     */
    
    public private(set) var s₀: S
    
    /**
     The state-transition function: δ : S × Σ → S.
     */
    
    public private(set) var δ: RFiniteStateMachineStateTransitionFunction
    
    /**
     The current state, an element of S.
     */
    
    public private(set) var state: JObservable<S>
    
    /**
     Initializes a non-deterministic Mealy finite-state machine as a quintuple
     (Σ, S, s₀, δ, F), where:
     
     - Parameter s₀: An initial state, an element of S.
     - Parameter δ: The state-transition function: δ : S × Σ → S.
     
     - Returns: A non-deterministic finite-state machine.
     */
    
    public init(s₀: S, δ: @escaping RFiniteStateMachineStateTransitionFunction) {
        self.s₀ = s₀
        self.δ = δ
        self.state = JObservable(s₀)
    }
    
    /**
     Transduces the state-transition function to generate output based on a
     given input and/or a state.
     
     - Parameter symbol: A symbol from the input alphabet.
     */
    
    public func transduce(symbol: Σ) {
        if let newState = self.δ(symbol, self.state.value) {
            self.state.value = newState
        }
    }
    
}
