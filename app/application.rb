class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    req = Rack::Request.new(env)
    resp = Rack::Response.new


    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/add/)
      search_item = req.params["item"]
      if @@items.include?(search_item)
        @@cart << search_item
        resp.write "added #{search_item}"
      else
        resp.write "We don't have that item"
      end

    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    end

    resp.finish
  end





end
