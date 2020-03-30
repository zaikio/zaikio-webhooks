class MyJob < ApplicationJob
  def perform(event)
    puts event.to_h.inspect
  end
end
