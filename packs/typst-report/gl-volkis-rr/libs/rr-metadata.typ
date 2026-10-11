#let get_from_keys(config, keys) = {
    for key in keys {
        if key in config.keys() {
            return config.at(key);
        }
    }

    none
}

#let rr_metadata = (
    file_tree: json("./metadata/dir_tree.json"),
    file_metadata: json("./metadata/metadata.json")
)

#let config = {
    let first_line = read("/config").split("\n").at(0)

    if first_line.contains("JSON") {
        json("/config")
    } else if first_line.contains("TOML") {
        toml("/config")
    } else if first_line.contains("YAML") {
        yaml("/config")
    } else {
        json("/config") // Default to JSON for now
    }
}