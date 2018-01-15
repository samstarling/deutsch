include GermanHelper
include Nanoc::Helpers::Capturing
include Nanoc::Helpers::Rendering

class Cell
  attr_accessor :opts

  def initialize(value = nil, opts = {})
    @value = value
    @opts = opts
  end

  def value
    @value
  end

  def colspan
    @opts[:span] || 1
  end

  def classes
    @opts[:class]
  end
end

class Row
  def initialize(data = [], opts = {})
    @data = data
    @opts = opts
  end

  def label
    @opts[:label]
  end

  def classes
    @opts[:class]
  end

  def cells
    @data.map do |d|
      unless d.is_a? Cell
        Cell.new(d)
      else
        d
      end
    end
  end
end
