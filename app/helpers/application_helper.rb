module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    icon = (column == sort_column) ? (sort_direction == "asc" ? "▲" : "▼") : ""
    link_to "#{title} #{icon}".html_safe, { sort: column, direction: direction }
  end

  private

  def sort_column
    Inquiry.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
