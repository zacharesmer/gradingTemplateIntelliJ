import os

def get_bb_name(f):
    # trim everything after the blackboard name
    new = f.split("_attempt")[0]
    # trim everything before the blackboard name
    new = new.split("_")[-1] 
    return new

zip_extension = ".zip"
txt_extension = ".txt"
for f in os.listdir():
    # rename all folders
    if os.path.isdir(f):
        new = get_bb_name(f)
    # and all zip files
    elif f.endswith(zip_extension):
        new = get_bb_name(f) + zip_extension
    # and text files
    elif f.endswith(txt_extension):
        new = get_bb_name(f) + txt_extension
    else:
        break
    os.rename(f, new)

