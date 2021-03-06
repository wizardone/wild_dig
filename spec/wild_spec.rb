RSpec.describe Wild do
  let(:hash_1) do
    {
      a: {
        b: { d: 'd', e: 'e' }
      }
    }
  end
  let(:hash_2) do
    {
      a: {
        b: { d: 'd', e: 'e'},
        c: 'c'
      }
    }
  end
  let(:hash_3) do
    {
      a: {
        b: {
          d: {
            f: 'f'
          }
        }
      }
    }
  end
  let(:hash_4) do
    {
      a: {
        b: 'b',
        c: ['c1', 'c2', 'c3']
      }
    }
  end
  let(:hash_5) do
    {
      a: 'a',
      b: [
        {c: 'c1', d: 'd1'},
        {f: 'c2', d: 'd2'},
        {g: 'c3', d: 'd3'},
      ]
    }
  end
  let(:hash_6) do
    {
      a: 'a',
      b: [
        {c: 'c1', d: 'd1'},
        {f: 'c2', x: 'x'},
        {g: 'c3', d: 'd3'},
      ]
    }
  end

  let(:hash_7) do
    {
      # TODO Fix this case, what do we have to return here?
      c: [1, 2, 3],
      a: { b: 'b', e: 'e' },
      z: 'z'
    }
  end

  it 'digs regularly' do
    expect(Wild.dig(hash_1, :a, :b, :d)).to eq('d')
    expect(Wild.dig(hash_1, :a, :b)).to eq(d: 'd', e: 'e')
  end

  it 'digs wildly' do
    expect(Wild.dig(hash_2, :a, :*, :e)).to eq('e')
    expect(Wild.dig(hash_2, :a, :*, :d)).to eq('d')

    expect(Wild.dig(hash_1, :a, :*, :d)).to eq('d')
    expect(Wild.dig(hash_1, :a, :*, :e)).to eq('e')

    expect(Wild.dig(hash_3, :a, :b, :*, :f)).to eq('f')

    expect(Wild.dig(hash_4, :a, :c)).to eq(['c1', 'c2', 'c3'])
    expect(Wild.dig(hash_4, :*, :c)).to eq(['c1', 'c2', 'c3'])
  end

  it 'digs wildly through array with multiple objects' do
    expect(Wild.dig(hash_5, :b, :*, :d)).to eq(['d1', 'd2', 'd3'])
    expect(Wild.dig(hash_6, :b, :*, :d)).to eq(['d1', 'd3'])
  end

  it 'digs wildly and returns the last wildcard element' do
    expect(Wild.dig(hash_7, :a, :*)).to eq({ b: 'b', e: 'e' })
    expect(Wild.dig(hash_7, :c, :*)).to eq([1,2,3])
    expect(Wild.dig(hash_7, :z, :*)).to eq('z')
  end
end
