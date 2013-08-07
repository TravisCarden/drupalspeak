#!/usr/bin/env sh

# Abort if 'munchlist' isn't available.
if ! command -v munchlist >/dev/null 2>&1; then
  echo >&2 "This script requires 'ispell', which is currently not installed. Aborting."
  exit 1
fi

word_list_file="wordlist.txt"
dictionary_file="drupalspeak.dic"

normalize_source_word_list() {
  # Alphabetize and remove duplicates.
  sort -uo "$word_list_file" "$word_list_file"
  # Remove extraneous blank lines.
  sed -i '/^[[:space:]]*$/d' "$word_list_file"
}

create_dictionary_file_from_source_word_list() {
  # Munch (compress) word list.
  munchlist "$word_list_file" > "$dictionary_file"
  # Prepend line count to dictionary file.
  sed -i -e "1i `wc -l < ${dictionary_file}`" "$dictionary_file"
}

normalize_source_word_list
create_dictionary_file_from_source_word_list
