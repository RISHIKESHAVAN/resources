# Section 4: Solidity

__Lab__: Remix

## Smart Contracts

+ Word was coined by a computer scientist Nick Szabo in 1994.
+ A smart contract can be defined as an _"automatic transaction handling algorithm"_
+ It is a piece of code running on the blockchain:
  + It is a state maching
  + Needs transactions to change state
  + Can do logical operations
+ Statechange happens through mining+transaction
+ It is Turing complete: _In theory_ it can solve any computation problem.
+ Commong Smart Contract programming languages: __Solidity__ (Most common; Derived from ECMAscript), __Vyper__ (Research oriented; Derived from Python), __LLL__ (Like Low-level Lisp), __Serpent__ (Similar to Python), __Mutan__ (Deprecated GO based language) . Post compilation, these are sent as __EVM Bytecode__ to the blockchain. The _data_ field in the transaction details contains the compiled code.
+ When you deploy the smart contract to the blockchain, every ethereum node in the network executes the same code because every node has a copy of the chain.

## Structure of a Solidity Contract

+ Start with the __pragma__ line. This is a pre-compiler statement. Locks in the solidity compiler version.
+ "__Class__" like structure.
+ Contains functions
+ Control structures: if/else
+ Loops: For/While
+ DataTypes: (U)Int, Boolean, Array, Struct, Mapping, Address. __No Floats__.
+ Inheritable
+ Special structures like "modifiers"
+ Imports
