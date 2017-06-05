pkg_name=json-server
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_deps=(core/node)
pkg_build_deps=(core/jq-static core/sed)
pkg_bin_dirs=(bin)
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)
pkg_description="Get a full fake REST API with zero coding in less than 30 seconds (seriously)"
pkg_upstream_url="https://github.com/typicode/json-server"

pkg_version() {
  if [[ -n "$HAB_NONINTERACTIVE" ]]; then
    npm config set progress=false
  fi

  npm view "$pkg_name" --json | jq --raw-output .version
}

do_before() {
  update_pkg_version
}

do_build() {
  return 0
}

do_install() {
  npm install --global --prefix="$pkg_prefix" "$pkg_name@$pkg_version"
  sed -i -e "1c#!$(pkg_path_for node)/bin/node" \
    "$pkg_prefix/lib/node_modules/$pkg_name/bin/index.js"
}

do_strip() {
  return 0
}
