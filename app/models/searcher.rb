class Searcher


  class QueryBuilder



    def init(options)
      
      # Search clause that will be built
      @clause = ['']

      # This tracks appends to clause, to 
      # help avoid the leading OR
      @clause_count = 0

      # this tracks how many args we must add on.
      # eg. name LIKE ? OR name LIKE ? , arg1, arg2
      # vs: name LIKE ?, arg1
      @terms_count = 1

      # we will assume that we have at least one
      # of two cases.  The query_builder will
      # not be called if both are missing.
      if options[:name] && options[:description]
        @chunk = "name LIKE ? OR description LIKE ? "
        @terms_count = 2
      elsif !options[:name] && options[:description]
        @chunk = "description LIKE ? "
      else
        @chunk = "name LIKE ? "
      end

      return self
    end

    def add_clause(term)

      @clause[0] << @chunk
      @terms_count.times {@clause << ('%' + term + '%')}


      # We left off the leading
      # OR on the first chunk,
      # but the rest need it.
      if @clause_count == 0
        @chunk = "OR " << @chunk
        @clause_count = 1
      end

    end

    def clause
      @clause
    end

  end

  def self.advanced(query, options)
    
    # this will take care of the painful 
    # OR statement business.
    query_builder = QueryBuilder.new.init(options)
   
    if options[:name] or options[:description]

      query.split(' ').each do |term|
        query_builder.add_clause(term) unless term.nil?
      end

    end

    # because category can be set as all,
    # detect the case and set it as a wildcard.
    # We will have to use a LIKE for categories.
    if options[:category] == 'all'
      options[:category] = '%'
    end

    results =  Product.where(query_builder.clause).where(
      ['price > ? AND price < ? and category LIKE ?',
        options[:price_minimum],
        options[:price_maximum],
        options[:category]])

    return results || []
     
  end

end
