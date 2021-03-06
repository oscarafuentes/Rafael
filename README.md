# Rafael

## Table of Contents

* Getting Started
* Introduction
* Requirements
* Installation
* Usage
* Documentation
* Versioning
* Maintainers
* License

## Getting Started

### Introduction

A non-deterministic Mealy finite-state machine (mathematical model).

### Requirements

The minimum deployment targets are as follows:

1. iOS - 10.0
2. watchOS - 3.0
3. tvOS - 10.0
4. macOS - 10.11

### Installation

- **Integrate as a sub-project**

Drag the .xcodeproj file into your workspace.

### Usage

Let's define a Turnstile as a finite-state machine .

```swift
import Rafael

public class Turnstile: RFiniteStateMachineState<TurnstileSymbol, TurnstileState> {

    public init() {
        super.init(.locked) { symbol, state in
            switch (symbol, state) {
                case (.pay, .locked):
                    return .unlocked
                case (.push, .unlocked):
                    return .locked
                default:
                    break
            }
        }
    }

}
```

In this scenario, we define a symbol as "pay" and "push", the two actions
associated with a turnstile.

```swift
import Rafael

public enum TurnstileSymbol: RFiniteStateMachineSymbol {

    case pay
    case push

}
```

We also define a state as "locked" and "unlocked", the two states a turnstile
can represent.

```swift
import Rafael

public enum TurnstileState: RFiniteStateMachineState {

    case locked
    case unlocked

}
```

The power of a finite-state machine lies in transduction.

```swift
let turnstile = Turnstile()
turnstile.transduce(.push); // .locked -> .locked
turnstile.transduce(.pay); // .locked -> .unlocked
turnstile.transduce(.push); // .unlocked -> .locked
```

## Documentation

### RFiniteStateMachine (Generic Types Σ: RFiniteStateMachineSymbol, S: RFiniteStateMachineState)

#### Instance Variables

* `s₀: S`: An initial state, an element of S.
* `δ: RFiniteStateMachineStateTransitionFunction`: The state-transition function: δ : S × Σ → S.
* `state: JObservable<RFiniteStateMachineState>`: The current state, an element of S.

#### Initializers

* `init(_ s₀: S, δ: @escaping RFiniteStateMachineStateTransitionFunction)`
    * Parameter `s₀`: An initial state, an element of S.
    * Parameter `δ`: The state-transition function: δ : S × Σ → S.

#### Instance Functions

* `transduce(_ symbol: Σ)` - Transduces the state-transition function to generate output based on a
     given input and/or a state.
    * Parameter `symbol`: A symbol from the input alphabet.

### RFiniteStateMachineSymbol

### RFiniteStateMachineState

## Versioning

This module uses [semantic versioning](http://semver.org/). For the versions available, see the [tags on this repository](https://github.com/oscarafuentes/Rafael/tags).

## Maintainers

* **Oscar Fuentes** - *Initial work* - [oscarafuentes](https://github.com/oscarafuentes)

## License

This project is licensed under the [MIT License](LICENSE.md)
