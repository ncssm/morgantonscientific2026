#!/bin/bash

# Usage: ./generate_summary.sh <output_file> <editors_page> <directory_path_1> ... <directory_path_n>

OUTPUT_FILE=$1
EDITORS_PAGE=$2
shift 2         # Shift to remove the first two arguments, leaving the base directories

# Reads title, author names and first_page out of a myst.yml and writes one
# table of contents entry. Handles the frontmatter styles used in this repo:
# plain, quoted and folded (">-") scalars, over one line or several. Values are
# written as single-quoted YAML so that colons, quotes and "#" in a title cannot
# break the file.
read_entry() {
    awk -v sq="'" '
        function trim(s) { sub(/^[ \t]+/, "", s); sub(/[ \t]+$/, "", s); return s }
        # Undo the escaping of a double-quoted scalar: \" and \\ stand for a
        # quote and a backslash, other escapes are left as written
        function unescape(s, out, i, c, d) {
            for (i = 1; i <= length(s); i++) {
                c = substr(s, i, 1)
                d = substr(s, i + 1, 1)
                if (c == "\\" && (d == "\"" || d == "\\")) { out = out d; i++ }
                else out = out c
            }
            return out
        }
        function unquote(s) {
            if (s ~ /^".*"$/) {
                s = unescape(substr(s, 2, length(s) - 2))
            } else if (s ~ "^" sq ".*" sq "$") {
                s = substr(s, 2, length(s) - 2)
                gsub(sq sq, sq, s)
            }
            return s
        }
        function emit(s) { gsub(sq, sq sq, s); return sq s sq }

        # A key of the project itself, i.e. indented by exactly two spaces. Any
        # such line ends the block the previous key may have opened.
        /^  [A-Za-z_][A-Za-z0-9_]*:/ {
            key = $0; sub(/^  /, "", key); sub(/:.*$/, "", key)
            value = trim(substr($0, index($0, ":") + 1))
            block = ""
            if (key == "title" && !have_title) {
                # ">-", "|", etc. mean the value is on the following lines
                if (value ~ /^[>|][0-9+-]*$/) block = "title"
                else title = unquote(value)
                have_title = 1
            } else if (key == "authors") {
                block = "authors"
            } else if (key == "first_page") {
                page = value
            }
            next
        }

        # Continuation lines of a folded/literal title, joined into one line
        block == "title" && /^    [^ ]/ {
            title = (title == "" ? trim($0) : title " " trim($0))
        }

        block == "authors" && /^ *- +name:/ {
            name = unquote(trim(substr($0, index($0, ":") + 1)))
            authors = (authors == "" ? name : authors ", " name)
        }

        END {
            print "- title: " emit(title)
            if (authors != "") print "  author: " emit(authors)
            print "  page: " (page == "" ? "0" : page)
        }
    ' "$1"
}

# Initialize the summary output file. The editors note is the last page of the
# frontmatter, so make_pdfs.sh passes that page number in.
echo "- title: 'Words from the Editors'" > "$OUTPUT_FILE"
echo "  page: ${EDITORS_PAGE:-0}" >> "$OUTPUT_FILE"

# Iterate over all provided base directories
for BASE_DIR in "$@"; do
    # Check if the base directory exists
    if [ ! -d "$BASE_DIR" ]; then
        echo "Base directory '$BASE_DIR' not found. Skipping."
        continue
    fi

    echo "Processing base directory: $BASE_DIR"

    # Iterate over all subdirectories in the base directory
    for folder in "$BASE_DIR"/; do
        yaml_file="${folder}myst.yml"

        # Check if the YAML file exists in the current folder
        if [ ! -f "$yaml_file" ]; then
            echo "YAML file '$yaml_file' not found in folder '$folder'. Skipping."
            continue
        fi

        # Extract the entry fields from YAML and write them to the summary file
        read_entry "$yaml_file" >> "$OUTPUT_FILE"
    done
done

echo "Summary file '$OUTPUT_FILE' generated successfully!"
