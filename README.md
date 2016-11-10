# ZipNsequence
A GYD template for producing ZipSequences of arbitrary arity.

## Usage:

1. Import one of the pre-generated ZipSequence swift source files.
2. Use them just like you would expect:

 ```Swift
let a = [1, 2, 3]
let b = [4, 5, 6]
let c = [7, 8, 9]
for (x, y, z) in zip(a, b, c) {
        print("\(x) \(y) \(z)")
}
```

## Generating Custom Arity ZipSequences

If the pre-generaged ZipSequences don't suite your needs, generate your own:

1. Obtain a copy of the Generate Your Boilerplate  preprocessor (`gyb.py`) from the [Swift repository](https://github.com/apple/swift/blob/master/utils/gyb.py).
2. Run is with the following syntax:

 `python gyb.py --line-directive '' -D arityS=3 ZipNSequence.swift.gyb -o Zip3Sequence.swift`
  * The input gyb tempalte is `ZipNSequence.swift.gyb`
  * The arity is 3 (in this example)
  * The output file is Zip3Sequence.swift
