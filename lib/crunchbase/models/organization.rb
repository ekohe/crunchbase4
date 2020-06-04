# frozen_string_literal: true

module Crunchbase
  # Get the Organization data from API
  module Models
    # Build Organization API
    class Organization < Entity
      RESOURCE_LIST = 'organizations'

      def basis_fields
        %w[
          uuid
          identifier
          permalink
          permalink_aliases
          name
          legal_name
          aliases
          website
          linkedin
          twitter
          rank_org
          short_description
          description
          rank_org_company
        ]
      end

      def field_ids
        %w[
          acquirer_identifier
          categories
          category_groups
          closed_on
          company_type
          contact_email
          created_at
          delisted_on
          demo_days
          entity_def_id
          equity_funding_total
          exited_on
          facebook
          facet_ids
          founded_on
          founder_identifiers
          funding_stage
          funding_total
          funds_total
          image_id
          image_url
          investor_identifiers
          investor_stage
          investor_type
          ipo_status
          last_equity_funding_total
          last_equity_funding_type
          last_funding_at
          last_funding_total
          last_funding_type
          layout_id
          listed_stock_symbol
          location_group_identifiers
          location_identifiers
          num_acquisitions
          num_alumni
          num_articles
          num_current_advisor_positions
          num_current_positions
          num_employees_enum
          num_enrollments
          num_event_appearances
          num_exits
          num_exits_ipo
          num_founder_alumni
          num_founders
          num_funding_rounds
          num_funds
          num_investments
          num_investments_funding_rounds
          num_investors
          num_lead_investments
          num_lead_investors
          num_past_positions
          num_portfolio_organizations
          num_relationships
          num_sub_organizations
          operating_status
          override_layout_id
          owner_identifier
          phone_number
          program_application_deadline
          program_duration
          program_type
          rank_delta_d30
          rank_delta_d7
          rank_delta_d90
          rank
          rank_org_school
          rank_principal
          rank_principal_investor
          revenue_range
          school_method
          school_program
          school_type
          status
          stock_exchange_symbol
          stock_symbol
          updated_at
          went_public_on
        ] + basis_fields
      end

      def full_cards
        %w[
          raised_investments
          participated_funds
          child_organizations
          participated_investments
          investors
          parent_organization
          raised_funding_rounds
          ipos
          event_appearances
          raised_funds
          acquiree_acquisitions
          acquirer_acquisitions
          parent_ownership
          jobs
          founders
          child_ownerships
          participated_funding_rounds
          press_references
          headquarters_address
        ]
      end
    end
  end
end
