# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the person data from API
    class Person < Entity
      RESOURCE_LIST = 'people'

      def field_ids
        %w[
          born_on
          created_at
          died_on
          entity_def_id
          facebook
          facet_ids
          first_name
          gender
          identifier
          image_id
          image_url
          investor_stage
          investor_type
          last_name
          layout_id
          linkedin
          location_group_identifiers
          location_identifiers
          middle_name
          num_articles
          num_current_advisor_jobs
          num_current_jobs
          num_event_appearances
          num_exits
          num_exits_ipo
          num_founded_organizations
          num_investments
          num_investments_funding_rounds
          num_jobs
          num_lead_investments
          num_partner_investments
          num_past_advisor_jobs
          num_past_jobs
          num_portfolio_organizations
          num_relationships
          override_layout_id
          primary_job_title
          primary_organization
          rank_delta_d30
          rank_delta_d7
          rank_delta_d90
          rank_person
          rank_principal
          rank_principal_investor
          short_description
          twitter
          updated_at
        ] + basis_fields
      end

      def basis_fields
        %w[
          uuid
          permalink
          permalink_aliases
          name
          aliases
          website
          rank
          short_description
          description
        ]
      end

      def full_cards
        %w[
          partner_funding_rounds
          participated_funds
          participated_investments
          degrees
          primary_job
          founded_organizations
          event_appearances
          jobs
          participated_funding_rounds
          fields
          press_references
          primary_organization
          partner_investments
        ]
      end
    end
  end
end
