import os
import shutil

def delete_files_and_directories(curDir, delPaths):

    for path in delPaths:
        full_path = os.path.join(current_directory, path)

        if not os.path.exists(full_path):
            print(f"Warning: '{path}' does not exist in the current directory.")
            continue

        if os.path.isfile(full_path):
            print(f"Deleting file: {full_path}")
            os.remove(full_path)
        elif os.path.isdir(full_path):
            print(f"Deleting directory: {full_path}")
            shutil.rmtree(full_path, ignore_errors=True)
        else:
            print(f"Warning: Unable to delete '{path}' as it is neither a file nor a directory.")


# EntryPunkt 
if __name__ == "__main__":
    # Read the file containing file and directory paths to delete
    file_paths_file =  os.path.join(os.getcwd(), "cleanuplist.txt").replace("\\", "/")

    # Current Directory wird geholt.
    current_directory =  os.getcwd()
    print (file_paths_file)

    with open(file_paths_file, "r") as f:
        paths = f.read().splitlines()

    try:
        delete_files_and_directories(current_directory, paths)
    except FileNotFoundError:
        print(f"Error: '{file_paths_file}' not found.")
    except Exception as e:
        print(f"Error: An error occurred while processing the file: {e}")
