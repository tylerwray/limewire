# frozen_string_literal: true

class PaginationViewModel
  DEFAULT = { page: 1, limit: 7 }.freeze

  attr_accessor :page, :total, :limit

  def initialize(params = {})
    @page     = (params[:page] || DEFAULT[:page]).to_i
    @total    = params[:total]
    @limit = params[:limit] || DEFAULT[:limit]
  end

  def offset
    return 0 if page == 1

    limit * (page.to_i - 1)
  end

  def next_page
    return total_pages if last_page?

    page + 1
  end

  def previous_page
    return 1 if first_page?

    page - 1
  end

  def last_page?
    page == total_pages
  end

  def first_page?
    page == 1
  end

  def total_pages
    (total / limit.to_f).ceil
  end
end
