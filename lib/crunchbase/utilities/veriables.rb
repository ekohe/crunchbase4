# frozen_string_literal: true

module Crunchbase
  # Utilities
  module Utilities
    # Veriables
    module Veriables
      # Description of operators
      QUERY_OPERATORS = {
        'blank' => 'Blank',
        'eq' => 'Equal',
        'not_eq' => 'Not equal',
        'gt' => 'Greater than',
        'gte' => 'Greater than or equal',
        'lt' => 'Less than',
        'lte' => 'Less than or equal',
        'starts' => 'Starts',
        'contains' => 'Contains',
        'between' => 'Between',
        'includes' => 'Includes',
        'not_includes' => 'Does not include',
        'includes_all' => 'Includes all',
        'not_includes_all' => 'Does not include all'
      }.freeze

      COMPANY_TYPES = {
        'for_profit' => 'For Profit',
        'non_profit' => 'Non-profit'
      }.freeze

      FACET_IDS = {
        'company' => 'Company',
        'investor' => 'Investor',
        'school' => 'School'
      }.freeze

      IPO_STATUS = {
        'delisted' => 'Delisted',
        'private' => 'Private',
        'public' => 'Public'
      }.freeze

      FUNDING_STAGES = {
        'early_stage_venture' => 'Early Stage Venture',
        'ipo' => 'IPO',
        'late_stage_venture' => 'Late Stage Venture',
        'm_and_a' => 'M&A',
        'private_equity' => 'Private Equity',
        'seed' => 'Seed'
      }.freeze

      FUNDING_TYPES = {
        'angel' => 'Angel',
        'convertible_note' => 'Convertible Note',
        'corporate_round' => 'Corporate Round',
        'debt_financing' => 'Debt Financing',
        'equity_crowdfunding' => 'Equity Crowdfunding',
        'grant' => 'Grant',
        'initial_coin_offering' => 'Initial Coin Offering',
        'non_equity_assistance' => 'Non-equity Assistance',
        'post_ipo_debt' => 'Post-IPO Debt',
        'post_ipo_equity' => 'Post-IPO Equity',
        'post_ipo_secondary' => 'Post-IPO Secondary',
        'pre_seed' => 'Pre-Seed',
        'private_equity' => 'Private Equity',
        'product_crowdfunding' => 'Product Crowdfunding',
        'secondary_market' => 'Secondary Market',
        'seed' => 'Seed',
        'series_a' => 'Series A',
        'series_b' => 'Series B',
        'series_c' => 'Series C',
        'series_d' => 'Series D',
        'series_e' => 'Series E',
        'series_f' => 'Series F',
        'series_g' => 'Series G',
        'series_h' => 'Series H',
        'series_i' => 'Series I',
        'series_j' => 'Series J',
        'series_unknown' => 'Venture - Series Unknown',
        'undisclosed' => 'Undisclosed'
      }.freeze

      CURRENCY_ENUM = %w[
        AED AFN ALL AMD ANG AOA ARS AUD AWG AZN BAM BBD BDT BGN BHD
        BIF BMD BND BOB BRL BSD BTN BWP BYN BYR BZD CAD CDF CHF CLF
        CLP CNY COP CRC CUC CUP CVE CZK DJF DKK DOP DZD EGP ERN ETB
        EUR FJD FKP GBP GEL GHS GIP GMD GNF GTQ GYD HKD HNL HRK HTG
        HUF IDR ILS INR IQD IRR ISK JMD JOD JPY KES KGS KHR KMF KPW
        KRW KWD KYD KZT LAK LBP LKR LRD LSL LTL LVL LYD MAD MDL MGA
        MKD MMK MNT MOP MRO MUR MVR MWK MXN MYR MZN NAD NGN NIO NOK
        NPR NZD OMR PAB PEN PGK PHP PKR PLN PYG QAR RON RSD RUB RWF
        SAR SBD SCR SDG SEK SGD SHP SKK SLL SOS SRD SSP STD SVC SYP
        SZL THB TJS TMT TND TOP TRY TTD TWD TZS UAH UGX USD UYU UZS
        VEF VND VUV WST XAF XAG XAU XBA XBB XBC XBD XCD XDR XOF XPD
        XPF XPT YER ZAR ZMK ZMW xts
      ].freeze

      DATE_PRECISIONS = %w[none year month day].freeze

      LAYOUT_IDS = {
        'default' => 'Default Layout',
        'investor' => 'Investor Layout',
        'school' => 'School Layout'
      }.freeze

      NUM_EMPLOYEES_ENUM = {
        'c_00001_00010' => '1-10',
        'c_00011_00050' => '11-50',
        'c_00051_00100' => '51-100',
        'c_00101_00250' => '101-250',
        'c_00251_00500' => '251-500',
        'c_00501_01000' => '501-1000',
        'c_01001_05000' => '1001-5000',
        'c_05001_10000' => '5001-10000',
        'c_10001_max' => '10001+'
      }.freeze

      OPERATING_STATUS = {
        'active' => 'Active',
        'closed' => 'Closed'
      }.freeze

      PROGRAM_TYPES = {
        'on_site' => 'On-Site',
        'online' => 'Online'
      }.freeze

      REVENUE_RANGES = {
        'r_00000000' => 'Less than $1M',
        'r_00001000' => '$1M to $10M',
        'r_00010000' => '$10M to $50M',
        'r_00050000' => '$50M to $100M',
        'r_00100000' => '$100M to $500M',
        'r_00500000' => '$500M to $1B',
        'r_01000000' => '$1B to $10B',
        'r_10000000' => '$10B+'
      }.freeze

      SCHOOL_METHODS = {
        'on_compus' => 'On Campus',
        'online' => 'Online',
        'online_and_on_campus' => 'Online and On Campus'
      }.freeze

      SCHOOL_METHODS = {
        'bootcamp' => 'Bootcamp',
        'community_college' => 'Community College',
        'four_year_university' => 'Four Year University',
        'graduate_university' => 'Graduate University',
        'high_school' => 'High School',
        'trade_school' => 'Trade School',
        'two_year_university' => 'Two Year University'
      }.freeze

      SCHOOL_TYPES = {
        'for_profit_private' => 'Private',
        'non_profit_private' => 'Private (Non-Profit)',
        'public' => 'Public'
      }.freeze

      STATUS = {
        'closed' => 'Closed',
        'ipo' => 'IPO',
        'operating' => 'Operating',
        'was_acquired' => 'Was Acquired'
      }.freeze

      STOCK_EXCHANGE_SYMBOLS = {
        'adx' => 'ADX - Abu Dhabi Securities Exchange',
        'afx' => 'AFX - Afghanistan Stock Exchange',
        'altx' => 'ALTX - ALTX East Africa Exchange',
        'amex' => 'AMEX - American Stock Exchange',
        'ams' => 'AMS - Euronext Amsterdam',
        'amx' => 'AMX - Armenia Securities Exchange',
        'asce' => 'ASCE - Abuja Securities and Commodities Exchange',
        'asx' => 'ASX - Australian Securities Exchange',
        'ath' => 'ATH - Athens Stock Exchange',
        'bcba' => 'BCBA - Buenos Aires Stock Exchange',
        'bdp' => 'BDP - Budapest Stock Exchange',
        'belex' => 'BELEX - Belgrade Stock Exchange',
        'ber' => 'BER - Berliner Börse',
        'bfb' => 'BFB - Baku Stock Exchange',
        'bit' => 'BIT - Italian Stock Exchange',
        'bkk' => 'BKK - Thailand Stock Exchange',
        'blse' => 'BLSE - Banja Luka Stock Exchange',
        'bme' => 'BME - Madrid Stock Exchange',
        'bmv' => 'BMV - Mexican Stock Exchange',
        'bom' => 'BOM - Bombay Stock Exchange',
        'brvm' => 'BRVM - Regional Securities Exchange SA',
        'bse' => 'BSE - Bulgarian Stock Exchange',
        'bse_lb' => 'BSE - Beirut Stock Exchange',
        'bsse' => 'BSSE - Bratislava Stock Exchange',
        'bsx' => 'BSX - Bermuda Stock Exchange',
        'bvb' => 'BVB - Bucharest Stock Exchange',
        'bvc' => 'BVC - Colombian Stock Exchange',
        'bvfb' => 'BVFB - Belarusian Currency and Stock Exchange',
        'bvm' => 'BVM - Montevideo Stock Exchange',
        'bvmf' => 'B3 - Brazil Stock Exchange and OTC Market',
        'bvmt' => 'BVMT - Tunis Stock Exchange',
        'bx' => 'BX - Berne Stock Exchange',
        'cas' => 'CAS - Casablanca Stock Exchange',
        'cise' => 'CISE - Channel Islands Stock Exchange',
        'cnsx' => 'CNSX - Canadian National Stock Exchange',
        'col' => 'COL - Colombo Stock Exchange',
        'cph' => 'CPH - Copenhagen Stock Exchange',
        'cse' => 'CSE - Canadian Securities Exchange',
        'cse_cy' => 'CSE - Cyprus Stock Exchange',
        'csx' => 'CSX - Cambodia Securities Exchange',
        'cve' => 'TSX-V - Toronto TSX Venture Exchange',
        'dfm' => 'DFM - Dubai Financial Market',
        'dse' => 'DSE - Dhaka Stock Exchange',
        'dsx' => 'DSX - Douala Stock Exchange',
        'dus' => 'DUS - Börse Düsseldorf',
        'ebr' => 'EBR - Euronext Brussels',
        'egx' => 'EGX - Egypt Stock Exchange',
        'eli' => 'ELI - Euronext Lisbon',
        'epa' => 'EPA - Euronext Paris',
        'etr' => 'ETR - Deutsche Börse XETRA',
        'eurex' => 'EUREX - Eurex Exchange',
        'fra' => 'FRA - Frankfurt Stock Exchange',
        'fwb' => 'FWB - Börse Frankfurt Stock Exchange',
        'gha' => 'GHA - Ghana Stock Exchange',
        'gsx' => 'GSX - Georgian Stock Exchange',
        'gsx_gi' => 'GSX - Gibraltar Stock Exchange',
        'hel' => 'HEL - Helsinki Stock Exchange',
        'hkg' => 'HKG - Hong Kong Stock Exchange',
        'hnx' => 'HNX - Hanoi Stock Exchange',
        'hose' => 'HOSE - Ho Chi Minh Stock Exchange',
        'ice' => 'ICE - Iceland Stock Exchange',
        'idx' => 'IDX - Indonesia Stock Exchange',
        'iex' => 'IEX - Investors Exchange',
        'ifb' => 'IFB - Iran Fara Bourse',
        'ime' => 'IME - Iran Mercantile Exchange',
        'irenex' => 'IRENEX - Iran Energy Exchange',
        'ise' => 'ISE - Irish Stock Exchange',
        'ist' => 'IST - Istanbul Stock Exchange',
        'isx' => 'ISX - Iraq Stock Exchange',
        'jp' => 'JP - Japan Exchange',
        'jsc' => 'JSC - Belarusian Currency and Stock Exchange',
        'jse' => 'JSE - Johannesburg Stock Exchange',
        'jse_jam' => 'JSE - Jamaica Stock Exchange',
        'kase' => 'KASE - Kazakhstan Stock Exchange',
        'klse' => 'KLSE - Malaysia Stock Exchange',
        'kosdaq' => 'KOSDAQ - Korean Securities Dealers Automated Quotations',
        'krx' => 'KRX - Korea Stock Exchange',
        'kse' => 'KSE - Kuwait Stock Exchange',
        'lje' => 'LJE - Ljubljana Stock Exchange',
        'lse' => 'LSE - London Stock Exchange',
        'lsm' => 'LSM - Libyan Stock Market',
        'lsx' => 'LSX - Lao Securities Exchange',
        'luse' => 'LuSE - Lusaka Securities Exchange',
        'luxse' => 'LuxSE - Luxembourg Stock Exchange',
        'mal' => 'MAL - Malta Stock Exchange',
        'mcx' => 'MCX - Multi Commodity Exchange of India',
        'meff' => 'MEFF - Mercado Spanish Financial Futures Market',
        'mnse' => 'MNSE - Montenegro Stock Exchange',
        'moex' => 'MOEX - Moscow Exchange',
        'mse' => 'MSE - Metropolitan Stock Exchange',
        'mse_md' => 'MSE - Moldova Stock Exchange',
        'mse_mk' => 'MSE - Macedonian Stock Exchange',
        'msei' => 'MSEI - Metropolitan Stock Exchange of India',
        'msm' => 'MSM - Muscat Securities Market',
        'mun' => 'MUN - Börse München',
        'nasdaq' => 'NASDAQ',
        'nbo' => 'NSE - Nairobi Securities Exchange',
        'neeq' => 'NEEQ - National Equities Exchange and Quotations',
        'nepse' => 'NEPSE - Nepal Stock Exchange',
        'nex' => 'NEX - NEX Exchange',
        'ngm' => 'NGM - Nordic Growth Market Exchange',
        'nig' => 'NIG - Nigerian Stock Exchange',
        'notc' => 'NOTC - Norwegian OTC',
        'npex' => 'NPEX - NPEX Stock Exchange',
        'nse' => 'NSE - National Stock Exchange of India',
        'nsx' => 'NSX - National Stock Exchange of Australia',
        'nyse' => 'NYSE - New York Stock Exchange',
        'nysearca' => 'NYSEARCA - NYSE Arca',
        'nysemkt' => 'NYSEAMERICAN - NYSE American',
        'nze' => 'NZE - New Zealand Stock Exchange',
        'ose' => 'OSE - Oslo Stock Exchange',
        'otcbb' => 'OTCBB - FINRA OTC Bulletin Board',
        'otcpink' => 'OTC Pink',
        'otcqb' => 'OTCQB',
        'otcqx' => 'OTCQX',
        'pdex' => 'PDEx - Philippine Dealing Exchange',
        'pex' => 'PEX - Palestine Exchange',
        'pfts' => 'PFTS - PFTS Ukraine Stock Exchange',
        'pomsox' => 'POMSoX - Port Moresby Stock Exchange',
        'prg' => 'PRA - Prague Stock Exchange',
        'pse' => 'PSE - Philippine Stock Exchange',
        'psx' => 'PSX - Pakistan Stock Exchange',
        'qse' => 'QSE - Qatar Stock Exchange',
        'rfb' => 'RFB - Riga Stock Exchange',
        'rse' => 'RSE - Rwanda Stock Exchange',
        'rsebl' => 'RSEBL - Royal Securities Exchange of Bhutan',
        'sase' => 'SASE - Sarajevo Stock Exchange',
        'sbx' => 'SBX - BX Swiss',
        'sehk' => 'SEHK - The Stock Exchange of Hong Kong',
        'sem' => 'SEM - Stock Exchange of Mauritius',
        'sgbv' => 'SGBV - Algiers Stock Exchange',
        'sgx' => 'SGX - Singapore Stock Exchange',
        'six' => 'SIX - SIX Swiss Exchange',
        'spbex' => 'SPBEX - Saint Petersburg Stock Exchange',
        'spse' => 'SPSE - South Pacific Stock Exchange',
        'sse' => 'SSE - Shanghai Stock Exchange',
        'ssx' => 'SSX - Sydney Stock Exchange',
        'sto' => 'STO - Stockholm Stock Exchange',
        'stu' => 'STU - Börse Stuttgart',
        'swx' => 'SWX - SIX Swiss Exchange',
        'szse' => 'SZSE - Shenzhen Stock Exchange',
        'tadawul' => 'Tadawul - Saudi Stock Exchange',
        'tal' => 'TSE - Tallinn Stock Exchange',
        'tfex' => 'TFEX - Thailand Futures Exchange',
        'tise' => 'TISE - The International Stock Exchange',
        'tlv' => 'TLV - Tel Aviv Stock Exchange',
        'tpe' => 'TWSE - Taiwan Stock Exchange',
        'tse_al' => 'TSE - Tirana Stock Exchange',
        'tse_ir' => 'TSE - Tehran Stock Exchange',
        'tsec' => 'TWO - Taiwan OTC Exchange',
        'tsx' => 'TSX - Toronto Stock Exchange',
        'ttse' => 'TTSE - Trinidad and Tobago Stock Exchange',
        'tyo' => 'TYO - Tokyo Stock Exchange',
        'use' => 'USE - Uganda Securities Exchange',
        'ux' => 'UX - Ukrainian Exchange',
        'vie' => 'VIE - Vienna Stock Exchange',
        'vmf' => 'VMF - Faroese Securities Market',
        'vse' => 'VSE - Vancouver Stock Exchange',
        'wse' => 'WSE - Warsaw Stock Exchange',
        'ysx' => 'YSX - Yangon Stock Exchange',
        'zamace' => 'ZAMACE - Zambian Commodity Exchange',
        'zse' => 'ZSE - Zimbabwe Stock Exchange',
        'zse_hr' => 'ZSE - Zagreb Stock Exchange'
      }.freeze
    end
  end
end
