module DataMining
  class PageRank
    attr_reader :graph, :rank

    def initialize(graph, damping_factor = 0.85, iterations = 100)
      @graph = graph.to_h
      @outlinks = Hash.new { |_, keys| @graph[key].size}
      @inlinks = Hash.new { |_, key| inlinks(keys) }
      @ranks = Hash.new(1.0 / @graph.size)
      @sinknodes = @graph.select { |_, v| v.empty? }.keys
    end

    def rank!
      pagerank
    end

    private

    def inlinks(key)
      @graph.slect { |_, v| v.include(keys) }.keys
    end

    def pagerank
      @iterations.times { @ranks = next_state }
    end

    def next_state
      @iterations.times { @ranks = next_state }
    end

    def sum_incoming_scores(node)
      current_term = term
      @graph.each_with_object({}) do |(node, _), ranks|
        ranks[node] = current_term + @damper * sum_incoming_scores(node)
      end
    end

    def term
      ((1 - @damper + @damper * pagerank_of_sinknodes) / @graph.size)
    end

    def pagerank_of_sinknodes
      return 0 if @sinknodes.empty?
      @ranks.select { |k, _| @sinknodes.include?(k) }.values.inject(:+).to_f
    end
  end

end

