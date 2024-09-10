# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the Principal data from API
    class Principal < Entity
      RESOURCE_LIST = 'principals'

      def field_ids
        %w[
          category_groups
          created_at
          delisted_on
          description
          died_on
          entity_def_id
          equity_funding_total
          exited_on
          facet_ids
          first_name
          founded_on
          founder_identifiers
          funding_stage
          funding_total
          gender
          hub_tags
          identifier
          image_id
          image_url
          investor_identifiers
          ipo_status
          last_equity_funding_total
          last_equity_funding_type
          last_funding_at
          last_funding_total
          last_funding_type
          last_name
          layout_id
          location_group_identifiers
          location_identifiers
          num_alumni
          num_articles
          num_employees_enum
          num_enrollments
          num_event_appearances
          num_exits
          num_exits_ipo
          num_founded_organizations
          num_founders
          num_funding_rounds
          num_funds
          num_investments
          num_investments_funding_rounds
          num_investors
          num_jobs
          num_lead_investments
          num_lead_investors
          num_partner_investments
          num_portfolio_organizations
          program_application_deadline
          program_duration
          program_type
          rank_delta_d30
          rank_delta_d7
          rank_delta_d90
          rank_principal
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

      def basis_fields
        %w[
          name
          uuid
          website
          short_description
          operating_status
          permalink
          permalink_aliases
          phone_number
          primary_job_title
          primary_organization
          contact_email
          aliases
          born_on
          closed_on
          categories
          company_type
          linkedin
          twitter
          facebook
          investor_stage
          investor_type
        ]
      end

      def full_cards
        %w[]
      end
    end
  end
end
