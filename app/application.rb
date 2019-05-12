class Application

  @@items = ["Apples","Carrots","Pears"]

  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    case req.path_info
    when /items/
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    when /search/
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    when /cart/
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item_in_cart|
          resp.write "#{item_in_cart}\n"
        end
      end
    when /add/
      item = req.params["item"]
      resp.write add_to_cart(item)
    else
      resp.write "Path Not Found"
    end
    # if req.path.match(/items/)
    #   @@items.each do |item|
    #     resp.write "#{item}\n"
    #   end
    # elsif req.path.match(/search/)
    #   search_term = req.params["q"]
    #   resp.write handle_search(search_term)
    # else
    #   resp.write "Path Not Found"
    # end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def add_to_cart(item)
    if @@items.include?(item)
      @@cart << item
      return "added #{item}"
    else
      return "We don't have that item"
    end
  end
end
