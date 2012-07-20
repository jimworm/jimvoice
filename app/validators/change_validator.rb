class ChangeValidator < ActiveModel::EachValidator
  # Enforce/prevent attribute change
  #
  # Example: Make attribute immutable once saved
  # validates :attribute, change: false, on: :update
  #
  # Example: Force attribute change on every save
  # validates :attribute, change: true
  
  def initialize(options)
    options[:change] = !(options[:with] === false)
    super
  end
  
  def validate_each(record, attribute, value)
    record.errors.add(attribute, "#{options[:change] ? 'must' : 'cannot'} be modified") unless record.public_send(:"#{attribute}_changed?") == options[:change]
  end
end
