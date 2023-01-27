module ApplicationHelper

  include UsersHelper
  include SessionsHelper

  def make_select_form(array)
    array.map { |element| [element.name, element.id] }
  end

end
