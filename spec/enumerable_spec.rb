# spec/enumerable_spec.rb
require_relative '../enumerable.rb'

describe Enumerable do
  describe '#my_each' do
    let(:new_arr) { [2, 6, 8] }

    it 'Should print the board' do
      expect do
        new_arr.my_each { |el| puts el + 2}
      end.to output("4\n8\n10\n").to_stdout
    end

    it 'Should iterate and do the the instructions in the block of code over each element of the array that is called from' do
      expect do
        expect(new_arr.my_each { |el| el + 2}).yield_control
      end
    end

  end

  describe '#my_each_with_index' do
    let(:new_arr) { [2, 6, 8] }

    it 'Should iterate and do the instructions in the block of code over each element of the array that is called from' do
      expect do
      new_arr.my_each_with_index { |el, i| puts el + i}
      end.to output("2\n7\n10\n").to_stdout
    end

    it 'Should iterate and do the the instructions in the block of code over each element of the array that is called from' do
      expect do
        expect(new_arr.my_each_with_index { |el| el + 2}).yield_control
      end
    end

  end

end