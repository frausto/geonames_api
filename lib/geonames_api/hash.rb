class Hash
  def to_url
    "?" + collect { |key, value| "#{key}=#{value}" }.join("&")
  end
end