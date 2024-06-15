{rustPlatform}:
rustPlatform.buildRustPackage {
  pname = "clean_uau";
  version = "0.1.0";

  src = ./.; # edit paths as needed
  cargoLock.lockFile = ./Cargo.lock;
}
