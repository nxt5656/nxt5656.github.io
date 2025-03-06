serve: stop install
	docker run -d --name gitbook -p 4000:4000 -v $(CURDIR)/notes:/srv/gitbook fellah/gitbook:latest gitbook serve
init: stop install
	docker run --rm -ti -v $(CURDIR)/notes:/srv/gitbook fellah/gitbook:latest gitbook init
	sudo chown -R zhangbo:zhangbo ./notes/
build: stop install
	docker run --rm -ti  -v $(CURDIR)/notes:/srv/gitbook fellah/gitbook:latest gitbook build
install:
	docker run --rm -ti  -v $(CURDIR)/notes:/srv/gitbook fellah/gitbook:latest gitbook install
stop:
	docker stop gitbook 2>/dev/null || true
	docker rm gitbook 2>/dev/null || true