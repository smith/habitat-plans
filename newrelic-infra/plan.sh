pkg_name=newrelic-infra
pkg_origin=smith
pkg_version="1.0.726"
pkg_maintainer="Nathan L Smith <smith@nlsmith.com>"
pkg_license=('UNLICENSED')
pkg_source="https://download.newrelic.com/infrastructure_agent/linux/apt/pool/main/n/$pkg_name/${pkg_name}_systemd_${pkg_version}_amd64.deb"
pkg_shasum="9fe9331e0f9f67a949e0ffa49586a00fc7b5972ecbf7730d55bec624e3a120df"
pkg_deps=(core/cacerts core/gcc-libs core/glibc)
pkg_build_deps=(core/dpkg core/patchelf)
pkg_bin_dirs=(bin)
pkg_svc_user="root"
pkg_svc_group="$pkg_svc_user"
pkg_description="Infrastructure monitoring agent for New Relic"
pkg_upstream_url="https://docs.newrelic.com/docs/infrastructure/new-relic-infrastructure"

do_unpack() {
  dpkg --extract "$pkg_filename" "$CACHE_PATH"
}

do_build() {
  for bin in newrelic-infra newrelic-infra-inject; do
    patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
      --set-rpath "$LD_RUN_PATH" \
      "$CACHE_PATH/usr/bin/$bin"
  done
}

do_install() {
  cp  "$CACHE_PATH/usr/bin/"* "$pkg_prefix/bin"
  cp -R "$CACHE_PATH/usr/share" "$pkg_prefix/share"
  cp -R "$CACHE_PATH/var" "$pkg_prefix/var"
}

do_strip() {
  return 0
}
