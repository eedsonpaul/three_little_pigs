module LoginHelper
  def time
    time = Time.new
    time = time.strftime("%b %d, %Y")
  end
end
