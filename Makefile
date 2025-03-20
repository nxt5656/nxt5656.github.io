serve: build
	mdbook serve -p 4000 -n 10.1.0.101
init:
	mdbook init
build:
	mdbook-admonish install
	mdbook build
install:
	cargo install mdbook-linkcheck  mdbook-katex
	mdbook --version
	mdbook-katex --version
	mdbook-linkcheck --version