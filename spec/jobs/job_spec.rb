require "rails_helper"

RSpec.describe ApplicationJob do
  feature "basic functions" do
     scenario "create new job" do
       expect(ApplicationJob.new.queue_name).to eq('default')
     end
   end
end
