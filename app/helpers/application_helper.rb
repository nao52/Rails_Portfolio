module ApplicationHelper

  include UsersHelper
  include SessionsHelper

  def make_select_form(object)
    object.map { |element| [element.name, element.id] }
  end

end
