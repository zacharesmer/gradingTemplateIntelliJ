import os

def get_bb_name(f):
    # trim everything after the blackboard name
    new = f.split("_attempt")[0]
    # trim everything before the blackboard name
    new = new.split("_")[-1] 
    return new

extension = ".zip"
for f in os.listdir():
    # rename all folders
    if os.path.isdir(f):
        new = get_bb_name(f)
    # and all zip files
    elif f.endswith(extension):
        new = get_bb_name(f) + extension
    os.rename(f, new)

