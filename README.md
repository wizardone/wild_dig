# wild_dig
Ruby dig method with a twist (wildcard)

`Wild.dig` allows you to dig into hashes using a wildcard (*) element
It behaves in the same way as a regular `dig` and in fact will call the original
`dig` method if you don't provide a wildcard
