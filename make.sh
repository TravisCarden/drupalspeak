#!/usr/bin/env sh

project_name="drupalspeak"
word_list_file="wordlist.txt"
dictionary_file="$project_name.dic"
affix_file="$project_name.aff"

check_dependencies() {
  # Abort if 'munch' isn't available.
  if ! command -v munch >/dev/null 2>&1; then
    if command -v apt-get >/dev/null 2>&1; then
      echo >&2 "This script requires 'hunspell-tools', which is currently not installed. You can install it by typing:"
      echo >&2 "sudo apt-get install hunspell-tools"
    else
      echo >&2 "This script requires 'hunspell-tools', which is currently not installed."
    fi
    exit 1
  fi
}

normalize_source_word_list() {
  # Alphabetize and remove duplicates.
  sort -uo "$word_list_file" "$word_list_file"
  # Remove extraneous blank lines.
  sed -i '/^[[:space:]]*$/d' "$word_list_file"
}

create_dictionary_file_from_source_word_list() {
  # Munch (encode/compress) word list.
  munch "$word_list_file" "$affix_file" > "$dictionary_file" 2> /dev/null
}

check_dependencies
normalize_source_word_list
create_dictionary_file_from_source_word_list
