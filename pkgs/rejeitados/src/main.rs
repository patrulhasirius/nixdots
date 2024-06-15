use std::fs;

fn main() {
    let paths = fs::read_dir("./").unwrap();

    paths.for_each(|f| {
        let f_path = f.expect("file not found").path();

        let fixed_path: String;

        if f_path.is_file() {
            fixed_path = f_path
                .file_name()
                .unwrap()
                .to_str()
                .unwrap()
                .chars()
                .skip(6)
                .collect();

            fs::rename(
                format!("../../uau/{}", fixed_path).to_string(),
                format!("./{}", fixed_path).to_string(),
            )
            .map_err(|err| eprintln!("{}: {}", err, fixed_path));
        }
    });
}
