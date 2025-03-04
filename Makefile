local:
	bundle exec jekyll serve --host 0.0.0.0
proxy:
	export HTTP_PROXY=http://10.1.0.115:7890
	export HTTPS_PROXY=http://10.1.0.115:7890
unproxy:
	unset http_proxy
	unset https_proxy
	unset ftp_proxy
	unset no_proxy
install: unproxy
	bundle install