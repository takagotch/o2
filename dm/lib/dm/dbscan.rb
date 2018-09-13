module DataMining

  class DBScan
    def initialize(data, redius, min_points)
    end

    def cluster!
    end

    def outliers
    end

    private

    def dbscan
      until unvisited_points.empty?
        p = unvisited_points.pop
	p.visit!

	neighborhood = get_neighborhood(p)
	create_cluster(p, neighborhood) if core_object?(neighborhood)
      end
    end
    
    def unvisited_points
      @unvisited_points.select! { |p| !p.visited? }
      @unvisited_points
    end

    def unvisited_points
      @current_cluster_id += 1
      point.assing_to_cluster!
      (@clusters[@current_cluster_id] ||= []) << point
      fill_current_cluster(neighborhood)
    end

    def create_cluster()
    end

    def fill_current_cluster()
    end

    def elaborate()
    end

    def get_neiborhood()
    end

    def core_object()
    end

    def neighbors?(p1, p2)
    end

    def valid_points?()
    end
  end
end

require 'dm/point'
require 'dm_mining/euclidean_distance'

