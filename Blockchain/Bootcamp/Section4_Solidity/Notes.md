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

## Environments in Remix

+ __JavaScript VM__ : Creates an in memory blockchain node in the browser and deploys the contracts in it.
+ __Injected Web3__ : Creates a node in the test networks like MetaMask
+ __Web3 Provider__ : Allows you to connect to an external Blockchain Node prvider. One of the common one is [Ganache](<https://www.trufflesuite.com/ganache>).

## Ethereum Nodes and Networks

![ethprotocol](EthProtocol.JPG)

+ The nodes in the network are able to talk with each other because they are talking with the __Ethereum Protocol__.
+ There are different implementations of the same protocol in different languages: __GoEthereum__, __Parity__, __HyperLedger__.
+ It is not necessary to have one single Eth network. You can use ethereum inside a private network as well.

![privateandmainnet](MainAndPrivatNet.JPG)

+ And the two networks would not contain the same data especially if they are started from scratch. (i.e.) if you send any transaction in the private network, then it is registered only in the private network and it is not in the main network.
+ Another way of creating a private network is to fork the main network at some point in time. In this case, the data present in the main network upto that point in time would also be in the private network and then we can continue with the private network from there on.
+ Either way, the private network will start with the first block called the __Genesys block__ - it is the first block on the network and it comes from the genesys file which contains the configuration for the genesys block.

![diffnetworks](DiffNetworks.JPG)

+ The main network is the longest existing network and where ether costs money and the protocol seldom changes.
+ The other networks are very similar to the main network but they are here for testing things like consensus protocols, protocol changes and give smart contract developers the ability to test their contracts. But they all still require _mining_.
+ Thus developers implemented their own blockchain simulation - __Ganache__.

| Main Network | Test Network | Ganache |
| --- | --- | --- |
| Persistent | Persistent, but can be deleted | Non-Persistent |
| Real blockchain | Real blockchain | Unit testing |
| Costs money | Beta release | Fast|

## Variables

> __Transaction Vs. Call__ : A transaction is necessary, if a value in a Smart Contract needs to be updated (writing to state). A call is done, if a value is read. Transactions cost Ether (gas), need to be mined and therefore take a while until the value is reflected. Calls are virtually free and instant.

__All Variables__ :

+ All variables are initialized by default. There is no "null" or "undefined".
+ A _public variable_ automatically creates a _getter function_ with the name of the variable. You can not create a function with the same name as the variable by yourself.
+ Reference types (eg. strings) need a memory location (memory/storage).

__(Unsigned) Integers__ :

+ _Keyword_ : `uint`
+ Integers are numbers without decimals and _unsigned_ integers are capable of representing only __non-negative__ integers.
+ The default value for an integer is 0.
+ `uint8` to `uint256` in 8 bit increments (i.e.) `uint8`, `uint16`, `uint24`...
+ __Unsigned__ : `uint8` ranges from 0 to 255 (since 2<sup>8</sup> = 256). Similarly `uint256` had 2<sup>256</sup> values. `uint` is an alias for `uint256`.
+ __Signed__ :`int8` ranges from -128 to 127
+ __Integer Wrap Around__ (Prior to version 0.8.x) :
  + Prior Solidity 0.8.x, an integer would automatically roll-over to a higher or lower number (i.e.) decrementing an _unsigned integer_ of value 0 would not result in error or -1 but would give the value: `MAX(uint)`
  + This can become problematic, if you store a token-balance in a variable and decrement it without checking.
+ __Integer Wrap Around__ (Post version 0.8.x) :
  + In 0.8, the compiler will automatically take care of overflow and underflow and will throw an error when we try to increment or decrement past the limit.
  + But you can willfully roll over by wrapping the increment/decrement code inside the `unchecked` block.

__Booleans__ :

+ _Keyword_ : `bool`
+ The default value set to a bool variable is _false_.
+ Boolean types have the standard operators: ! (logical negation), && (logical conjunction, "and"), || (logical disjunction, "or"), == (equality), != (inequality).

__Addresses and Balances__ :

+ _Keyword_ : `address`
+ To store the address of an account.
+ Ethereum supports transfer of Ether and communication between Smart Contracts. Those reside on an _address_. Addresses can be stored in Smart Contracts in the address variable and can be used to transfer Ether from the Smart Contract to the address.
+ In general, the address variable holds __20 bytes__ of data.
+ One main parameter of the address type is `balance`. `address.balance` returns the balance of the account in Wei.

> __1 Ether = 10<sup>18</sup>Wei__. Ethereum Denominations: <https://ethdocs.org/en/latest/ether.html>

__Strings and Bytes__ :

+ _Keyword_ : `string`
+ By default strings will be empty.
+ It is not very easy to work with strings in Solidity because internally they are stored as _byte arrays_ and converted to UTF-8 and shown. Solidity is not really made for working with strings (larger strings especially) and it is quite expensive in terms of gas. Thus as a rule of thumb try to avoid strings and use __Events__ instead.
+ Natively there are no string manipulation functions (no string comparison, no find-replace etc.). But there are libraries to work with strings.
+ There are other ways to work with strings like storing them externally and using its hash to check if the string is valid etc.
+ String is equal to bytes, but does not have a length or index access.
+ Bytes for arbitrary length raw data.
+ Strings for arbitrary length string (UTF-8) data.

__Fixed Point Numbers (Not implemented yet)__ :

+ _Keyword_ : `ufixedMxN` or `fixedMxN`
+ `ufixed128x18` gives 128 bits with 18 decimal points.

> Not all rules of modern development apply to blockchain development (eg.) the limited resources available and the variable initialization.

## Important Concepts

+ The Smart Contract is stored under its own address
+ The Smart Contract can store an address in a variable, which can be its own address, but can be any other address as well.
+ All information on the blochain is public, so we can retrieve the balance of the address stored in a variable.
+ The Smart Contract can transfer funds from his own address to another address. _But it cannot transfer the funds from another address_.
+ Transferring Ether is fundamentally different than transferring ERC20 Tokens.
