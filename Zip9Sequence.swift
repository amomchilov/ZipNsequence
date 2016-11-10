
/// Creates a sequence of tuples built out of 9 underlying sequences.
///
/// In the `Zip9Sequence` instance returned by this function, the elements of
/// the *i*th tuple are the *i*th elements of each underlying sequence. The
/// following example uses the `zip(_:_:)` function to iterate over an array
/// of strings and a countable range at the same time:
///
///     let words = ["one", "two", "three", "four"]
///     let numbers = 1...4
///
///     for (word, number) in zip(words, numbers) {
///         print("\(word): \(number)")
///     }
///     // Prints "one: 1"
///     // Prints "two: 2
///     // Prints "three: 3"
///     // Prints "four: 4"
///
/// If the 9 sequences passed to `zip(_:_:_:_:_:_:_:_:_:)` are different lengths, the
/// resulting sequence is the same length as the shortest sequence. In this
/// example, the resulting array is the same length as `words`:
///
///     let naturalNumbers = 1...Int.max
///     let zipped = Array(zip(words, naturalNumbers))
///     // zipped == [("one", 1), ("two", 2), ("three", 3), ("four", 4)]
///
/// - Parameters:
///   - sequence1: The sequence or collection in position 1 of each tuple.
///   - sequence2: The sequence or collection in position 2 of each tuple.
///   - sequence3: The sequence or collection in position 3 of each tuple.
///   - sequence4: The sequence or collection in position 4 of each tuple.
///   - sequence5: The sequence or collection in position 5 of each tuple.
///   - sequence6: The sequence or collection in position 6 of each tuple.
///   - sequence7: The sequence or collection in position 7 of each tuple.
///   - sequence8: The sequence or collection in position 8 of each tuple.
///   - sequence9: The sequence or collection in position 9 of each tuple.
/// - Returns: A sequence of tuple pairs, where the elements of each pair are
///   corresponding elements of `sequence1` and `sequence2`.
public func zip<
Sequence1 : Sequence,
Sequence2 : Sequence,
Sequence3 : Sequence,
Sequence4 : Sequence,
Sequence5 : Sequence,
Sequence6 : Sequence,
Sequence7 : Sequence,
Sequence8 : Sequence,
Sequence9 : Sequence
>(
  _ sequence1: Sequence1,
  _ sequence2: Sequence2,
  _ sequence3: Sequence3,
  _ sequence4: Sequence4,
  _ sequence5: Sequence5,
  _ sequence6: Sequence6,
  _ sequence7: Sequence7,
  _ sequence8: Sequence8,
  _ sequence9: Sequence9

) -> Zip9Sequence<
Sequence1,
Sequence2,
Sequence3,
Sequence4,
Sequence5,
Sequence6,
Sequence7,
Sequence8,
Sequence9
> {
  return Zip9Sequence(
    _sequence1: sequence1,
    _sequence2: sequence2,
    _sequence3: sequence3,
    _sequence4: sequence4,
    _sequence5: sequence5,
    _sequence6: sequence6,
    _sequence7: sequence7,
    _sequence8: sequence8,
    _sequence9: sequence9
  )
}

/// An iterator for `Zip9Sequence`.
public struct Zip9Iterator<
  Iterator1 : IteratorProtocol,
  Iterator2 : IteratorProtocol,
  Iterator3 : IteratorProtocol,
  Iterator4 : IteratorProtocol,
  Iterator5 : IteratorProtocol,
  Iterator6 : IteratorProtocol,
  Iterator7 : IteratorProtocol,
  Iterator8 : IteratorProtocol,
  Iterator9 : IteratorProtocol
> : IteratorProtocol {
  /// The type of element returned by `next()`.
  public typealias Element = (
      Iterator1.Element,
      Iterator2.Element,
      Iterator3.Element,
      Iterator4.Element,
      Iterator5.Element,
      Iterator6.Element,
      Iterator7.Element,
      Iterator8.Element,
      Iterator9.Element
  )

  /// Creates an instance around the underlying iterators.
  internal init(
      _ iterator1: Iterator1,
      _ iterator2: Iterator2,
      _ iterator3: Iterator3,
      _ iterator4: Iterator4,
      _ iterator5: Iterator5,
      _ iterator6: Iterator6,
      _ iterator7: Iterator7,
      _ iterator8: Iterator8,
      _ iterator9: Iterator9
  ) {
    _baseStream1 = iterator1
    _baseStream2 = iterator2
    _baseStream3 = iterator3
    _baseStream4 = iterator4
    _baseStream5 = iterator5
    _baseStream6 = iterator6
    _baseStream7 = iterator7
    _baseStream8 = iterator8
    _baseStream9 = iterator9
  }

  /// Advances to the next element and returns it, or `nil` if no next element
  /// exists.
  ///
  /// Once `nil` has been returned, all subsequent calls return `nil`.
  public mutating func next() -> Element? {
    // The next() function needs to track if it has reached the end.  If we
    // didn't, and the first sequence is longer than the second, then when we
    // have already exhausted the second sequence, on every subsequent call to
    // next() we would consume and discard one additional element from the
    // first sequence, even though next() had already returned nil.

    if _reachedEnd {
      return nil
    }

    guard
        let element1 = _baseStream1.next(),
        let element2 = _baseStream2.next(),
        let element3 = _baseStream3.next(),
        let element4 = _baseStream4.next(),
        let element5 = _baseStream5.next(),
        let element6 = _baseStream6.next(),
        let element7 = _baseStream7.next(),
        let element8 = _baseStream8.next(),
        let element9 = _baseStream9.next()
    else {
      _reachedEnd = true
      return nil
    }

    return (
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
        element8,
        element9
    )
  }

  internal var _baseStream1: Iterator1
  internal var _baseStream2: Iterator2
  internal var _baseStream3: Iterator3
  internal var _baseStream4: Iterator4
  internal var _baseStream5: Iterator5
  internal var _baseStream6: Iterator6
  internal var _baseStream7: Iterator7
  internal var _baseStream8: Iterator8
  internal var _baseStream9: Iterator9
  internal var _reachedEnd: Bool = false
}

