game 'common'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

fx_version 'adamant'

mono_rt2 'Prerelease expiring 2024-06-30. See https://aka.cfx.re/mono-rt2-preview for info.'

lua54 'yes'
use_experimental_fxv2_oal 'yes'

files { "ui/index.html" }

ui_page { "ui/index.html" }

client_scripts { 'bin/Client/*.dll', "test.lua" }

server_scripts { 'bin/Server/*.dll' }
