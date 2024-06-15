use jwalk::WalkDir;
use std::env;
use std::fs;

fn main() {
    let files = WalkDir::new(env::current_dir().unwrap())
        .into_iter()
        .filter_map(|e| e.ok());
    for file in files {
        if file.path().is_file() {
            if file.path().file_stem().unwrap().len() != 20 {
                println!("{}", file.path().file_stem().unwrap().to_str().unwrap());
                fs::rename(
                    file.path(),
                    format!(
                        "/run/media/lucas/raid/OneDrive/aa/{}",
                        file.path().file_name().unwrap().to_str().unwrap()
                    ),
                )
                .unwrap();
            }
        }
    }
}
