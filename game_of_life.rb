class Game
  LIVE = [2,3]
  BORN = [3]

  attr_accessor :grid, :cols, :rows

  def initialize(cols, rows)
    @cols, @rows = cols, rows
    @grid = build_grid
  end

  def load(*cells)
    cells.each {|y,x| grid[y][x] = 1}
  end

  def to_s
    grid.inject('') do |s, rows|
      rows.each {|cell| s << cell.to_s}
      s << "\n"
    end
  end

  def live_neighbors_count(y,x)
    neighbors(y,x).select {|cell| cell == 1}.size
  end

  def tick
    new_grid = build_grid
    grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        count = live_neighbors_count(y,x)
        new_grid[y][x] = begin
          if cell.zero?
            BORN.include?(count) ? 1 : 0
          else
            LIVE.include?(count) ? 1 : 0
          end
        end
      end
    end
    @grid = new_grid
  end

  private

  def build_grid
    Array.new(rows) { Array.new(cols, 0) }
  end

  def neighbors(y, x)
    (-1..1).inject [] do |values, py|
      (-1..1).each do |px|
        unless py == 0 and px == 0
          i = y + py
          j = x + px
          i = 0 unless i < rows
          j = 0 unless j < cols
          values << grid[i][j]
        end
      end
      values
    end
  end
end
