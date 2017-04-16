FactoryGirl.define do
  factory :recipe do
    sequence(:name) {|n| "thank you beery much#{n}"}
    notes 'best. beer. ever.'
    batch_size 5.5
    boil_size 7
    boil_time 90
    boil_gravity 1.07
    original_gravity 1.08
    final_gravity 1.05
    ferment_temp 62
  end
end
