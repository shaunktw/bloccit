module ApplicationHelper
  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'form_group has-error'
    else
      content_tag :div, capture(&block), class: 'form_group'
    end
  end
end
