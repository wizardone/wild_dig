RSpec.describe WildDig do
  let(:hash_1) do
    {
      a: {
        b: {
          d: 'd',
          e: 'e'
        },
        c: 'c'
      }
    }
  end
  it 'digs regularly' do
    expect(WildDig.dig(hash_1, :a, :b, :d)).to eq('d')
    expect(WildDig.dig(hash_1, :a, :b)).to eq(d: 'd')
  end

  it 'digs wildly' do
    expect(WildDig.dig(hash_1, :a, :*, :d)).to eq('d')
  end
end
