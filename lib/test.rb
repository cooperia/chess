class Dog
  def path_array(a_ranged, position)
    path_array = []
    (a_ranged.first.next...a_ranged.last).each do |entry|
      path_array.push(Coordinate.new(entry))
    end
    if path_array.length > 6
      path_array.reject { |entry|  }
    end
    path_array
  end
end