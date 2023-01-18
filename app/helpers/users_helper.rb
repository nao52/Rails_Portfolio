module UsersHelper

  def make_array(array)
    (array.map { |element| [element.name, element.id] }).insert(0, ["選択してください", nil])
  end

end
