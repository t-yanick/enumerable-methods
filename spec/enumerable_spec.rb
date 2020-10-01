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

  end

end