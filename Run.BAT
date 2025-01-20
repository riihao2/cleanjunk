import os
import shutil
import time

def clean_temp_files(temp_dir, age_limit_days=7):
    """
    Cleans temporary files older than the specified age limit.

    Args:
        temp_dir: The path to the temporary directory.
        age_limit_days: The number of days after which files are considered old.
    """

    current_time = time.time()
    for root, dirs, files in os.walk(temp_dir):
        for file in files:
            file_path = os.path.join(root, file)
            file_age = (current_time - os.path.getmtime(file_path)) / (24 * 60 * 60)  # Age in days

            if file_age > age_limit_days:
                try:
                    os.remove(file_path)
                    print(f"Removed: {file_path}")
                except OSError as e:
                    print(f"Error removing {file_path}: {e}")

        for dir in dirs:
            dir_path = os.path.join(root, dir)
            try:
                shutil.rmtree(dir_path)
                print(f"Removed directory: {dir_path}")
            except OSError as e:
                print(f"Error removing directory {dir_path}: {e}")

if __name__ == "__main__":
    temp_dir = os.environ.get("TEMP")  # Get the system's temp directory
    if temp_dir:
        clean_temp_files(temp_dir)
    else:
        print("Could not determine the system's temp directory.")