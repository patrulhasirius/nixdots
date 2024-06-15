{rustPlatform}:
rustPlatform.buildRustPackage {
  pname = "rejeitados";
  version = "0.1.0";

  src = ./.; # edit paths as needed
  cargoLock.lockFile = ./Cargo.lock;
}
