FactoryGirl.define do
  factory :recipe do
    sequence(:name) {|n| "thank you beery much#{n}"}
    notes 'best. beer. ever.'
    batch_size 2
    boil_size 3
    boil_time 4
    original_gravity 5.5
    final_gravity 4.5
    alcohol_by_volume 6.7
    bitterness 8
    color 9
    keg_temp 42
    storage_temp 54
    age_for 32
  end
end
