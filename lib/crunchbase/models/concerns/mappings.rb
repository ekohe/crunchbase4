# frozen_string_literal: true

module Crunchbase
  # Get the Organization data from API
  module Models
    # Build card mappings
    module Mappings
      def model_mappings
        {
          'investments' => Investment,
          'raised_investments' => Investment,
          'participated_investments' => Investment,
          'participated_funds' => Fund,
          'raised_funds' => Fund,
          'child_organizations' => Organization,
          'parent_organization' => Organization,
          'investors' => Principal,
          'raised_funding_rounds' => FundingRound,
          'participated_funding_rounds' => FundingRound,
          'ipos' => Ipo,
          'event_appearances' => EventAppearance,
          'acquiree_acquisitions' => Acquisition,
          'parent_ownership' => Ownership,
          'child_ownerships' => Ownership,
          'jobs' => Job,
          'founders' => Person,
          'press_references' => PressReference,
          'headquarters_address' => Address
        }
      end

      def card_num_field(card_id)
        field_ids & ["num_#{card_id}"]
      end
    end
  end
end
