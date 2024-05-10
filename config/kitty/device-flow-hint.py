import re
import subprocess

def mark(text, args, Mark, extra_cli_args, *a):
    # This function is responsible for finding all
    # matching text. extra_cli_args are any extra arguments
    # passed on the command line when invoking the kitten.
    # We mark all individual device codes for potential selection
    for idx, m in enumerate(re.finditer(r'\b([A-Z0-9]{4}-[A-Z0-9]{4})(\b)', text)):
        start, end = m.span()
        mark_text = text[start:end].replace('\n', '').replace('\0', '')
        # The empty dictionary below will be available as groupdicts
        # in handle_result() and can contain string keys and arbitrary JSON
        # serializable values.
        yield Mark(idx, start, end, mark_text, {})


def handle_result(args, data, target_window_id, boss, extra_cli_args, *a):
    # This function is responsible for performing some
    # action on the selected text.
    # matches is a list of the selected entries and groupdicts contains
    # the arbitrary data associated with each entry in mark() above
    matches, groupdicts = [], []
    for m, g in zip(data['match'], data['groupdicts']):
        if m:
            matches.append(m), groupdicts.append(g)

    for word, match_data in zip(matches, groupdicts):
        # Copy the word to the clipboard by shelling out to pbcopy
        subprocess.run("pbcopy", text=True, input=word)
        # will open the provided url in the system browser
        boss.open_url(f'https://github.com/login/device')
