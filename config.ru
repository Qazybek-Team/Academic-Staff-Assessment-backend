# frozen_string_literal: true

ASAAPI_APP_ROOT = File.dirname __FILE__

$: << File.join(ASAAPI_APP_ROOT, 'src')

require 'asaapi/app'

run ASAAPI::App
