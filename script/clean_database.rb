# clean month-old events

SendgridEvent.where('created_at < ?',1.month.ago).limit(10000).each do |event|
  event.destroy
end