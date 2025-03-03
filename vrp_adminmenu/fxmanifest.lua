fx_version 'cerulean'
games { 'gta5' }

description "Admin Menu Utils by maneaa."
version '1.0.0'


shared_script {
  "@vrp/lib/utils.lua"
}

server_script {
	"vrp.lua"
}

client_scripts {
	'client.lua'
}

files{
	"cfg/cfg.lua"
}