/// A sequence of pairs built out of two underlying sequences.
///
/// In a `Zip9Sequence` instance, the elements of the *i*th pair are the *i*th
/// elements of each underlying sequence. To create a `Zip9Sequence` instance,
/// use the `zip(_:_:_:_:_:_:_:_:_:)` function.
///
/// The following example uses the `zip(_:_:)` function to iterate over an
/// array of strings and a countable range at the same time:
///
///     let words = ["one", "two", "three", "four"]
///     let numbers = 1...4
///
///     for (word, number) in zip(words, numbers) {
///         print("\(word): \(number)")
///     }
///     // Prints "one: 1"
///     // Prints "two: 2
///     // Prints "three: 3"
///     // Prints "four: 4"
///
/// - SeeAlso: `zip(_:_:_:_:_:_:_:_:_:)`
public struct Zip9Sequence<
Sequence1 : Sequence,
Sequence2 : Sequence,
Sequence3 : Sequence,
Sequence4 : Sequence,
Sequence5 : Sequence,
Sequence6 : Sequence,
Sequence7 : Sequence,
Sequence8 : Sequence,
Sequence9 : Sequence
>
  : Sequence {

  public typealias Stream1 = Sequence1.Iterator
  public typealias Stream2 = Sequence2.Iterator
  public typealias Stream3 = Sequence3.Iterator
  public typealias Stream4 = Sequence4.Iterator
  public typealias Stream5 = Sequence5.Iterator
  public typealias Stream6 = Sequence6.Iterator
  public typealias Stream7 = Sequence7.Iterator
  public typealias Stream8 = Sequence8.Iterator
  public typealias Stream9 = Sequence9.Iterator

  /// A type whose instances can produce the elements of this
  /// sequence, in order.
  public typealias Iterator = Zip9Iterator<
    Stream1,
    Stream2,
    Stream3,
    Stream4,
    Stream5,
    Stream6,
    Stream7,
    Stream8,
    Stream9
>

  @available(*, unavailable, renamed: "Iterator")
  public typealias Generator = Iterator

  /// Creates an instance that makes pairs of elements from `sequence1` and
  /// `sequence2`.
  public // @testable
  init(
    _sequence1 sequence1: Sequence1,
    _sequence2 sequence2: Sequence2,
    _sequence3 sequence3: Sequence3,
    _sequence4 sequence4: Sequence4,
    _sequence5 sequence5: Sequence5,
    _sequence6 sequence6: Sequence6,
    _sequence7 sequence7: Sequence7,
    _sequence8 sequence8: Sequence8,
    _sequence9 sequence9: Sequence9
  ) {
    _sequence1 = sequence1
    _sequence2 = sequence2
    _sequence3 = sequence3
    _sequence4 = sequence4
    _sequence5 = sequence5
    _sequence6 = sequence6
    _sequence7 = sequence7
    _sequence8 = sequence8
    _sequence9 = sequence9
  }

  /// Returns an iterator over the elements of this sequence.
  public func makeIterator() -> Iterator {
    return Iterator(
      _sequence1.makeIterator(),
      _sequence2.makeIterator(),
      _sequence3.makeIterator(),
      _sequence4.makeIterator(),
      _sequence5.makeIterator(),
      _sequence6.makeIterator(),
      _sequence7.makeIterator(),
      _sequence8.makeIterator(),
      _sequence9.makeIterator()
    )
  }

  internal let _sequence1: Sequence1
  internal let _sequence2: Sequence2
  internal let _sequence3: Sequence3
  internal let _sequence4: Sequence4
  internal let _sequence5: Sequence5
  internal let _sequence6: Sequence6
  internal let _sequence7: Sequence7
  internal let _sequence8: Sequence8
  internal let _sequence9: Sequence9
}