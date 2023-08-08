# frozen_string_literal: true

module ApplicationHelper
  def paginate(params, &block)
    metadata = PaginationViewModel.new(params)
    results = block.call(limit: metadata.limit, offset: metadata.offset)

    metadata.total = results[:total]

    [
      metadata,
      results[:items],
    ]
  end
end
