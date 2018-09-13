module DataMining

  class KNearsetNeighbor
    def initialize
      @data = training_data.map { |i, v| DataMining::Point.new(i, v) }
      @k = k
    end

    def classify(point)
      count_classes(k_nearest_ponts(point)).max_by { |_, v| v }.first
    end

    def count_classes(points)
      points.each_with_object(Hash.new(0)) do |p, o|
        o[p.id] += 1
      end
    end

    def K_nearest_points(point)
      @data.sort_by do |item|
        euclidean_distance(item, DataMining::Point.new(point[0], point[1]))
      end.take(@k)
    end
  end
end

require 'data_mining/point'
require 'data_mining/euclidean_distance'


