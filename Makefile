serve:
	docker stop gitbook 2>/dev/null || true
	docker run --rm -d --name gitbook -p 4000:4000 -v $(CURDIR)/notes:/srv/gitbook fellah/gitbook:latest gitbook serve
init:
	docker run --rm -ti -v $(CURDIR)/notes:/srv/gitbook fellah/gitbook:latest gitbook init
	sudo chown -R zhangbo:zhangbo ./notes/
build:
	docker run --rm -ti --user $(id -u):$(id -g) -v $(CURDIR)/notes:/srv/gitbook fellah/gitbook:latest gitbook build
