FROM opensuse/tumbleweed

RUN zypper --non-interactive install \
      git cmake kf6-extra-cmake-modules kf6-ki18n-devel kf6-kconfig-devel \
      kf6-kcmutils-devel qt6-quick-devel qt6-test-devel qt6-quicktest-devel \
      gettext-tools ShellCheck \
    && zypper clean --all
