=begin
Question 3

We have most of the Munster family in our age hash:

  ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }

add ages for Marilyn and Spot to the existing hash

  additional_ages = { "Marilyn" => 22, "Spot" => 237 }
=end

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }

p ages.merge(additional_ages)

=begin

**Merge is definitely something I want to get better acquainted with:**

https://docs.ruby-lang.org/en/3.0.0/Hash.html#method-i-merge

merge → copy\_of\_self click to toggle source

merge(\*other\_hashes) → new\_hash

merge(\*other\_hashes) { |key, old\_value, new\_value| ... } → new\_hash

Returns the new Hash formed by merging each of `other_hashes` into a copy of `self`.

Each argument in `other_hashes` must be a Hash.

---

With arguments and no block:

*   Returns the new Hash object formed by merging each successive Hash in `other_hashes` into `self`.

*   Each new\-key entry is added at the end.

*   Each duplicate\-key entry's value overwrites the previous value.

Example:

h = {foo: 0, bar: 1, baz: 2}
h1 = {bat: 3, bar: 4}
h2 = {bam: 5, bat:6}
h.merge(h1, h2) \# => {:foo=>0, :bar=>4, :baz=>2, :bat=>6, :bam=>5}

With arguments and a block:

*   Returns a new Hash object that is the merge of `self` and each given hash.

*   The given hashes are merged left to right.

*   Each new\-key entry is added at the end.

*   For each duplicate key:

    *   Calls the block with the key and the old and new values.

    *   The block's return value becomes the new value for the entry.

Example:

h = {foo: 0, bar: 1, baz: 2}
h1 = {bat: 3, bar: 4}
h2 = {bam: 5, bat:6}
h3 = h.merge(h1, h2) { |key, old\_value, new\_value| old\_value + new\_value }
h3 \# => {:foo=>0, :bar=>5, :baz=>2, :bat=>9, :bam=>5}

With no arguments:

*   Returns a copy of `self`.

*   The block, if given, is ignored.

Example:

h = {foo: 0, bar: 1, baz: 2}
h.merge \# => {:foo=>0, :bar=>1, :baz=>2}
h1 = h.merge { |key, old\_value, new\_value| raise 'Cannot happen' }
h1 \# => {:foo=>0, :bar=>1, :baz=>2}

static VALUE
rb\_hash\_merge(int argc, VALUE \*argv, VALUE self)
{
    return rb\_hash\_update(argc, argv, rb\_hash\_dup(self));
}




=end