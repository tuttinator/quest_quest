module QuestQuest
  module Models
    class Grid
      attr_reader :rows, :columns
      # has_many cells

      def initialize(rows, columns)
        @rows, @columns = rows, columns
        @grid = Array.new(rows) do |row|
          Array.new(columns) do |column|
            Cell.new
          end
        end
      end

      def as_json
        rows.times.map do |row|
          columns.times.map do |column|
            @grid[row][column].contents.as_json if @grid[row][column].contents
          end
        end
      end

      def method_missing(method_name, *args, &block)
        @grid.send method_name, *args, &block
      end

      def [](*coordinates)
        raise 'Requires at least one coordinate' if coordinates.length == 0
        y, x = coordinates
        x.nil? ? @grid[y] : @grid[x][y]
      end

      def place(thing)
        x = rand(@columns)
        y = rand(@rows)
        if @grid[x][y].contents
          place(thing)
        else
          @grid[x][y].contents = thing
          thing.coordinates = [x, y]
        end
      end

      def find(thing)
        rows.times.each do |row|
          columns.times.each do |column|
            { row: row,  column: column } if thing == self[row, column]
          end
        end
      end
    end
  end
end
