FROM nixos/nix
ARG NIX_CHANNEL=nixos-19.09
ARG SBT_VERSION=1.3.8

RUN nix-channel --add https://nixos.org/channels/$NIX_CHANNEL nix
RUN nix-channel --update

RUN nix-env --quiet --no-build-output -iA nix.jdk
RUN nix-env --quiet --no-build-output -iA nix.coursier

RUN coursier bootstrap --quiet --standalone sbt-launcher -o bin/sbt

# Download all necessary files at once
RUN sbt -q -sbt-version $SBT_VERSION exit

ENTRYPOINT ["sbt"]
