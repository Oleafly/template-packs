#import "rr-metadata.typ": rr_metadata
#import "@preview/tidy:0.2.0"

#let capitalize(x) = {
    return upper(x.at(0)) + x.slice(1, x.len())
}

// Safe get from dict
#let get(config, key) = {
    if key in config.keys() {
        config.at(key)
    } else {
        none
    }
}

/// This function returns all the files in a given folder from our metadata.
///
/// - folder_name (string): A path to a folder
/// -> array
#let get_files_in_folder(folder_name) = {
    if rr_metadata.file_tree.keys().contains(folder_name) {
        return rr_metadata.file_tree.at(folder_name).map(at => folder_name + "/" + at);
    } else {
        return ();
    }
}

/// This function returns all folders defined in a given folder from the metadata.
///
/// - folder_name (string): A path to a folder
/// -> array
#let get_folders_in_root_folder(folder_name) = {
    if folder_name == none {
        return ()
    }

    rr_metadata.file_tree.keys().filter(x => x.contains(folder_name)).map(folder_path => folder_path.split("/").at(-1))
}

/// Resolve a user-specified section order against the list of folders on disk.
/// Panics if any listed entry doesn't match a real folder (typo protection).
/// Folders present on disk but not listed are silently excluded — opt-in filtering.
#let resolve_section_order(user_order, on_disk) = {
    for section in user_order {
        if not on_disk.contains(section) {
            panic("section_order contains \"" + section + "\" but no such folder exists; found: " + on_disk.join(", "))
        }
    }
    return user_order
}

/// This function will return the rr_metadata of a file, given a filename.
///
/// - file_name (string): A path to a file.
/// -> dictionary
#let get_rr_metadata(file_name) = {
    let rr_metadata = rr_metadata.file_metadata.at(file_name)
    rr_metadata.filename = file_name
    return rr_metadata
}

/// This function will take in an rr_metadata dictionary and attempt to retrieve the key.
/// If it can not find that key, then it will return a verbose error message specifying which file
/// is missing the key in its metadata
///
/// - rr_metadata (dictionary): An rr_metadata dictionary
/// - key (string): The key to attempt to retrieve
/// -> dictionary, array, string
#let get_from_rr_metadata(rr_metadata, key) = {
    if rr_metadata.keys().contains(key) {
        return rr_metadata.at(key)
    } else {
        panic(rr_metadata.filename + " is missing " + key)
    }
}

/// This function will retrieve the 'updates' key from an rr_metadata object.
///
/// - rr_metadata (dictionary): An rr_metadata dictionary
/// -> dictionary
#let get_updates(rr_metadata) = {
    return get_from_rr_metadata(rr_metadata, "updates")
}

/// This function will, given a file_name, return it's content and rr_metadata as a dict.
///
/// - file_name (string): A path to a file.
/// -> dictionary
#let get_file(file_name) = {
    return (
        content: include "/" + file_name,
        rr_metadata: get_rr_metadata(file_name),
    )
}

/// If you want a caption below a figure without formatting, this is what you would use.
///
/// - caption (string): A string of the caption you would like
/// -> content
#let figure_caption(caption) = figure("", gap: 0cm, caption: caption)
