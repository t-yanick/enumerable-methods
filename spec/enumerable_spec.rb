# spec/enumerable_spec.rb
require_relative '../enumerable.rb'

describe Enumerable do
  describe '#my_each' do
    let(:new_arr) { [2, 6, 8] }

    it 'Iterate over the array is called and do the instructions in the block predicate over each element' do
      expect do
        new_arr.my_each { |el| puts el + 2}
      end.to output("4\n8\n10\n").to_stdout
    end

    it 'Iterate over the array is called and yield control to the block predicate' do
      expect(new_arr.my_each { |el| el + 2}).yield_self
    end

    it "Should return the enumerator if no block is given" do
      expect(new_arr.my_each).to be_an Enumerator
    end

  end

  describe '#my_each_with_index' do
    let(:new_arr) { [2, 6, 8] }

    it 'Iterate over the array is called, do the instructions in the block predicate over each element and returns an the elements changed based in the instructions of the block predicate' do
      expect do
      new_arr.my_each_with_index { |el, i| puts el + i}
      end.to output("2\n7\n10\n").to_stdout
    end

    it 'Iterate over the array is called and yield control to the block predicate' do
      expect(new_arr.my_each_with_index { |el| el + 2}).yield_self
    end

    it "Should return the enumerator if no block is given" do
      expect(new_arr.my_each_with_index).to be_an Enumerator
    end
  end

  describe '#my_select' do
    let(:new_arr) { [1,2,3,4,5] }

    it 'Iterate over the array is called, do the instructions in the block predicate over each element and return an array with the elements that comply with the block predicate' do
      result = [1,2,3,4,5].my_select { |num| num.even? }
      expect(result).to eq([2,4])
    end

    it 'Iterate over the array is called and yield control to the block predicate' do
      expect do
        expect(new_arr.my_select { |num| num.even? }).yield_self
      end
    end

    it "Should return the enumerator if no block is given" do
      expect(new_arr.my_select).to be_an Enumerator
    end
  end

  describe '#my_all?' do
    let(:new_arr) { [1, 2, 3, 5, 8] }
    let(:str_arr) { ['ant', 'bear', 'cat'] }

    it 'Iterate over the array is called and return a boolean either true or false, if all of the elements in the array satisfy the conditions specified in the block' do
      expect(new_arr.my_all? { |el| el > 3}).to eq(false)
    end

    it 'Iterate over the array is called and return a boolean either true or false, if all of the elements in the array are of the same class specified in the argument' do
      expect(new_arr.my_all? (Numeric)).to eq(true)
    end

    it 'Iterate over the array is called and return a boolean either true or false, if all of the elements in the array matches the regular expression specified in the argument' do
      expect(str_arr.my_all? (/d/)).to eq(false)
    end

    it 'Iterate over the array is called and yield control to the block predicate' do
      expect(new_arr.my_all? { |el| el > 3}).yield_self
    end
  end

  describe '#my_any?' do
    let(:new_arr) { [1, 2, 3, 5, 8] }
    let(:str_arr) { ['ant', 'bear', 'cat'] }

    it 'Iterate over the array is called and return a boolean either true or false, if any of the elements in the array satisfy the conditions specified in the block' do
      expect(new_arr.my_any? { |el| el > 3}).to eq(true)
    end

    it 'Iterate over the array is called and return a boolean either true or false, if any of the elements in the array are of the same class specified in the argument' do
      expect(new_arr.my_any? (Numeric)).to eq(true)
    end

    it 'Iterate over the array is called and return a boolean either true or false, if any of the elements in the array matches the regular expression specified in the argument' do
      expect(str_arr.my_any? (/d/)).to eq(false)
    end

    it 'Iterate over the array is called and yield control to the block predicate' do
      expect(new_arr.my_any? { |el| el > 3}).yield_self
    end

  end

  describe '#my_none?' do
    let(:new_arr) { [1, 2, 3, 5, 8] }
    let(:str_arr) { ['ant', 'bear', 'cat'] }

    it 'Iterate over the array is called and return a boolean either true or false, if none of the elements in the array satisfy the conditions specified in the block' do
      expect(new_arr.my_none? { |el| el > 3}).to eq(false)
    end

    it 'Iterate over the array is called and return a boolean either true or false, if none of the elements in the array are of the same class specified in the argument' do
      expect(new_arr.my_none? (Numeric)).to eq(false)
    end

    it 'Iterate over the array is called and return a boolean either true or false, if none of the elements in the array matches the regular expression specified in the argument' do
      expect(str_arr.my_none? (/d/)).to eq(true)
    end

    it 'Iterate over the array is called and yield control to the block predicate' do
      expect(new_arr.my_none? { |el| el > 3}).yield_self
    end
  end

  describe '#my_count' do
    let(:new_arr) { [1, 2, 3, 5, 8] }

    it 'Iterate over the array is called and return the number of elements in the array that satisfy the conditions specified in the block' do
      expect(new_arr.my_count{ |el| el > 3}).to eq(2)
    end

    it 'Iterate over the array is called and yield control to the block predicate' do
      expect(new_arr.my_count { |el| el > 3}).yield_self
    end

  end

  describe '#my_map' do
    let(:new_arr) { [1, 2, 3, 5, 8] }

    it 'Iterate over the array is called and return a new array with booleans true or false, according to the elements satisfy the conditions specified in the block' do
      expect(new_arr.my_map{ |el| el > 3}).to eq([false, false, false, true, true])
    end

    it 'Iterate over the array is called and yield control to the block predicate' do
      expect(new_arr.my_map{ |el| el > 3}).yield_self
    end

    it "Should return the enumerator if no block is given" do
      expect(new_arr.my_map).to be_an Enumerator
    end
  end

  describe '#my_inject' do
    let(:new_range) { (5..10) }

    it "Should return the enumerator if no block is given" do
      expect{ new_range.my_inject }.to raise_error LocalJumpError
    end

    it 'Iterate over the array is called and return a the value of the operation perfomed in the block predicate' do
      expect(new_range.my_inject{ |sum, n| sum + n}).to eq(45)
    end

    it 'Iterate over the array is called and yield control to the block predicate' do
      expect(new_range.my_inject{ |sum, n| sum + n}).yield_self
    end

    it 'Iterate over the array is called and return a the value of the operation perfomed in the block predicate and the parameter given' do
      expect(new_range.my_inject(2) { |product, n| product * n }).to eq(302400)
    end

    it 'Iterate over the array is called and return a the value of the operation perfomed based in the symbol mathematical method provided in the argument' do
      expect(new_range.my_inject(:+)).to eq(45)
    end

    it 'Iterate over the array is called and return a the value of the operation perfomed with the first number parameter based the symbol mathematical method provided in the argument' do
      expect(new_range.my_inject(1, :*)).to eq(151200)
    end
    
  end
end
