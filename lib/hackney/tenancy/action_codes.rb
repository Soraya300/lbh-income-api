module Hackney
  module Tenancy
    module ActionCodes
      AUTOMATED_SMS_ACTION_CODE = 'GAT'.freeze
      AUTOMATED_EMAIL_ACTION_CODE = 'GAE'.freeze

      MANUAL_SMS_ACTION_CODE = 'GMS'.freeze
      MANUAL_EMAIL_ACTION_CODE = 'GME'.freeze

      # Codes for letters as follows:
      LETTER_1_IN_ARREARS_FH = 'LF1'.freeze
      LETTER_2_IN_ARREARS_FH = 'LF2'.freeze
      LETTER_1_IN_ARREARS_LH = 'LL1'.freeze
      LETTER_2_IN_ARREARS_LH = 'LL2'.freeze
      LETTER_1_IN_ARREARS_SO = 'LS1'.freeze
      LETTER_2_IN_ARREARS_SO = 'LS2'.freeze
    end
  end
end
