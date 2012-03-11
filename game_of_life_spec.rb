require 'rspec'
require File.expand_path('../gol', __FILE__)

describe Game do
  subject { Game.new(5,5) }

  describe '#grid' do
    it 'should have 5 rows and 5 columns' do
      subject.grid.should == [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0]
      ]
    end
  end

  describe '#to_s' do
    it 'should be as expected' do
      subject.to_s.should == "00000\n00000\n00000\n00000\n00000\n"
    end
  end

  describe '#load' do
    it 'should set expected cells as alive' do
      subject.load([0,1], [3,4])
      subject.to_s.should == "01000\n00000\n00000\n00001\n00000\n"
    end
  end

  describe '#live_neighbors_count' do
    before { subject.load([2,1], [2,2], [2,3]) }

    # [0,0,0,0,0]
    # [0,0,0,0,0]
    # [0,1,1,1,0]
    # [0,0,0,0,0]
    # [0,0,0,0,0]

    it 'should return 2 for 2,2' do
      subject.live_neighbors_count(2, 2).should == 2
    end

    it 'should return 3 for 1,2' do
      subject.live_neighbors_count(1, 2).should == 3
    end

    it 'should return zero for 0,0' do
      subject.live_neighbors_count(0, 0).should be_zero
    end
  end

  describe '#tick' do
    before { subject.load([2,1], [2,2], [2,3]) }

    it 'should oscillate' do
      state_0 = subject.to_s
      state_1 = "00000\n00100\n00100\n00100\n00000\n"
      expect { subject.tick}.to change(subject, :to_s).to(state_1)
      expect { subject.tick}.to change(subject, :to_s).to(state_0)
    end
  end
end
